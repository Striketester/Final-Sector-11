//Allows you to fully automate missile construction
/obj/machinery/missile_builder
	name = "Seegson model 'Ford' robotic autowrench"
	desc = "An advanced robotic arm that can be arrayed with other such devices to form an assembly line for guided munition production. Swipe it with your ID to access maintenance mode options (only on some models!)"
	icon = 'nsv13/icons/obj/munitions/assembly.dmi'
	icon_state = "assemblybase"
	circuit = /obj/item/circuitboard/machine/missile_builder
	anchored = TRUE
	can_be_unanchored = TRUE
	density = TRUE
	speed_process = TRUE
	var/process_delay = 0.5 SECONDS
	var/next_process = 0
	var/arm_icon_state = "welder3"
	var/tier = 1
	var/list/held_components = list() //All the missile construction components that they've put into the arm.
	var/obj/item/arm = null
	var/obj/item/ship_weapon/ammunition/missile/missile_casing/target
	var/munition_type = /obj/item/ship_weapon/ammunition/missile/missile_casing
	var/list/target_states = list(1, 7, 9) //The target construction state of the missile

/obj/machinery/missile_builder/examine(mob/user)
	. = ..()
	. += "<span class='notice'>It currently holds...</span>"
	for(var/atom/movable/X in held_components)
		. += "<span class='notice'>-[X]</span>"

/obj/machinery/missile_builder/attackby(obj/item/I, mob/user, params)
	if(default_unfasten_wrench(user, I))
		return
	if(default_deconstruction_screwdriver(user, icon_state, icon_state, I))
		update_icon()
		return
	. = ..()

/obj/item/stack/conveyor/slow
	name = "Slow conveyor assembly"
	conveyor_type = /obj/machinery/conveyor/slow

/obj/machinery/conveyor/slow
	name = "Slow conveyor"
	speed_process = FALSE
	stack_type = /obj/item/stack/conveyor/slow //What does this conveyor drop when decon'd?

/obj/machinery/missile_builder/wirer
	name = "Seegson model 'Ford' robotic autowirer"
	target_states = list(8)
	circuit = /obj/item/circuitboard/machine/missile_builder/wirer

/obj/machinery/missile_builder/welder
	name = "Seegson model 'Ford' robotic autowelder"
	target_states = list(10)
	circuit = /obj/item/circuitboard/machine/missile_builder/welder

/obj/machinery/missile_builder/screwdriver
	name = "Seegson model 'Ford' robotic bolt driver"
	target_states = list(3,5)
	circuit = /obj/item/circuitboard/machine/missile_builder/screwdriver

/obj/machinery/missile_builder/AltClick(mob/user)
	. = ..()
	setDir(turn(src.dir, -90))

/obj/machinery/missile_builder/Initialize()
	. = ..()
	arm = new /obj/item(src)
	arm.icon = icon
	arm.icon_state = arm_icon_state
	vis_contents += arm
	arm.mouse_opacity = FALSE

/obj/machinery/missile_builder/Destroy()
	qdel(arm)
	. = ..()

/obj/machinery/missile_builder/process()
	if(world.time < next_process)
		return
	next_process = world.time + process_delay
	var/turf/input_turf = get_turf(get_step(src, src.dir))
	if(target && target.loc != input_turf)
		target = null
		visible_message("[name] shakes its arm melancholically.")
		arm.shake_animation()
		playsound(src, 'sound/machines/buzz-sigh.ogg', 50, 0)

	if(target)
		arm.icon_state = arm_icon_state
		target.state++ //Next step!
		target.check_completion()
		do_sparks(10, TRUE, target)
		playsound(src, 'sound/items/welder.ogg', 100, 1)
		target = null
		return
	target = locate(munition_type) in input_turf
	if(!target || !istype(target, munition_type))
		target = null
		return
	var/found = FALSE
	for(var/target_state in target_states)
		if(target.state == target_state)
			found = TRUE
			break

	if(!found)
		visible_message("<span class='notice'>[src] sighs.</span>")
		playsound(src, 'sound/machines/buzz-sigh.ogg', 50, 0)
		target = null
		return FALSE
	src.visible_message("<span class='notice'>[src] whirrs into life!</span>")
	arm.icon_state = "[arm_icon_state]_anim"
	playsound(src, 'sound/items/drill_use.ogg', 100, 1)

