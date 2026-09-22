local M = {}

--- Install an external binary via Mason if it's not already on $PATH.
---
--- Devcontainers often lack root/sudo, so tools like ripgrep may not be
--- installable via apt. Mason installs binaries into
--- ~/.local/share/nvim/mason/bin (no root needed) and require("mason").setup()
--- already prepends that dir to $PATH, so this just makes sure the package
--- is present once per environment.
---@param name string Mason package name (e.g. "stylua")
---@param bin? string Executable name to check on $PATH if it differs from `name`
function M.ensure_mason_binary(name, bin)
	bin = bin or name

	if vim.fn.executable(bin) == 1 then
		return
	end

	local ok, registry = pcall(require, "mason-registry")
	if not ok then
		return
	end

	registry.refresh(function()
		local pkg_ok, pkg = pcall(registry.get_package, name)
		if not pkg_ok or pkg:is_installed() then
			return
		end
		vim.notify(("Installing %s via Mason (not found on PATH)..."):format(name), vim.log.levels.INFO)
		pkg:install():once("closed", function()
			if pkg:is_installed() then
				vim.notify(("%s installed via Mason"):format(name), vim.log.levels.INFO)
			else
				vim.notify(("Failed to install %s via Mason"):format(name), vim.log.levels.WARN)
			end
		end)
	end)
end

-- Mason's registry only covers LSP servers/DAP adapters/linters/formatters,
-- not general CLI tools like ripgrep, so it can't be installed the same way
-- (Mason will error "Cannot find package"). Instead, fetch the static
-- binary release directly from GitHub and drop it into Mason's bin dir,
-- which is already prepended to $PATH.
local function platform_asset_suffix()
	local uname = vim.uv.os_uname()
	local sysname = uname.sysname
	local machine = uname.machine

	local table_ = {
		Linux = {
			x86_64 = "x86_64-unknown-linux-musl",
			aarch64 = "aarch64-unknown-linux-gnu",
		},
		Darwin = {
			x86_64 = "x86_64-apple-darwin",
			arm64 = "aarch64-apple-darwin",
		},
	}

	return vim.tbl_get(table_, sysname, machine)
end

--- Download and install a static ripgrep binary from its GitHub releases
--- into Mason's bin dir if `rg` isn't already on $PATH.
function M.ensure_ripgrep()
	if vim.fn.executable("rg") == 1 then
		return
	end

	local suffix = platform_asset_suffix()
	if not suffix then
		vim.notify("ensure_ripgrep: unsupported platform, install ripgrep manually", vim.log.levels.WARN)
		return
	end

	local bin_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin")
	vim.fn.mkdir(bin_dir, "p")

	vim.notify("ripgrep not found; downloading a static binary from GitHub...", vim.log.levels.INFO)

	vim.system(
		{ "curl", "-fsSL", "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest" },
		{ text = true },
		vim.schedule_wrap(function(api_result)
			if api_result.code ~= 0 then
				vim.notify(
					"ensure_ripgrep: failed to query GitHub releases: " .. (api_result.stderr or ""),
					vim.log.levels.WARN
				)
				return
			end

			local decode_ok, release = pcall(vim.json.decode, api_result.stdout)
			if not decode_ok then
				vim.notify("ensure_ripgrep: failed to parse GitHub API response", vim.log.levels.WARN)
				return
			end

			local asset
			for _, a in ipairs(release.assets or {}) do
				if a.name:find(suffix, 1, true) and a.name:match("%.tar%.gz$") then
					asset = a
					break
				end
			end
			if not asset then
				vim.notify(("ensure_ripgrep: no release asset found for %s"):format(suffix), vim.log.levels.WARN)
				return
			end

			local tmp_dir = vim.fn.tempname()
			vim.fn.mkdir(tmp_dir, "p")
			local tarball = vim.fs.joinpath(tmp_dir, asset.name)

			vim.system(
				{ "curl", "-fsSL", "-o", tarball, asset.browser_download_url },
				{},
				vim.schedule_wrap(function(dl_result)
					if dl_result.code ~= 0 then
						vim.notify("ensure_ripgrep: download failed: " .. (dl_result.stderr or ""), vim.log.levels.WARN)
						return
					end

					vim.system(
						{ "tar", "-xzf", tarball, "-C", tmp_dir },
						{},
						vim.schedule_wrap(function(tar_result)
							vim.fn.delete(tarball)
							if tar_result.code ~= 0 then
								vim.notify(
									"ensure_ripgrep: extraction failed: " .. (tar_result.stderr or ""),
									vim.log.levels.WARN
								)
								return
							end

							-- The tarball extracts to a single top-level dir containing `rg`;
							-- find it rather than hardcoding the versioned dir name.
							local found = vim.fn.systemlist({ "find", tmp_dir, "-type", "f", "-name", "rg" })
							local rg_path = found[1]
							if not rg_path or rg_path == "" then
								vim.notify("ensure_ripgrep: couldn't locate rg binary in archive", vim.log.levels.WARN)
								return
							end

							local dest = vim.fs.joinpath(bin_dir, "rg")
							vim.fn.rename(rg_path, dest)
							vim.uv.fs_chmod(dest, tonumber("755", 8))
							vim.fn.delete(tmp_dir, "rf")

							vim.notify(("ripgrep installed to %s"):format(dest), vim.log.levels.INFO)
						end)
					)
				end)
			)
		end)
	)
end

return M
