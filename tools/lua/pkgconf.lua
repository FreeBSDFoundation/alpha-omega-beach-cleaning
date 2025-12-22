-- SPDX-License-Identifier: BSD-2-Clause
--
-- Copyright(c) 2025 The FreeBSD Foundation.
--
-- This software was developed by Tuukka Pasanen <tuukka.pasanen@ilmi.fi>
-- under sponsorship from the FreeBSD Foundation.
--
-- Module to help generate files and parse them
--

local lib_yaml = require("lyaml")

local git_url = "https://cgit.freebsd.org/src/tree/"
-- local git_url_addition = "?h=stable/15"
local git_url_addition = ""

local man_url = "https://man.freebsd.org/cgi/man.cgi?query="
-- local man_url_addition = "&manpath=FreeBSD+15.0-RELEASE"
local man_url_addition = ""

local pkgconf = {}

-------------------------------------------------------------------------------
-- Add value to Pkgconfig files parameter
-- they are like 'Name: somepackage'
-- @param orig_str Original string to be concated
-- @param name Name of parameter
-- @param value Value for parameter
-- @return Concated string with new 'Param: value' added
-------------------------------------------------------------------------------
function pkgconf.add_value(orig_str, name, value, is_markdown)
	local local_name = name
	local local_value = value

	if is_markdown == nil then
		is_markdown = false
	end

	if local_name == nil then
		local_name = "Could not parse name"
	end

	if local_value == nil then
		local_value = "Could not parse value"
	end

	if type(local_value) == "table" then
		local_value = ""
	end

	local rtn_str = orig_str .. local_name .. ": " .. local_value .. "\n"

	if is_markdown then
		rtn_str = orig_str .. " " .. local_value .. " |"
	end
	return rtn_str
end

-------------------------------------------------------------------------------
-- Create pkgconf file
-- @param name Name of package
-- @param description description of package
-- @param url Homepage for package
-- @param version Package version
-- @param license Package license
-- @param source Package source
-- @param deps_table Table of depends
-- @return Concated string or nil if problem
-------------------------------------------------------------------------------
function pkgconf.pkgconfig(name, description, url, version, license, source, deps_table)
	local pc_str = "# SPDX-License-Identifier: FreeBSD-DOC and LicenseRef-FreeBSD-SBOM\n"
	pc_str = pkgconf.add_value(pc_str, "Name", name)
	pc_str = pkgconf.add_value(pc_str, "Description", description)
	pc_str = pkgconf.add_value(pc_str, "URL", url)
	pc_str = pkgconf.add_value(pc_str, "Version", version)
	pc_str = pkgconf.add_value(pc_str, "License", license)
	pc_str = pkgconf.add_value(pc_str, "Source", source)
	if deps_table ~= nil then
		pc_str = pc_str .. pkgconf.depends_from_table(deps_table)
	end

	return pc_str
end

-------------------------------------------------------------------------------
-- Create pkgconf file
-- @param location Where should pkgconf file be written
-- @param name Name of package
-- @param description description of package
-- @param url Homepage for package
-- @param version Package version
-- @param license Package license
-- @param source Package source
-- @param deps_table Table of depends
-- @return Concated string or nil if problem
-------------------------------------------------------------------------------
function pkgconf.write_pkgconfig(location, name, description, url, version, license, source, deps_table)
	local pc_str = pkgconf.pkgconfig(name, description, url, version, license, source, deps_table)
	if type(location) == "string" then
		local output_handle = io.open(location, "w")

		if output_handle == nil then
			print("Can't open file: '" .. location .. "' for output")
			return false, nil
		else
			output_handle:write(pc_str)
			output_handle:close()
		end
	end
	return true, pc_str
end

-------------------------------------------------------------------------------
-- Return FreeBSD man URL for package
-- @param name Name of Man page wanted
-- @return Return URL to man page
-------------------------------------------------------------------------------
function pkgconf.man_url(name)
	local local_name = name

	if local_name == nil then
		local_name = "Could not parse name"
	end

	return man_url .. local_name .. man_url_addition
end

-------------------------------------------------------------------------------
-- Return Git URL for package
-- @param dir Git sub directory
-- @param name Name of git page wanted
-- @return Return URL to Git
-------------------------------------------------------------------------------
function pkgconf.git_url(dir, name)
	local local_name = name

	if local_name == nil then
		local_name = "Could not parse name"
	end

	return git_url .. dir .. git_url_addition
end

