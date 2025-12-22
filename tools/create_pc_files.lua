#!/usr/libexec/flua

-- SPDX-License-Identifier: BSD-2-Clause
--
-- Copyright(c) 2025 The FreeBSD Foundation.
--
-- This software was developed by Tuukka Pasanen <tuukka.pasanen@ilmi.fi>
-- under sponsorship from the FreeBSD Foundation.
--
-- Generates .pc files to directories from FreeBSD-files.csv
--
-- Example using for this would be with normal Lua 5.4:
-- LUA_PATH="./tools/lua/?.lua;;" tools/create_pc_files.lua database.yml pkgconf subdir
-- LUA_PATH="./tools/lua/?.lua;;" tools/create_pc_files.lua database.yml markdown
--

local pkgconf = require("pkgconf")

if #arg <= 1 then
	print("Usage:\tcreate_pc_files.lua database.yml [pkgconf|markdown|deps] [subdir]\n")
	print("\tParses database.yml and creates pkfconfig files to pkgconfig or subdir\n")
	print("\tpkgconf  - write pkgconf files under pkgconfig dir or if parameter subdir under package['directory']")
	print("\t           which means for example usr.bin/accton/usr.bin.accton.pc or pkgconfig/accton.pc")
	print("\tmarkdown - Export Database information as Markdown table for for placing it to Github for example")
	print("\tdeps     - Check is all deps in database.yml are correct and they can be found inside YAML structure")
	os.exit(1)
end

local input_name = arg[1]

local yaml_obj, whole_packages = pkgconf.parse_database(input_name, false)

if yaml_obj == nil or whole_packages == nil then
	print("Can't open file: " .. input_name)
	os.exit(1)
end

local is_pc_subdir = false

-- If subdir is in command line paramters
-- then .pc files are not placed under pkgconfig.
-- They are placed under directory-key directory
-- and named like usr.bin.accton.pc
if arg[3] ~= nil and arg[3] == "subdir" then
	is_pc_subdir = true
end

if arg[2] == nil or arg[2] == "pkgconf" then
	local meta_package = {}

	for key, value in pairs(whole_packages) do
		local dir_name = "pkgconfig"
		if is_pc_subdir then
			dir_name = value["directory"]

			if dir_name == nil then
				dir_name = "./"
			end

			if type(dir_name) == "table" then
				dir_name = value["directory"][1]
			end
		end
		local name_str = key

		local output_filename = name_str .. ".pc"
		if is_pc_subdir then
			output_filename = string.gsub(dir_name, "/", ".") .. ".pc"
		end
		local output_full = dir_name .. "/" .. output_filename
		table.insert(meta_package, string.lower(name_str))

		print("Write to PC-file to '" .. output_full .. "'")
		pkgconf.write_pkgconfig(
			output_full,
			name_str,
			value["description"],
			value["homepage"],
			value["version"],
			value["license"],
			value["source"],
			value["depends"],
			value["owner"]
		)
	end
	-- Write FreeBSD metapackage which holds every pkgconfig and make sure that
	-- that we can create whole SBOM
	table.sort(meta_package)
	pkgconf.write_pkgconfig(
		"pkgconfig/FreeBSD.pc",
		"FreeBSD",
		"Power to serve",
		"https://www.freebsd.org/",
		"15.0",
		"NOASSERTION",
		"https://cgit.freebsd.org/src/",
		meta_package
	)
elseif arg[2] ~= nil and arg[2] == "markdown" then
	local markdown_license_table = {}
	local markdown_noassertion_table = {}
	local markdown_what_license_table = {}
	local markdown_license_count = 0
	local markdown_noassertion_count = 0

	for key, value in pairs(whole_packages) do
		local markdown_str = "| " .. key .. " | "
		markdown_str = pkgconf.add_value(markdown_str, "Description", value["description"], true)
		markdown_str = pkgconf.add_value(markdown_str, "Version", value["version"], true)
		markdown_str = pkgconf.add_value(markdown_str, "License", value["license"], true)
		markdown_str = pkgconf.add_value(markdown_str, "Directory", value["directory"], true)
		markdown_str = pkgconf.add_value(markdown_str, "Homepage", value["homepage"], true)
		markdown_str = pkgconf.add_value(markdown_str, "Section", value["section"], true)
		markdown_str = pkgconf.add_value(markdown_str, "Source", value["source"], true)
		markdown_str = pkgconf.add_value(markdown_str, "Upstream", value["upstream"], true)

		local add_str = pkgconf.depends_from_table(value["depends"], true)
		if add_str ~= nil then
			markdown_str = markdown_str .. add_str
		else
			markdown_str = markdown_str .. " | none"
		end

		add_str = pkgconf.maintainer_from_table(value["owner"], true)
		if add_str ~= nil then
			markdown_str = markdown_str .. " | " .. add_str .. " |"
		else
			markdown_str = markdown_str .. " | none |"
		end

		if value["license"] ~= "NOASSERTION" then
			table.insert(markdown_license_table, markdown_str)
			markdown_license_count = markdown_license_count + 1
			local license_str = value["license"]
			if license_str ~= nil and type(license_str) == "string" then
				if markdown_what_license_table[license_str] == nil then
					markdown_what_license_table[license_str] = 0
				end
				markdown_what_license_table[license_str] = markdown_what_license_table[license_str] + 1
			else
				print("License nil or table in: " .. key)
			end
		else
			table.insert(markdown_noassertion_table, markdown_str)
			markdown_noassertion_count = markdown_noassertion_count + 1
		end
	end

	local sorted_key_table = {}
	for key, _ in pairs(markdown_what_license_table) do
		table.insert(sorted_key_table, key)
	end

	table.sort(sorted_key_table)
	print(
		"# FreeBSD current licenses in files which have SPDX-License-Identifier (count: "
			.. markdown_license_count
			.. ")"
	)
	print("| License or combination | count |")
	print("| :--------------------: | :---: |")
	for _, key in ipairs(sorted_key_table) do
		print("| " .. key .. " | " .. markdown_what_license_table[key] .. " |")
	end

	print("\n")

	print("# FreeBSD tools with license information (count: " .. markdown_license_count .. ")")
	print(
		"| Name | Description | Version | License | Directory | Homepage | Section | Source | Upstream | Depends | Owner |"
	)
	print(
		"| :--: | :---------: | :-----: | :-----: | :-------: | :------: | :-----: | :----: | :------: | :-----: | :---: |"
	)

	table.sort(markdown_noassertion_table)
	table.sort(markdown_license_table)
	print(table.concat(markdown_license_table, "\n"))

	print(
		"\n# FreeBSD tools without license information but have man page (count: " .. markdown_noassertion_count .. ")"
	)
	print(
		"| Name | Description | Version | License | Directory | Homepage | Section | Source | Upstream | Depends | Owner |"
	)
	print(
		"| :--: | :---------: | :-----: | :-----: | :-------: | :------: | :-----: | :----: | :------: | :-----: | :---: |"
	)
	print(table.concat(markdown_noassertion_table, "\n"))
elseif arg[2] ~= nil and arg[2] == "deps" then
	for key, value in pairs(whole_packages) do
		if type(value["depends"]) == "string" then
			print("Depends is string not table: '" .. key .. "'")
		elseif value ~= value["depends"] and type(value["depends"]) == "table" then
			for _, subvalue in ipairs(value["depends"]) do
				local lower_string = string.lower(subvalue)
				if whole_packages[lower_string] == nil then
					print(subvalue)
				end
			end
		end
	end
end

os.exit(0)
