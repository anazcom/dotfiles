local jdtls = require("jdtls")

local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml" })
if root_dir == "" then
	return
end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. project_name

jdtls.start_or_attach({
	cmd = { "jdtls", "-data", workspace_dir },
	root_dir = root_dir,
	init_options = {
		bundles = {},
		extendedClientCapabilities = jdtls.extendedClientCapabilities,
	},
})
