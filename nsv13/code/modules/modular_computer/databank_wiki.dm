/datum/computer_file/program/databank
	filename = "databank"
	filedesc = "Vessel Databank Uplink"
	extended_desc = "An application used to connect to the Vessels Databanks in order to access all the guides you could ever need!"
	category = PROGRAM_CATEGORY_CREW
	program_icon_state = "generic"
	size = 2
	tgui_id = "NtosDatabank"
	program_icon = "book"

/datum/computer_file/program/databank/ui_data(mob/user)
	var/list/data = get_header_data()
	var/wikiurl = CONFIG_GET(string/wikiurl)

	data["src"] = wikiurl
	return data
