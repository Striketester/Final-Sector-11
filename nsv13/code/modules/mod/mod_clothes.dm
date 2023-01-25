/obj/item/clothing/head/mod
	name = "MOD helmet"
	desc = "A helmet for a MODsuit."
	icon = 'nsv13/icons/obj/mod.dmi'
	icon_state = "helmet"
	worn_icon = 'nsv13/icons/mob/mod.dmi'
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 0, "fire" = 25, "acid" = 25)
	body_parts_covered = HEAD
	heat_protection = HEAD
	cold_protection = HEAD
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	clothing_flags = THICKMATERIAL|SHOWEROKAY|SNUG_FIT
	resistance_flags = NONE
	flash_protect = 0
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""
	flags_inv = HIDEFACIALHAIR
	flags_cover = NONE
	visor_flags = THICKMATERIAL|STOPSPRESSUREDAMAGE
	visor_flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT
	visor_flags_cover = HEADCOVERSMOUTH|HEADCOVERSEYES
	item_flags = IMMUTABLE_SLOW
	var/alternate_layer = NECK_LAYER
	var/obj/item/mod/control/mod

/obj/item/clothing/head/mod/Destroy()
	if(!QDELETED(mod))
		mod.helmet = null
		mod.mod_parts -= src
		QDEL_NULL(mod)
	return ..()

/obj/item/clothing/head/mod/obj_destruction(damage_flag)
	return mod.obj_destruction(damage_flag)

/obj/item/clothing/suit/mod
	name = "MOD chestplate"
	desc = "A chestplate for a MODsuit."
	icon = 'nsv13/icons/obj/mod.dmi'
	icon_state = "chestplate"
	worn_icon = 'nsv13/icons/mob/mod.dmi'
	blood_overlay_type = "armor"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 0, "fire" = 25, "acid" = 25)
	body_parts_covered = CHEST|GROIN
	heat_protection = CHEST|GROIN
	cold_protection = CHEST|GROIN
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	clothing_flags = THICKMATERIAL
	visor_flags = STOPSPRESSUREDAMAGE
	visor_flags_inv = HIDEJUMPSUIT
	resistance_flags = NONE
	item_flags = IMMUTABLE_SLOW
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals)
	var/obj/item/mod/control/mod

/obj/item/clothing/suit/mod/Destroy()
	if(!QDELETED(mod))
		mod.chestplate = null
		mod.mod_parts -= src
		QDEL_NULL(mod)
	return ..()

/obj/item/clothing/suit/mod/obj_destruction(damage_flag)
	return mod.obj_destruction(damage_flag)

/obj/item/clothing/gloves/mod
	name = "MOD gauntlets"
	desc = "A pair of gauntlets for a MODsuit."
	icon = 'nsv13/icons/obj/mod.dmi'
	icon_state = "gauntlets"
	worn_icon = 'nsv13/icons/mob/mod.dmi'
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 0, "fire" = 25, "acid" = 25)
	body_parts_covered = HANDS|ARMS
	heat_protection = HANDS|ARMS
	cold_protection = HANDS|ARMS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	clothing_flags = THICKMATERIAL
	resistance_flags = NONE
	item_flags = IMMUTABLE_SLOW
	var/obj/item/mod/control/mod
	var/obj/item/clothing/overslot

/obj/item/clothing/gloves/mod/Destroy()
	if(!QDELETED(mod))
		mod.gauntlets = null
		mod.mod_parts -= src
		QDEL_NULL(mod)
	return ..()

/obj/item/clothing/gloves/mod/obj_destruction(damage_flag)
	overslot.forceMove(drop_location())
	overslot = null
	return mod.obj_destruction(damage_flag)

/// Replaces these gloves on the wearer with the overslot ones
/obj/item/clothing/gloves/mod/proc/show_overslot()
	if(!overslot)
		return
	if(!mod.wearer.equip_to_slot_if_possible(overslot, overslot.slot_flags, qdel_on_fail = FALSE, disable_warning = TRUE))
		mod.wearer.dropItemToGround(overslot, force = TRUE)
	overslot = null

/obj/item/clothing/shoes/mod
	name = "MOD boots"
	desc = "A pair of boots for a MODsuit."
	icon = 'nsv13/icons/obj/mod.dmi'
	icon_state = "boots"
	worn_icon = 'nsv13/icons/mob/mod.dmi'
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 0, "fire" = 25, "acid" = 25)
	body_parts_covered = FEET|LEGS
	heat_protection = FEET|LEGS
	cold_protection = FEET|LEGS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	clothing_flags = THICKMATERIAL
	resistance_flags = NONE
	item_flags = IMMUTABLE_SLOW|IGNORE_DIGITIGRADE
	var/obj/item/mod/control/mod
	var/obj/item/clothing/overslot

/obj/item/clothing/shoes/mod/Destroy()
	if(!QDELETED(mod))
		mod.boots = null
		mod.mod_parts -= src
		QDEL_NULL(mod)
	return ..()

/obj/item/clothing/shoes/mod/obj_destruction(damage_flag)
	overslot.forceMove(drop_location())
	overslot = null
	return mod.obj_destruction(damage_flag)

/// Replaces these shoes on the wearer with the overslot ones
/obj/item/clothing/shoes/mod/proc/show_overslot()
	if(!overslot)
		return
	if(!mod.wearer.equip_to_slot_if_possible(overslot, overslot.slot_flags, qdel_on_fail = FALSE, disable_warning = TRUE))
		mod.wearer.dropItemToGround(overslot, force = TRUE)
	overslot = null
