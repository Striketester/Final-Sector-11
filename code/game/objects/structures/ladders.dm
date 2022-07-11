// Basic ladder. By default links to the z-level above/below.
/obj/structure/ladder
	name = "ladder"
	desc = "A sturdy metal ladder."
	icon = 'icons/obj/structures.dmi'
	icon_state = "ladder11"
	anchored = TRUE
	var/obj/structure/ladder/down   //the ladder below this one
	var/obj/structure/ladder/up     //the ladder above this one
	var/bot_allowed = TRUE //NSV13 Bots are not allowed to go up this ladder
	max_integrity = 100

/obj/structure/ladder/Initialize(mapload, obj/structure/ladder/up, obj/structure/ladder/down)
	..()
	GLOB.ladders += src //NSV13
	if (up)
		src.up = up
		up.down = src
		up.update_icon()
	if (down)
		src.down = down
		down.up = src
		down.update_icon()
	return INITIALIZE_HINT_LATELOAD

/obj/structure/ladder/Destroy(force)
	if ((resistance_flags & INDESTRUCTIBLE) && !force)
		return QDEL_HINT_LETMELIVE
	GLOB.ladders -= src //NSV13
	disconnect()
	return ..()

/obj/structure/ladder/LateInitialize()
	// By default, discover ladders above and below us vertically
	var/turf/T = get_turf(src)
	var/obj/structure/ladder/L

	if (!down)
		L = locate() in SSmapping.get_turf_below(T)
		if (L)
			down = L
			L.up = src  // Don't waste effort looping the other way
			L.update_icon()
	if (!up)
		L = locate() in SSmapping.get_turf_above(T)
		if (L)
			up = L
			L.down = src  // Don't waste effort looping the other way
			L.update_icon()

	update_icon()

/obj/structure/ladder/proc/disconnect()
	if(up && up.down == src)
		up.down = null
		up.update_icon()
	if(down && down.up == src)
		down.up = null
		down.update_icon()
	up = down = null

/obj/structure/ladder/update_icon()
	if(up && down)
		icon_state = "ladder11"

	else if(up)
		icon_state = "ladder10"

	else if(down)
		icon_state = "ladder01"

	else	//wtf make your ladders properly assholes
		icon_state = "ladder00"

/obj/structure/ladder/singularity_pull()
	if (!(resistance_flags & INDESTRUCTIBLE))
		visible_message("<span class='danger'>[src] is torn to pieces by the gravitational pull!</span>")
		qdel(src)

/obj/structure/ladder/proc/travel(going_up, mob/user, is_ghost, obj/structure/ladder/ladder, needs_do_after=TRUE)
	var/turf/T = get_turf(ladder)
	var/atom/movable/AM
	if(user.pulling)
		AM = user.pulling
		if(!is_ghost)
			playsound(src, 'nsv13/sound/effects/footstep/ladder2.ogg')
			if(needs_do_after)
				if(!do_after(user, 5 SECONDS, target=src))
					return FALSE
		AM.forceMove(T)
		user.forceMove(T)
		user.start_pulling(AM)
	else
		if(!is_ghost)
			playsound(src, 'nsv13/sound/effects/footstep/ladder1.ogg')
			if(needs_do_after)
				if(!do_after(user, 1 SECONDS, target=src))
					return FALSE
		user.forceMove(T)
	if(!is_ghost)
		show_fluff_message(going_up, user)
		ladder.add_fingerprint(user)


/obj/structure/ladder/proc/use(mob/user, is_ghost=FALSE)
	if (!is_ghost && !in_range(src, user))
		return

	var/list/tool_list = list(
		"Up" = image(icon = 'icons/testing/turf_analysis.dmi', icon_state = "red_arrow", dir = NORTH),
		"Down" = image(icon = 'icons/testing/turf_analysis.dmi', icon_state = "red_arrow", dir = SOUTH)
		)

	if (up && down)
		var/result = show_radial_menu(user, src, tool_list, custom_check = CALLBACK(src, .proc/check_menu, user), require_near = TRUE, tooltips = TRUE)
		if (!is_ghost && !in_range(src, user))
			return  // nice try
		switch(result)
			if("Up")
				travel(TRUE, user, is_ghost, up)
			if("Down")
				travel(FALSE, user, is_ghost, down)
			if("Cancel")
				return
	else if(up)
		travel(TRUE, user, is_ghost, up)
	else if(down)
		travel(FALSE, user, is_ghost, down)
	else
		to_chat(user, "<span class='warning'>[src] doesn't seem to lead anywhere!</span>")

	if(!is_ghost)
		add_fingerprint(user)

