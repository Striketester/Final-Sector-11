/obj/item/stack/sheet
	name = "sheet"
	lefthand_file = 'icons/mob/inhands/misc/sheets_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/sheets_righthand.dmi'
	full_w_class = WEIGHT_CLASS_NORMAL
	force = 5
	throwforce = 5
	max_amount = 50
	throw_speed = 1
	throw_range = 3
	attack_verb = list("bashed", "battered", "bludgeoned", "thrashed", "smashed")
	novariants = FALSE
	var/perunit = MINERAL_MATERIAL_AMOUNT
	var/sheettype = null //this is used for girders in the creation of walls/false walls
<<<<<<< HEAD
	var/point_value = 0 //turn-in value for the gulag stacker - loosely relative to its rarity.
=======
	var/point_value = 0 //turn-in value for the gulag stacker - loosely relative to its rarity.
	var/turf_type = null //nsv13 - Wall stuff
>>>>>>> 6019aa33c0e954c94587c43287536eaf970cdb36
