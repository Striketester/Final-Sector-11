/* This file was unticked before so I just commented this out
/obj/item/toy/plush/random
	name = "\improper Random Plush"
	icon_state = "debug"
	desc = "Oh no! What have you done! (if you see this, contact an upper being as soon as possible)."

/obj/item/toy/plush/random/Initialize()
	var/plush_type = pick(subtypesof(/obj/item/toy/plush/) - /obj/item/toy/plush/random/)
	new plush_type(loc)
	return INITIALIZE_HINT_QDEL
*/
/obj/item/toy/plush/hfighter
	name = "heavy fighter plush"
	desc = "An adorable stuffed toy shaped like a Su-410 Scimitar heavy fighter."
	icon = 'nsv13/icons/obj/custom_plushes.dmi'
	icon_state = "heavyfighter"
	attack_verb = list("gunned", "bombed", "bumped", "rammed")
	squeak_override = list('nsv13/sound/effects/fighters/BRRTTTTTT.ogg'=1)

/obj/item/toy/plush/lfighter
	name = "light fighter plush"
	desc = "An adorable stuffed toy shaped like a Su-818 Rapier light fighter."
	icon = 'nsv13/icons/obj/custom_plushes.dmi'
	icon_state = "lightfighter"
	attack_verb = list("gunned", "bumped", "rammed")
	squeak_override = list('nsv13/sound/effects/fighters/BRRTTTTTT.ogg'=1)
