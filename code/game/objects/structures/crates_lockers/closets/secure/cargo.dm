/obj/structure/closet/secure_closet/quartermaster
	name = "\proper quartermaster's locker"
	req_access = list(ACCESS_QM)
	icon_state = "qm"

/obj/structure/closet/secure_closet/quartermaster/PopulateContents()
	..()
	new /obj/item/clothing/neck/cloak/qm(src)
	new /obj/item/storage/lockbox/medal/cargo(src)
	new /obj/item/clothing/under/rank/cargo/quartermaster(src)
	//new /obj/item/clothing/under/rank/cargo/quartermaster/skirt(src) //NSV13 no skirts
	new /obj/item/clothing/under/rank/cargo/quartermaster/turtleneck(src)
	//new /obj/item/clothing/under/rank/cargo/quartermaster/turtleneck/skirt(src) //NSV13 no skirts
	new /obj/item/clothing/shoes/sneakers/brown(src)
	new /obj/item/radio/headset/headset_quartermaster(src)
	new /obj/item/clothing/suit/fire/firefighter(src)
	new /obj/item/clothing/gloves/fingerless(src)
	new /obj/item/megaphone/cargo(src)
	new /obj/item/tank/internals/emergency_oxygen(src)
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/clothing/head/soft/cargo(src)
	new /obj/item/clothing/head/beret/supply(src) // NSV13 - berets are cool
	new /obj/item/export_scanner(src)
	new /obj/item/door_remote/quartermaster(src)
	new /obj/item/circuitboard/machine/techfab/department/cargo(src)
	new /obj/item/storage/photo_album/QM(src)
	new /obj/item/circuitboard/machine/ore_silo(src)
	new /obj/item/card/id/departmental_budget/car(src)
	new /obj/item/storage/box/radiokey/car(src)
