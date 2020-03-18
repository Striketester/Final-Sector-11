#define UBS_CHASSIS							0
#define UBS_CHASSIS_BOLT					1
#define UBS_CHASSIS_WELD					2
#define UBS_ENGINE							3
#define UBS_ENGINE_BOLT						4
#define UBS_APU								5
#define UBS_APU_WIRE						6
#define UBS_APU_MULTI						7
#define UBS_FUEL_TANK						8
#define UBS_FUEL_TANK_BOLT					9
#define UBS_PRIMARY							10
#define UBS_PRIMARY_BOLT					11
#define UBS_PRIMARY_MULTI					12
#define UBS_SECONDARY						13
#define UBS_SECONDARY_BOLT					14
#define UBS_SECONDARY_MULTI					15
#define UBS_COUNTERMEASURE_DISPENSER		16
#define UBS_COUNTERMEASURE_DISPENSER_BOLT	17
#define UBS_AVIONICS						18
#define UBS_AVIONICS_WIRE					19
#define UBS_AVIONICS_MULTI					20
#define UBS_ARMOUR_PLATING					21
#define UBS_ARMOUR_PLATING_BOLT				22
#define UBS_ARMOUR_PLATING_WELD				23
#define UBS_PAINT_PRIMER					24
#define UBS_PAINT_DETAILING					25

/obj/structure/fighter_component/underconstruction_fighter/utility_vessel_frame
	name = "Utility Vessel Frame"
	desc = "An Incomplete Utility Vessel"
	icon = 'icons/obj/janitor.dmi'
	icon_state = "smmop"
	build_state = UBS_CHASSIS
	fighter_name = null

/obj/structure/fighter_component/underconstruction_fighter/utility_vessel_frame/examine(mob/user)
	. = ..()
	switch(build_state)
		if(UBS_CHASSIS)
			. += "<span class='notice'>0</span>"
		if(UBS_CHASSIS_BOLT)
			. += "<span class='notice'>1</span>"
		if(UBS_CHASSIS_WELD)
			. += "<span class='notice'>2</span>"
		if(UBS_ENGINE)
			. += "<span class='notice'>3</span>"
		if(UBS_ENGINE_BOLT)
			. += "<span class='notice'>4</span>"
		if(UBS_APU)
			. += "<span class='notice'>5</span>"
		if(UBS_APU_WIRE)
			. += "<span class='notice'>6</span>"
		if(UBS_APU_MULTI)
			. += "<span class='notice'>7</span>"
		if(UBS_FUEL_TANK)
			. += "<span class='notice'>8</span>"
		if(UBS_FUEL_TANK_BOLT)
			. += "<span class='notice'>9</span>"
		if(UBS_PRIMARY)
			. += "<span class='notice'>10</span>"
		if(UBS_PRIMARY_BOLT)
			. += "<span class='notice'>11</span>"
		if(UBS_PRIMARY_MULTI)
			. += "<span class='notice'>12</span>"
		if(UBS_SECONDARY)
			. += "<span class='notice'>13</span>"
		if(UBS_SECONDARY_BOLT)
			. += "<span class='notice'>14</span>"
		if(UBS_SECONDARY_MULTI)
			. += "<span class='notice'>15</span>"
		if(UBS_COUNTERMEASURE_DISPENSER)
			. += "<span class='notice'>16</span>"
		if(UBS_COUNTERMEASURE_DISPENSER_BOLT)
			. += "<span class='notice'>17</span>"
		if(UBS_AVIONICS)
			. += "<span class='notice'>18</span>"
		if(UBS_AVIONICS_WIRE)
			. += "<span class='notice'>19</span>"
		if(UBS_AVIONICS_MULTI)
			. += "<span class='notice'>20</span>"
		if(UBS_ARMOUR_PLATING)
			. += "<span class='notice'>21</span>"
		if(UBS_ARMOUR_PLATING_BOLT)
			. += "<span class='notice'>22</span>"
		if(UBS_ARMOUR_PLATING_WELD)
			. += "<span class='notice'>23</span>"
		if(UBS_PAINT_PRIMER)
			. += "<span class='notice'>24</span>"
		if(UBS_PAINT_DETAILING)
			. += "<span class='notice'>25</span>"