/obj/machinery/missile_builder/assembler
	name = "Robotic Missile Part Applicator"
	arm_icon_state = "assembler2"
	desc = "An assembly arm which can slot a multitude of missile components into casings for you! Swipe it with an ID to release its stored components."
	req_one_access = list(ACCESS_MUNITIONS)
	circuit = /obj/item/circuitboard/machine/missile_builder/assembler

/obj/machinery/missile_builder/assembler/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(istype(I, /obj/item/ship_weapon/parts/missile))
		if(!do_after(user, 0.5 SECONDS, target=src))
			return FALSE
		to_chat(user, "<span class='notice'>You slot [I] into [src], ready for construction.</span>")
		I.forceMove(src)
		held_components += I
	if(istype(I, /obj/item/card/id) && allowed(user))
		to_chat(user, "<span class='warning'>You dump [src]'s contents out.</span>")
		for(var/obj/item/X in held_components)
			X.forceMove(get_turf(src))
			held_components -= X

/obj/machinery/missile_builder/assembler/process()
	if(world.time < next_process)
		return
	next_process = world.time + process_delay
	var/turf/input_turf = get_turf(get_step(src, src.dir))
	if(target && target.loc != input_turf)
		target = null
		visible_message("[name] shakes its arm melancholically.")
		arm.shake_animation()
		playsound(src, 'sound/machines/buzz-sigh.ogg', 50, 0)
	if(target)
		var/found = FALSE
		for(var/obj/item/ship_weapon/parts/missile/M in held_components)
			if(M.fits_type && !istype(target, M.fits_type))
				continue
			if(target.state == M.target_state)
				M.forceMove(target)
				held_components -= M
				target.state ++
				found = TRUE
				break
		if(found)
			target.check_completion()
			playsound(src, 'sound/machines/ping.ogg', 50, 0)
			do_sparks(10, TRUE, target)
		target = null
		arm.icon_state = arm_icon_state
		return
	target = locate(munition_type) in input_turf
	if(!target || !istype(target, munition_type) || !held_components.len)
		target = null
		return
	src.visible_message("<span class='notice'>[src] whirrs into life!</span>")
	arm.icon_state = "[arm_icon_state]_anim"
	playsound(src, 'sound/items/drill_use.ogg', 100, 1)

/obj/item/circuitboard/computer/ammo_sorter
	name = "Ammo sorter console (circuitboard)"
	build_path = /obj/machinery/computer/ammo_sorter

/obj/item/circuitboard/machine/ammo_sorter
	name = "Ammo sorter (circuitboard)"
	build_path = /obj/machinery/ammo_sorter

/obj/machinery/computer/ammo_sorter
	name = "Ammo Rack Control Console"
	icon_screen = "ammorack"
	circuit = /obj/item/circuitboard/computer/ammo_sorter
	var/list/linked_sorters = list()

/obj/machinery/computer/ammo_sorter/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	var/obj/item/multitool/M = I
	if(M.buffer && istype(M.buffer, /obj/machinery/ammo_sorter) && !LAZYFIND(M.buffer, linked_sorters))
		linked_sorters += M
		to_chat(user, "<span class='warning'>You've linked [M.buffer] to [src]...")

/obj/machinery/computer/ammo_sorter/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = 0, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.default_state) // Remember to use the appropriate state.
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "AmmoSorter", name, 560, 600, master_ui, state)
		ui.open()

/obj/machinery/computer/ammo_sorter/ui_act(action, params, datum/tgui/ui)
	if(..())
		return


/obj/machinery/ammo_sorter
	name = "Ammo Rack"
	desc = "A machine that allows you to compartmentalise your ship's ammo stores, controlled by a central console."
	icon = 'nsv13/icons/obj/munitions.dmi'
	icon_state = "ammorack"
	circuit = /obj/item/circuitboard/machine/ammo_sorter
