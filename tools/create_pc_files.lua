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
-- LUA_PATH="tools/lua/?.lua;;" lua tools/create_pc_files.lua database.yml
--

local pkgconf = require("pkgconf")

if #arg == 0 then
	print("Usage:\tcrate_sbom_pc_files.lua FreeBSD-apps.csv [OUTPUT-CSV]\n")
	print("\t\tParses CSV and creates pkfconfig files to subdirs\n")
	os.exit(1)
end

local input_name = arg[1]
local yaml_obj, whole_packages = pkgconf.parse_database(input_name, false)

if yaml_obj == nil or whole_packages == nil then
	print("Can't open file: " .. input_name)
	os.exit(1)
end

if arg[2] == nil or arg[2] == "pkgconf" then
	local meta_package = {}

	for key, value in pairs(whole_packages) do
		-- local dir_name = value["directory"]
		local dir_name = "pkgconfig"
		local name_str = key

		-- local output_filename = string.gsub(dir_name, "/", ".") .. ".pc"
		local output_filename = name_str .. ".pc"
		local output_full = dir_name .. "/" .. output_filename
		table.insert(meta_package, string.lower(name_str))

		pkgconf.write_pkgconfig(
			output_full,
			name_str,
			value["description"],
			value["homepage"],
			value["version"],
			value["license"],
			value["source"],
			value["depends"]
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
elseif arg[2] ~= nil and arg[2] == "csv" then
	print("# Name\tDescription\tVersion\tLicense\tDirectory\tHomepage\tSection\tSource\tUpstream\tDepends")
	local csv_table = {}

	for key, value in pairs(whole_packages) do
		local csv_str = '"' .. key .. '"'
		csv_str = pkgconf.add_value(csv_str, "Description", value["description"], true)
		csv_str = pkgconf.add_value(csv_str, "Version", value["version"], true)
		csv_str = pkgconf.add_value(csv_str, "License", value["license"], true)
		csv_str = pkgconf.add_value(csv_str, "Directory", value["directory"], true)
		csv_str = pkgconf.add_value(csv_str, "Homepage", value["homepage"], true)
		csv_str = pkgconf.add_value(csv_str, "Section", value["section"], true)
		csv_str = pkgconf.add_value(csv_str, "Source", value["source"], true)
		csv_str = pkgconf.add_value(csv_str, "Upstream", value["upstream"], true)
		csv_str = csv_str .. "\t" .. pkgconf.depends_from_table(value["depends"], true)
		table.insert(csv_table, csv_str)
	end

	table.sort(csv_table)
	print(table.concat(csv_table, "\n"))
elseif arg[2] ~= nil and arg[2] == "deps" then
	for key, value in pairs(whole_packages) do
		if type(value["depends"]) == "string" then
			print("Depends is string not table: '" .. key .. "'")
		elseif value ~= value["depends"] and type(value["depends"]) == "table" then
			for _, subvalue in ipairs(value["depends"]) do
				-- print(key, subvalue)
				local lower_string = string.lower(subvalue)
				if whole_packages[lower_string] == nil then
					-- print("Depend for '" .. key .. "': " .. subvalue)
					print(subvalue)
				end
			end
		end
	end
end

os.exit(0)
