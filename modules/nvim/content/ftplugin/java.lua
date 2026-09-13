local jdtls = require("jdtls")

--- Infers the Java package for a file living under a Maven/Gradle
--- `src/<main|test>/java` source root, e.g. `.../src/main/java/com/foo/Bar.java`
--- -> `com.foo`. Returns nil for files outside that convention (default package).
---@param fname string
---@return string|nil
local function package_from_path(fname)
	local dir = vim.fn.fnamemodify(fname, ":h")
	local marker = dir:match("(.*/src/[^/]+/java)$") or dir:match("(.*/src/[^/]+/java)/")
	if not marker then
		return nil
	end
	local rel = dir:sub(#marker + 2)
	if rel == "" then
		return nil
	end
	return (rel:gsub("/", "."))
end

--- True for a brand-new, still-empty, on-disk Java buffer (not a decompiled
--- class opened by jdtls from a jar, which uses a jdt:// URI and is also
--- unreadable on disk).
local function is_new_empty_file()
	local fname = vim.api.nvim_buf_get_name(0)
	if fname == "" or fname:match("^%a[%w+.-]*://") then
		return false
	end
	if vim.bo.buftype ~= "" or vim.fn.filereadable(fname) == 1 then
		return false
	end
	return vim.api.nvim_buf_line_count(0) == 1 and vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] == ""
end

--- Prompts for class/interface/record/enum and fills the new buffer with a
--- minimal skeleton (package declaration + type declaration).
local function insert_skeleton()
	local bufnr = vim.api.nvim_get_current_buf()
	local fname = vim.api.nvim_buf_get_name(bufnr)
	local class_name = vim.fn.fnamemodify(fname, ":t:r")
	local package_name = package_from_path(fname)

	vim.ui.select({ "class", "interface", "record", "enum" }, {
		prompt = "New Java type for " .. class_name .. ":",
	}, function(kind)
		if not kind or not vim.api.nvim_buf_is_valid(bufnr) then
			return
		end

		local lines = {}
		if package_name then
			table.insert(lines, "package " .. package_name .. ";")
			table.insert(lines, "")
		end

		local insert_line
		if kind == "record" then
			table.insert(lines, string.format("public record %s() {", class_name))
			table.insert(lines, "}")
			insert_line = #lines - 1
		else
			table.insert(lines, string.format("public %s %s {", kind, class_name))
			table.insert(lines, "")
			table.insert(lines, "}")
			insert_line = #lines - 1
		end

		vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
		vim.api.nvim_win_set_cursor(0, { insert_line, 0 })
		vim.cmd("startinsert!")
	end)
end

if is_new_empty_file() then
	-- switch_test_and_impl sets this when it creates a not-yet-existing test
	-- file itself, so we don't also prompt for class/interface/record/enum
	-- on top of the test skeleton it already inserts.
	if vim.g.java_skip_auto_skeleton then
		vim.g.java_skip_auto_skeleton = nil
	else
		insert_skeleton()
	end
end

local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml" })
if root_dir == "" then
	return
end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. project_name

--- Collects debug/test bundle jars installed via Mason (`:MasonInstall
--- java-debug-adapter java-test`), if present. Missing packages are silently
--- skipped so a fresh setup without them still starts jdtls.
local function mason_bundles()
	local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
	local bundles = {}

	local function add_glob(pattern)
		for _, jar in ipairs(vim.split(vim.fn.glob(pattern, true), "\n")) do
			if jar ~= "" then
				table.insert(bundles, jar)
			end
		end
	end

	add_glob(mason_packages .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar")
	add_glob(mason_packages .. "/java-test/extension/server/*.jar")

	return bundles
end

--- Fills the current (freshly opened, empty) buffer with a plain class
--- skeleton -- no prompt, since a test file is always a class.
local function insert_test_skeleton(class_name, package_name)
	local lines = {}
	if package_name then
		table.insert(lines, "package " .. package_name .. ";")
		table.insert(lines, "")
	end
	table.insert(lines, string.format("public class %s {", class_name))
	table.insert(lines, "")
	table.insert(lines, "}")

	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
	vim.api.nvim_win_set_cursor(0, { #lines - 1, 0 })
	vim.cmd("startinsert!")
end

--- Switches between a Maven/Gradle standard-layout impl class and its test
--- (`src/main/java/...Foo.java` <-> `src/test/java/...FooTest.java`). Going
--- to a test file that doesn't exist yet creates it with a class skeleton.
local function switch_test_and_impl()
	local fname = vim.api.nvim_buf_get_name(0)
	local dir, name = fname:match("(.*)/([^/]+)%.java$")
	if not dir then
		return
	end

	local target_dir, target_name, switching_to_test
	if dir:find("/src/test/java", 1, true) then
		target_dir = dir:gsub("/src/test/java", "/src/main/java", 1)
		target_name = name:gsub("Test$", "")
		switching_to_test = false
	else
		target_dir = dir:gsub("/src/main/java", "/src/test/java", 1)
		target_name = name .. "Test"
		switching_to_test = true
	end

	local target = target_dir .. "/" .. target_name .. ".java"
	local needs_skeleton = switching_to_test and vim.fn.filereadable(target) == 0

	if needs_skeleton then
		vim.g.java_skip_auto_skeleton = true
	end

	vim.cmd("edit " .. vim.fn.fnameescape(target))

	if needs_skeleton then
		insert_test_skeleton(target_name, package_from_path(target))
	end
end

--- Opens jdtls's "source action" menu (kind `source`), which is where
--- Generate Constructor/Getters&Setters/toString/hashCode&equals and
--- Override/Implement Methods live.
local function generate_source_action()
	require("tiny-code-action").code_action({
		context = { only = { "source" } },
	})
end

vim.keymap.set("n", "<leader>tt", switch_test_and_impl, { desc = "[T]oggle [T]est/Impl" })

jdtls.start_or_attach({
	cmd = { "jdtls", "-data", workspace_dir },
	root_dir = root_dir,
	init_options = {
		bundles = mason_bundles(),
		extendedClientCapabilities = jdtls.extendedClientCapabilities,
	},
	on_attach = function()
		-- Refactoring / codegen
		-- vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "Java: " .. desc })
		vim.keymap.set("n", "<leader>oi", jdtls.organize_imports, { desc = "Java: Organize Imports" })
		vim.keymap.set(
			"n",
			"<leader>ca",
			generate_source_action,
			{ desc = "Generate (ctor/getters/equals/override...)" }
		)

		-- map("n", "<leader>jt", jdtls.test_class, "Test Class")
		-- map("n", "<leader>jn", jdtls.test_nearest_method, "Test Nearest Method")
	end,
})