/obj/structure/ladder/proc/check_menu(mob/user)
	if(user.incapacitated() || !user.Adjacent(src))
		return FALSE
	return TRUE

/obj/structure/ladder/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	use(user)

/obj/structure/ladder/attack_paw(mob/user)
	return use(user)

/obj/structure/ladder/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	switch(the_rcd.mode)
		if(RCD_DECONSTRUCT)
			return list("mode" = RCD_DECONSTRUCT, "delay" = 30, "cost" = 15)
	return FALSE

/obj/structure/ladder/rcd_act(mob/user, var/obj/item/construction/rcd/the_rcd, passed_mode)
	switch(passed_mode)
		if(RCD_DECONSTRUCT)
			to_chat(user, "<span class='notice'>You deconstruct the ladder.</span>")
			qdel(src)
			return TRUE

/obj/structure/ladder/unbreakable/rcd_act(mob/user, var/obj/item/construction/rcd/the_rcd, passed_mode)
	switch(passed_mode)
		if(RCD_DECONSTRUCT)
			to_chat(user, "<span class='warning'>[src] seems to resist all attempts to deconstruct it!</span>")
			return FALSE

/obj/structure/ladder/attackby(obj/item/I, mob/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	add_fingerprint(user)
	if(!(resistance_flags & INDESTRUCTIBLE))
		if(I.tool_behaviour == TOOL_WELDER)
			if(!I.tool_start_check(user, amount=0))
				return FALSE

			to_chat(user, "<span class='notice'>You begin cutting [src]...</span>")
			if(I.use_tool(src, user, 50, volume=100))
				user.visible_message("<span class='notice'>[user] cuts [src].</span>", \
									 "<span class='notice'>You cut [src].</span>")
				I.play_tool_sound(src, 100)
				var/obj/R = new /obj/item/stack/rods(drop_location(), 10)
				transfer_fingerprints_to(R)
				qdel(src)
				return TRUE
	else
		to_chat(user, "<span class='warning'>[src] seems to resist all attempts to deconstruct it!</span>")
		return FALSE

/obj/structure/ladder/attack_robot(mob/living/silicon/robot/R)
	if(R.Adjacent(src))
		return use(R)

//ATTACK GHOST IGNORING PARENT RETURN VALUE
/obj/structure/ladder/attack_ghost(mob/dead/observer/user)
	use(user, TRUE)
	return ..()

/obj/structure/ladder/proc/show_fluff_message(going_up, mob/user)
	if(going_up)
		user.visible_message("[user] climbs up [src].","<span class='notice'>You climb up [src].</span>")
	else
		user.visible_message("[user] climbs down [src].","<span class='notice'>You climb down [src].</span>")


// Indestructible away mission ladders which link based on a mapped ID and height value rather than X/Y/Z.
/obj/structure/ladder/unbreakable
	name = "sturdy ladder"
	desc = "An extremely sturdy metal ladder."
	resistance_flags = INDESTRUCTIBLE
	var/id
	var/height = 0  // higher numbers are considered physically higher

/obj/structure/ladder/unbreakable/Initialize()
	GLOB.ladders += src
	return ..()

/obj/structure/ladder/unbreakable/Destroy()
	. = ..()
	if (. != QDEL_HINT_LETMELIVE)
		GLOB.ladders -= src

/obj/structure/ladder/unbreakable/LateInitialize()
	// Override the parent to find ladders based on being height-linked
	if (!id || (up && down))
		update_icon()
		return

	for (var/O in GLOB.ladders)
		var/obj/structure/ladder/unbreakable/L = O
		if (L.id != id)
			continue  // not one of our pals
		if (!down && L.height == height - 1)
			down = L
			L.up = src
			L.update_icon()
			if (up)
				break  // break if both our connections are filled
		else if (!up && L.height == height + 1)
			up = L
			L.down = src
			L.update_icon()
			if (down)
				break  // break if both our connections are filled

	update_icon()