-------------------------------------------------------------------------------
-- Parse Makefile.depend file and return it as pkgconfig 'Requires'
-- @param dir Where to find Makefile.depend
-- @param name Package name
-- @return Return parsed Makefile.depend as pkgconfig Requires
-------------------------------------------------------------------------------
function pkgconf.depends_table(dir, name)
	if name == nil then
		print("pkgconf.depends: Nil name")
		return ""
	end

	local filename = dir .. "/" .. "Makefile.depend"

	local handle = io.open(filename, "r")

	if not handle then
		print("pkgconf.depends: Can't open file: " .. dir)
		return {}
	end

	-- set handle as default input
	io.input(handle)

	local is_dirdeps = false
	local deps_table = {}

	-- traverse through each lines
	for line in io.lines() do
		if string.len(line) == 0 then
			is_dirdeps = false
		end

		if is_dirdeps == true then
			-- Remove last '\' and remove first '\t'
			local cur_str = line:reverse():sub(3):reverse():sub(2)
			cur_str = cur_str:gsub("/", "."):gsub("${CSU_DIR}", "csu")
			local cur_dir = dir:gsub("/", ".")
			cur_str = cur_str:gsub("${DEP_RELDIR}", cur_dir)

			-- Currently these packages
			-- excluded from SBOM
			if
				cur_str:find("include") == nil
				and cur_str:find("usr.") == nil
				and cur_str:find("sbin.") == nil
				and cur_str:find("bin.") == nil
				and cur_str:find("secure.") == nil
				and cur_str:find("kerberos5.") == nil
				and cur_str:find("cddl.") == nil
				and cur_str:find("gnu.") == nil
				and cur_str:find(".host") == nil
			then
				table.insert(deps_table, cur_str)
			end
		end

		if line:find("DIRDEPS =") ~= nil then
			is_dirdeps = true
		end
	end

	io.close(handle)
	return deps_table
end

-------------------------------------------------------------------------------
-- Parse Makefile.depend file and return it as pkgconfig 'Requires'
-- @param dir Where to find Makefile.depend
-- @param name Package name
-- @return Return parsed Makefile.depend as pkgconfig Requires
-------------------------------------------------------------------------------
function pkgconf.depends(dir, name)
	local deps_table = pkgconf.depends_table(dir, name)
	local require_str = ""

	if type(deps_table) == "table" and #deps_table then
		require_str = table.concat(deps_table, " \\\n\t")
	elseif type(deps_table) == "string" then
		require_str = deps_table
	end

	return "Requires: " .. require_str .. "\n"
end

-------------------------------------------------------------------------------
-- Parse Makefile.depend file and return it as pkgconfig 'Requires'
-- @param dir Where to find Makefile.depend
-- @param name Package name
-- @return Return parsed Makefile.depend as pkgconfig Requires
-------------------------------------------------------------------------------
function pkgconf.depends_from_table(deps_table, is_markdown)
	if is_markdown == nil then
		is_markdown = false
	end

	local separator = " \\\n\t"
	if is_markdown then
		separator = ","
	end

	local require_str = ""
	if type(deps_table) == "table" and #deps_table then
		require_str = table.concat(deps_table, separator)
	else
		require_str = deps_table
	end

	if require_str == nil then
		return " none"
	end
	local rtn_str = "Requires: " .. string.lower(require_str) .. "\n"

	if is_markdown then
		rtn_str = " " .. require_str
	end

	return rtn_str
end

-------------------------------------------------------------------------------
-- Split line tiwh separator
-- @param line String to separate
-- @param sep Separator char
-- @return Return parsed Makefile.depend as pkgconfig Requires
-------------------------------------------------------------------------------
function pkgconf.split_line(line, sep)
	local rtn_table = {}
	if sep == nil then
		sep = "|"
	end
	for str in string.gmatch(line, "([^" .. sep .. "]+)") do
		table.insert(rtn_table, str)
	end
	return rtn_table
end

-------------------------------------------------------------------------------
-- Parse database to flattened version and return original and
-- flattened versio
-- @param location Location for YAML file
-- @param use_dir Use dir in key like usr.bin.ar not just ar
-- @return Original version
-- @return Return flattened version
-------------------------------------------------------------------------------
function pkgconf.parse_database(location, use_dir)
	local yaml_file = io.open(location, "r")

	local is_use_dir = use_dir or false

	if yaml_file == nil then
		return nil, nil
	end
	local yaml_content = yaml_file:read("*all")
	yaml_file:close()

	local yaml_obj = lib_yaml.load(yaml_content)
	yaml_content = nil

	local whole_packages = {}

	for _, v in pairs(yaml_obj["Sections"]) do
		for sk, sv in pairs(v) do
			local lowercase_name = ""
			if is_use_dir then
				if type(sv["directory"]) == "string" then
					lowercase_name = string.lower(sv["directory"])
				end
			else
				lowercase_name = string.lower(sk)
			end

			whole_packages[lowercase_name] = sv
			whole_packages[lowercase_name]["is_database_yml"] = 1
		end
	end

	return yaml_obj, whole_packages
end

return pkgconf