/obj/structure/fighter_component/utility_chassis_crate/attack_hand(mob/user)
	.=..()
	if(alert(user, "Begin constructing an ADL-77U Arroyomolinos Utility Vessel?",, "Yes", "No")!="Yes")
		return
	to_chat(user, "<span class='notice'>You begin constructing the chassis of a utility vessel.</span>")
	if(!do_after(user, 10 SECONDS, target=src))
		return
	to_chat(user, "<span class='notice'>You construct the chassis of a utility vessel.</span>")
	new/obj/structure/fighter_component/underconstruction_fighter/utility_vessel_frame (loc, 1)
	qdel(src)

/obj/structure/fighter_component/underconstruction_fighter/utility_vessel_frame/attackby(obj/item/W, mob/user, params)
	add_fingerprint(user)
	if(istype(W, /obj/item/fighter_component/fuel_tank))
		if(build_state == UBS_APU_MULTI)
			to_chat(user, "<span class='notice'>You start adding [W] to [src]...</span>")
			if(!do_after(user, 5 SECONDS, target=src))
				return
			to_chat(user, "<spawn class='notice'>You add [W] to [src].</span>")
			build_state = UBS_FUEL_TANK
			update_icon()
			W.forceMove(src)
	else if(istype(W, /obj/item/fighter_component/avionics))
		if(build_state == UBS_SECONDARY_BOLT)
			to_chat(user, "<span class='notice'>You start adding [W] to [src]...</span>")
			if(!do_after(user, 5 SECONDS, target=src))
				return
			to_chat(user, "<spawn class='notice'>You add [W] to [src].</span>")
			build_state = UBS_AVIONICS
			update_icon()
			W.forceMove(src)
	else if(istype(W, /obj/item/fighter_component/apu))
		if(build_state == UBS_ENGINE_BOLT)
			to_chat(user, "<span class='notice'>You start adding [W] to [src]...</span>")
			if(!do_after(user, 5 SECONDS, target=src))
				return
			to_chat(user, "<spawn class='notice'>You add [W] to [src].</span>")
			build_state = UBS_APU
			update_icon()
			W.forceMove(src)
	else if(istype(W, /obj/item/fighter_component/armour_plating/utility))
		if(build_state == UBS_AVIONICS_WIRE)
			to_chat(user, "<span class='notice'>You start adding [W] to [src]...</span>")
			if(!do_after(user, 5 SECONDS, target=src))
				return
			to_chat(user, "<spawn class='notice'>You add [W] to [src].</span>")
			build_state = UBS_ARMOUR_PLATING
			update_icon()
			W.forceMove(src)
	else if(istype(W, /obj/item/fighter_component/engine/utility))
		if(build_state == UBS_CHASSIS_WELD)
			to_chat(user, "<span class='notice'>You start adding [W] to [src]...</span>")
			if(!do_after(user, 5 SECONDS, target=src))
				return
			to_chat(user, "<spawn class='notice'>You add [W] to [src].</span>")
			build_state = UBS_ENGINE
			update_icon()
			W.forceMove(src)
	else if(istype(W, /obj/item/fighter_component/countermeasure_dispenser))
		if(build_state == UBS_SECONDARY_BOLT)
			to_chat(user, "<span class='notice'>You start adding [W] to [src]...</span>")
			if(!do_after(user, 5 SECONDS, target=src))
				return
			to_chat(user, "<spawn class='notice'>You add [W] to [src].</span>")
			build_state = UBS_COUNTERMEASURE_DISPENSER
			update_icon()
			W.forceMove(src)
	else if(istype(W, /obj/item/fighter_component/utility/primary))
		if(build_state == UBS_FUEL_TANK_BOLT)
			to_chat(user, "<span class='notice'>You start adding [W] to [src]...</span>")
			if(!do_after(user, 5 SECONDS, target=src))
				return
			to_chat(user, "<spawn class='notice'>You add [W] to [src].</span>")
			build_state = UBS_PRIMARY
			update_icon()
			W.forceMove(src)
	else if(istype(W, /obj/item/fighter_component/utility/secondary))
		if(build_state == UBS_PRIMARY_MULTI)
			to_chat(user, "<span class='notice'>You start adding [W] to [src]...</span>")
			if(!do_after(user, 5 SECONDS, target=src))
				return
			to_chat(user, "<spawn class='notice'>You add [W] to [src].</span>")
			build_state = UBS_SECONDARY
			update_icon()
			W.forceMove(src)
	else if(istype(W, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/C = W
		if(build_state == UBS_AVIONICS)
			if(C.get_amount() <5)
				to_chat(user, "<span class='notice'>You need at least five cable pieces to wire [src]!</span>")
				return
			to_chat(user, "<span class='notice'>You start wiring [src]...</span>")
			if(!do_after(user, 5 SECONDS, target=src))
				return
			W.use(5)
			to_chat(user, "<spawn class='notice'>You wire [src].</span>")
			build_state = UBS_AVIONICS_WIRE
			update_icon()
		if(build_state == UBS_APU)
			if(C.get_amount() <5)
				to_chat(user, "<span class='notice'>You need at least five cable pieces to wire [src]!</span>")
				return
			to_chat(user, "<span class='notice'>You start wiring [src]...</span>")
			if(!do_after(user, 5 SECONDS, target=src))
				return
			W.use(5)
			to_chat(user, "<spawn class='notice'>You wire [src].</span>")
			build_state = UBS_APU_WIRE
			update_icon()
	else if(istype(W, /obj/item/airlock_painter)) //replace with an aircraft painter
		if(build_state == UBS_ARMOUR_PLATING_WELD) //check mode later
			to_chat(user, "<span class='notice'>You start painting primer on [src]...</span>")
			if(!do_after(user, 5 SECONDS, target=src))
				return
			to_chat(user, "<spawn class='notice'>You prime [src].</span>")
			build_state = UBS_PAINT_PRIMER
			update_icon()
		else if(build_state == UBS_PAINT_PRIMER) //check mode later
			to_chat(user, "<span class='notice'>You start painting details on [src]...</span>")
			if(!do_after(user, 5 SECONDS, target=src))
				return
			to_chat(user, "<spawn class='notice'>You complete painting [src].</span>")
			build_state = UBS_PAINT_DETAILING
			update_icon()

/obj/structure/fighter_component/underconstruction_fighter/utility_vessel_frame/wrench_act(mob/user, obj/item/tool)
	. = FALSE
	switch(build_state)
		if(UBS_CHASSIS)
			to_chat(user, "<span class='notice'>You start to bolt the chassis together...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You bolt the chassis together.</span>")
				build_state = UBS_CHASSIS_BOLT
				update_icon()
				return TRUE
		if(UBS_CHASSIS_BOLT)
			to_chat(user, "<span class='notice'>You start to unbolt the chassis.</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You unbolt the chassis.</span>")
				build_state = UBS_CHASSIS
				update_icon()
				return TRUE
		if(UBS_ENGINE)
			to_chat(user, "<span class='notice'>You start to bolt the engine to the chassis...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You bolt the engine to the chassis.</span>")
				build_state = UBS_ENGINE_BOLT
				update_icon()
				return TRUE
		if(UBS_ENGINE_BOLT)
			to_chat(user, "<span class='notice'>You start to unbolt the engine from the chassis...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You unbolt the engine from the chassis.</span>")
				build_state = UBS_ENGINE
				update_icon()
				return TRUE
		if(UBS_FUEL_TANK)
			to_chat(user, "<span class='notice'>You start to bolt the fuel tank to the chassis...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You bolt the fuel tank to the chassis.</span>")
				build_state = UBS_FUEL_TANK_BOLT
				update_icon()
				return TRUE
		if(UBS_FUEL_TANK_BOLT)
			to_chat(user, "<span class='notice'>You start to unbolt the fuel tank from the chassis...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You unbolt the fuel tank from the chassis.</span>")
				build_state = UBS_FUEL_TANK
				update_icon()
				return TRUE
		if(UBS_COUNTERMEASURE_DISPENSER)
			to_chat(user, "<span class='notice'>You start to bolt the countermeasure dispenser to the chassis...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You bolt the countermeasure dispenser to the chassis.</span>")
				build_state = UBS_COUNTERMEASURE_DISPENSER_BOLT
				update_icon()
				return TRUE
		if(UBS_COUNTERMEASURE_DISPENSER_BOLT)
			to_chat(user, "<span class='notice'>You start to unbolt the countermeasure dispenser from the chassis...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You unbolt the countermeasure dispenser from the chassis.</span>")
				build_state = UBS_COUNTERMEASURE_DISPENSER
				update_icon()
				return TRUE
		if(UBS_ARMOUR_PLATING)
			to_chat(user, "<span class='notice'>You start to bolt the armour plating to the chassis...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You bolt the armour plating to the chassis.</span>")
				build_state = UBS_ARMOUR_PLATING_BOLT
				update_icon()
				return TRUE
		if(UBS_ARMOUR_PLATING_BOLT)
			to_chat(user, "<span class='notice'>You start to bolt the armour plating to the chassis...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You bolt the armour plating to the chassis.</span>")
				build_state = UBS_ARMOUR_PLATING_BOLT
				update_icon()
				return TRUE
		if(UBS_PRIMARY)
			to_chat(user, "<span class='notice'>You start to bolt the primary module to the chassis...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You bolt the primary module to the chassis.</span>")
				build_state = UBS_PRIMARY_BOLT
				update_icon()
				return TRUE
		if(UBS_PRIMARY_BOLT)
			to_chat(user, "<span class='notice'>You start to unbolt the primary module from the chassis...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You unbolt the primary module from the chassis.</span>")
				build_state = UBS_PRIMARY
				update_icon()
				return TRUE
		if(UBS_SECONDARY)
			to_chat(user, "<span class='notice'>You start to bolt the secondary module to the chassis...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You bolt the secondary module to the chassis.</span>")
				build_state = UBS_SECONDARY_BOLT
				update_icon()
				return TRUE
		if(UBS_SECONDARY_BOLT)
			to_chat(user, "<span class='notice'>You start to unbolt the secondary module from the chassis...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You unbolt the secondary module from the chassis.</span>")
				build_state = UBS_SECONDARY
				update_icon()
				return TRUE

/obj/structure/fighter_component/underconstruction_fighter/utility_vessel_frame/welder_act(mob/user, obj/item/tool)
	. = FALSE
	switch(build_state)
		if(UBS_CHASSIS_BOLT)
			to_chat(user, "<span class='notice'>You start to weld the chassis together...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You weld the chassis together.</span>")
				build_state = UBS_CHASSIS_WELD
				update_icon()
				return TRUE
		if(UBS_CHASSIS_WELD)
			to_chat(user, "<span class='notice'>You start to cut the chassis apart.</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You cut the chassis apart.</span>")
				build_state = UBS_CHASSIS_BOLT
				update_icon()
				return TRUE
		if(UBS_ARMOUR_PLATING_BOLT)
			to_chat(user, "<span class='notice'>You start to weld the armour plating to the chassis...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You weld the armour plating to the chassis.</span>")
				build_state = UBS_ARMOUR_PLATING_WELD
				update_icon()
				return TRUE
		if(UBS_ARMOUR_PLATING_WELD)
			to_chat(user, "<span class='notice'>You start to cut the armour plating from the chassis...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You cut the armour plating from the chassis.</span>")
				build_state = UBS_ARMOUR_PLATING_BOLT
				update_icon()
				return TRUE

/obj/structure/fighter_component/underconstruction_fighter/utility_vessel_frame/wirecutter_act(mob/user, obj/item/tool)
	. = FALSE
	switch(build_state)
		if(UBS_APU_WIRE)
			to_chat(user, "<span class='notice'>You start cutting the wiring in [src]...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You cut the wiring in [src].</span>")
				var/obj/item/stack/cable_coil/C = new (loc, 5)
				C.add_fingerprint(user)
				build_state = UBS_APU
				update_icon()
				return TRUE
		if(UBS_AVIONICS_WIRE)
			to_chat(user, "<span class='notice'>You start cutting the wiring in [src]...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You cut the wiring in [src].</span>")
				var/obj/item/stack/cable_coil/C = new (loc, 5)
				C.add_fingerprint(user)
				build_state = UBS_AVIONICS
				update_icon()
				return TRUE

/obj/structure/fighter_component/underconstruction_fighter/utility_vessel_frame/crowbar_act(mob/user, obj/item/tool)
	. = FALSE
	switch(build_state)
		if(UBS_ENGINE)
			to_chat(user, "<span class='notice'>You start removing the engine from [src]...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You remove the engine from [src].</span>")
				var/atom/movable/ts = get_part(/obj/item/fighter_component/engine)
				ts?.forceMove(get_turf(src))
				build_state = UBS_FUEL_TANK_BOLT
				update_icon()
				return TRUE
		if(UBS_APU)
			to_chat(user, "<span class='notice'>You start removing the APU from [src]...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You remove the APU from [src].</span>")
				var/atom/movable/ts = get_part(/obj/item/fighter_component/apu)
				ts?.forceMove(get_turf(src))
				build_state = UBS_CHASSIS_WELD
				update_icon()
				return TRUE
		if(UBS_FUEL_TANK)
			to_chat(user, "<span class='notice'>You start removing the fuel tank from [src]...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You remove the fuel tank from [src].</span>")
				var/atom/movable/ts = get_part(/obj/item/fighter_component/fuel_tank)
				ts?.forceMove(get_turf(src))
				build_state = UBS_APU_MULTI
				update_icon()
				return TRUE
		if(UBS_AVIONICS)
			to_chat(user, "<span class='notice'>You start removing the avionics from [src]...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You remove the avionics from [src].</span>")
				var/atom/movable/ts = get_part(/obj/item/fighter_component/avionics)
				ts?.forceMove(get_turf(src))
				build_state = UBS_COUNTERMEASURE_DISPENSER_BOLT
				update_icon()
				return TRUE
		if(UBS_PRIMARY)
			to_chat(user, "<span class='notice'>You start removing the primary module from [src]...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You remove the primary module from [src].</span>")
				var/atom/movable/ts = get_part(/obj/item/fighter_component/utility/primary)
				ts?.forceMove(get_turf(src))
				build_state = UBS_FUEL_TANK_BOLT
				update_icon()
				return TRUE
		if(UBS_COUNTERMEASURE_DISPENSER)
			to_chat(user, "<span class='notice'>You start removing the countermeasure dispenser from [src]...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You remove the countermeasure dispenser from [src].</span>")
				var/atom/movable/ts = get_part(/obj/item/fighter_component/countermeasure_dispenser)
				ts?.forceMove(get_turf(src))
				build_state = UBS_SECONDARY_BOLT
				update_icon()
				return TRUE
		if(UBS_ARMOUR_PLATING)
			to_chat(user, "<span class='notice'>You start removing the armour plating from [src]...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You remove the armour plating from [src].</span>")
				var/atom/movable/ts = get_part(/obj/item/fighter_component/armour_plating)
				ts?.forceMove(get_turf(src))
				build_state = UBS_AVIONICS_WIRE
				update_icon()
				return TRUE
		if(UBS_SECONDARY)
			to_chat(user, "<span class='notice'>You start removing the secondary module from [src]...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You remove the secondary module from [src].</span>")
				var/atom/movable/ts = get_part(/obj/item/fighter_component/utility/secondary)
				ts?.forceMove(get_turf(src))
				build_state = UBS_PRIMARY_MULTI
				update_icon()
				return TRUE
		if(UBS_CHASSIS)
			to_chat(user, "<span class='notice'>You start disassembling the [src]'s chassis... </span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You disassemble the [src]'s fuselage</span>")
				new/obj/structure/fighter_component/utility_chassis_crate (loc, 1)
				qdel(src)
				return TRUE

/obj/structure/fighter_component/underconstruction_fighter/utility_vessel_frame/multitool_act(mob/user, obj/item/tool)
	. = FALSE
	switch(build_state)
		if(UBS_APU_WIRE)
			to_chat(user, "<span class='notice'>You start calibrating the APU in [src]...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You calibrate the APU in [src].</span>")
				build_state = UBS_APU_MULTI
				update_icon()
				return TRUE
		if(UBS_APU_MULTI)
			to_chat(user, "<span class='notice'>You start resetting the APU in [src]...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You reset the APU in [src].</span>")
				build_state = UBS_APU_WIRE
				update_icon()
				return TRUE
		if(UBS_PRIMARY_BOLT)
			to_chat(user, "<span class='notice'>You start calibrating the primary module in [src]...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You calibrate the primary module in [src].</span>")
				build_state = UBS_PRIMARY_MULTI
				update_icon()
				return TRUE
		if(UBS_PRIMARY_MULTI)
			to_chat(user, "<span class='notice'>You start resetting the primary module in [src]...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You reset the primary module in [src].</span>")
				build_state = UBS_PRIMARY_BOLT
				update_icon()
				return TRUE
		if(UBS_SECONDARY_BOLT)
			to_chat(user, "<span class='notice'>You start calibrating the secondary module in [src]...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You calibrate the secondary module in [src].</span>")
				build_state = UBS_SECONDARY_MULTI
				update_icon()
				return TRUE
		if(UBS_SECONDARY_MULTI)
			to_chat(user, "<span class='notice'>You start resetting the secondary module in [src]...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You reset the secondary module in [src].</span>")
				build_state = UBS_SECONDARY_BOLT
				update_icon()
				return TRUE
		if(UBS_AVIONICS_WIRE)
			to_chat(user, "<span class='notice'>You start calibrating the avionics in [src]...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You calibrate the avionics in [src].</span>")
				build_state = UBS_AVIONICS_MULTI
				update_icon()
				return TRUE
		if(UBS_AVIONICS_MULTI)
			to_chat(user, "<span class='notice'>You start resetting the avionics in [src]...</span>")
			if(tool.use_tool(src, user, 40, volume=100))
				to_chat(user, "<span class='notice'>You reset the avionics in [src].</span>")
				build_state = UBS_AVIONICS_WIRE
				update_icon()
				return TRUE

/obj/structure/fighter_component/underconstruction_fighter/utility_vessel_frame/attack_hand(mob/user)
	.=..()
	if(build_state == UBS_PAINT_DETAILING)
		fighter_name = input(user, "Name Utility Vessel:","Finalize Utility Vessel Construction","")
		new_fighter(fighter_name)
		qdel(src)

/obj/structure/fighter_component/underconstruction_fighter/utility_vessel_frame/proc/new_fighter(fighter_name)
	var/obj/structure/overmap/fighter/utility/UC = new/obj/structure/overmap/fighter/utility (loc, 1)
	UC.name = fighter_name
	for(var/atom/movable/C in contents)
		C.forceMove(UC)

/obj/structure/fighter_component/underconstruction_fighter/utility_vessel_frame/update_icon()
	cut_overlays()
	switch(build_state)
		if(UBS_CHASSIS)
			icon_state = "smmop"
		if(UBS_CHASSIS_BOLT)
			icon_state = "smmop"
		if(UBS_CHASSIS_WELD)
			icon_state = "smmop"
		if(UBS_ENGINE)
			icon_state = "smmop"
		if(UBS_ENGINE_BOLT)
			icon_state = "smmop"
		if(UBS_APU)
			icon_state = "smmop"
		if(UBS_APU_WIRE)
			icon_state = "smmop"
		if(UBS_APU_MULTI)
			icon_state = "smmop"
		if(UBS_FUEL_TANK)
			icon_state = "smmop"
		if(UBS_FUEL_TANK_BOLT)
			icon_state = "smmop"
		if(UBS_PRIMARY)
			icon_state = "smmop"
		if(UBS_PRIMARY_BOLT)
			icon_state = "smmop"
		if(UBS_PRIMARY_MULTI)
			icon_state = "smmop"
		if(UBS_SECONDARY)
			icon_state = "smmop"
		if(UBS_SECONDARY_BOLT)
			icon_state = "smmop"
		if(UBS_SECONDARY_MULTI)
			icon_state = "smmop"
		if(UBS_COUNTERMEASURE_DISPENSER)
			icon_state = "smmop"
		if(UBS_COUNTERMEASURE_DISPENSER_BOLT)
			icon_state = "smmop"
		if(UBS_AVIONICS)
			icon_state = "smmop"
		if(UBS_AVIONICS_WIRE)
			icon_state = "smmop"
		if(UBS_AVIONICS_MULTI)
			icon_state = "smmop"
		if(UBS_ARMOUR_PLATING)
			icon_state = "smmop"
		if(UBS_ARMOUR_PLATING_BOLT)
			icon_state = "smmop"
		if(UBS_ARMOUR_PLATING_WELD)
			icon_state = "smmop"
		if(UBS_PAINT_PRIMER)
			icon_state = "smmop"
		if(UBS_PAINT_DETAILING)
			icon_state = "smmop"

#undef UBS_CHASSIS
#undef UBS_CHASSIS_BOLT
#undef UBS_CHASSIS_WELD
#undef UBS_ENGINE
#undef UBS_ENGINE_BOLT
#undef UBS_APU
#undef UBS_APU_WIRE
#undef UBS_APU_MULTI
#undef UBS_FUEL_TANK
#undef UBS_FUEL_TANK_BOLT
#undef UBS_PRIMARY
#undef UBS_PRIMARY_BOLT
#undef UBS_PRIMARY_MULTI
#undef UBS_SECONDARY
#undef UBS_SECONDARY_BOLT
#undef UBS_SECONDARY_MULTI
#undef UBS_COUNTERMEASURE_DISPENSER
#undef UBS_COUNTERMEASURE_DISPENSER_BOLT
#undef UBS_AVIONICS
#undef UBS_AVIONICS_WIRE
#undef UBS_AVIONICS_MULTI
#undef UBS_ARMOUR_PLATING
#undef UBS_ARMOUR_PLATING_BOLT
#undef UBS_ARMOUR_PLATING_WELD
#undef UBS_PAINT_PRIMER
#undef UBS_PAINT_DETAILING