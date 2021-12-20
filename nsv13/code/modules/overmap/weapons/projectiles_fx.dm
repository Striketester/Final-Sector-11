/**

Misc projectile types, effects, think of this as the special FX file.

*/

/obj/item/projectile/bullet/aa_round
	icon = 'nsv13/icons/obj/projectiles_nsv.dmi'
	icon_state = "pdc"
	name = "anti-aircraft round"
	damage = 40
	flag = "overmap_light"
	spread = 5

/obj/item/projectile/bullet/aa_round/heavy //do we even use this anymore?
	damage = 10
	flag = "overmap_heavy"
	spread = 5

/obj/item/projectile/bullet/mac_relayed_round	//Projectile relayed by all default MAC shells on overmap hit. No difference for AP / others as their values don't really matter on z level.
	icon = 'nsv13/icons/obj/projectiles_nsv.dmi'
	icon_state = "railgun"
	name = "artillery round"
	damage = 60
	range = 255
	speed = 1.85
	movement_type = FLYING | UNSTOPPABLE

/obj/item/projectile/bullet/mac_round
	icon = 'nsv13/icons/obj/projectiles_nsv.dmi'
	icon_state = "railgun"
	name = "artillery round"
	damage = 400
	speed = 1.85
	//Not easily stopped.
	obj_integrity = 300
	max_integrity = 300
	homing_turn_speed = 2.5
	flag = "overmap_heavy"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/torpedo
	relay_projectile_type =  /obj/item/projectile/bullet/mac_relayed_round
	var/homing_benefit_time = 0 SECONDS //NAC shells have a very slight homing effect.
	var/base_movement_type	//Our base move type for when we gain unstoppability from hitting tiny ships.

/obj/item/projectile/bullet/mac_round/prehit(atom/target)
	if(isovermap(target))
		var/obj/structure/overmap/OM = target
		if(OM.mass <= MASS_TINY)
			movement_type |= UNSTOPPABLE //Small things don't stop us.
		else
			movement_type = base_movement_type
	. = ..()

/obj/item/projectile/bullet/mac_round/Initialize()
	. = ..()
	base_movement_type = movement_type
	if(homing_benefit_time)
		addtimer(CALLBACK(src, .proc/stop_homing), homing_benefit_time)
	else
		addtimer(CALLBACK(src, .proc/stop_homing), 0.2 SECONDS)	//Because all deck guns apparently have slight homing.

/obj/item/projectile/bullet/proc/stop_homing()
	homing = FALSE

/obj/item/projectile/bullet/mac_round/ap
	damage = 250
	armour_penetration = 70
	icon_state = "railgun_ap"
	movement_type = FLYING | UNSTOPPABLE //Railguns punch straight through your ship

/obj/item/projectile/bullet/mac_round/magneton
	speed = 1.5
	damage = 325
	homing_benefit_time = 2.5 SECONDS
	homing_turn_speed = 30

//Improvised ammunition, does terrible damage but is cheap to produce
/obj/item/projectile/bullet/mac_round/cannonshot
	name = "cannonball"
	damage = 350
	icon_state = "cannonshot"
	flag = "overmap_medium"

#define DIRTY_SHELL_TURF_SLUDGE_PROB 70	//Chance for sludge to spawn on a turf within the sludge range of the detonation turf. Detonation turf always gets an epicenter sludge.
#define DIRTY_SHELL_SLUDGE_RANGE 3	//Un-random sludge event radius (for the shell detonating)
#define DIRTY_SHELL_PELLET_PROB 80	//Chance for a pellet per tile from the outer circle
#define DIRTY_SHELL_PELLET_RANGE 6	//Picks all turfs on the other circle of this range and uses them as possible targets for pellets.

//Dirty shell: Stage 1 - overmap projectile
/obj/item/projectile/bullet/mac_round/dirty
	damage = 150
	name = "dirty artillery round"
	relay_projectile_type = /obj/item/projectile/bullet/delayed_prime/dirty_shell_stage_two


//Delayed priming projectile parent type - useful for a few different kinds of projectiles so why not.
/obj/item/projectile/bullet/delayed_prime
	icon = 'nsv13/icons/obj/projectiles_nsv.dmi'
	icon_state = "railgun"
	name = "uh oh this isn't supposed to exist!"
	range = 255
	speed = 1.85
	movement_type = FLYING | UNSTOPPABLE
	damage = 45		//It's on a z now, lets not instakill people / objects this happens to hit.
	var/penetration_fuze = 1	//Will pen through this many things considered valid for reducing this before arming. Can overpenetrate if it happens to pen through windows or other things with not enough resistance.

/obj/item/projectile/bullet/delayed_prime/on_hit(atom/target, blocked)
	. = ..()
	penetration_fuze -= fuze_trigger_value(target)

/obj/item/projectile/bullet/delayed_prime/proc/fuze_trigger_value(atom/target)
	return 0

/obj/item/projectile/bullet/delayed_prime/Move(atom/newloc, dir)
	. = ..()
	if(!.)
		return
	if(is_valid_to_release(newloc))
		release_payload(newloc)
		qdel(src)

/obj/item/projectile/bullet/delayed_prime/proc/is_valid_to_release(atom/newloc)
	return

/obj/item/projectile/bullet/delayed_prime/proc/release_payload(atom/detonation_location)
	return

//Dirty shell: Stage 2 - z level sludge payload projectile
/obj/item/projectile/bullet/delayed_prime/dirty_shell_stage_two
	name = "dirty artillery round"
	icon_state = "railgun"
	penetration_fuze = 4

/obj/item/projectile/bullet/delayed_prime/dirty_shell_stage_two/fuze_trigger_value(atom/target)
	if(!isclosedturf(target))
		return 0
	return 1

/obj/item/projectile/bullet/delayed_prime/dirty_shell_stage_two/is_valid_to_release(atom/newloc)
	if(penetration_fuze > 0 || !isopenturf(newloc))
		return FALSE
	var/turf/newturf = newloc
	if(is_blocked_turf(newturf, TRUE))
		return FALSE
	return TRUE

/obj/item/projectile/bullet/delayed_prime/dirty_shell_stage_two/release_payload(atom/detonation_location)
	var/turf/detonation_turf = detonation_location
	explosion(detonation_turf, 0, 0, 5, 8, flame_range = 3)
	var/list/inrange_turfs = RANGE_TURFS(DIRTY_SHELL_SLUDGE_RANGE, detonation_turf) - detonation_turf
	new /obj/effect/decal/nuclear_waste/epicenter(detonation_turf)
	for(var/turf/T as() in inrange_turfs)
		if(isgroundlessturf(T))	//Should those kinds of turfs be able to get waste from this? Hmm, I dunno.
			continue
		if(isclosedturf(T) || is_blocked_turf(T, TRUE))	//Definitely not on closed turfs, for now also not on ones blocked by stuff to not make it agonizing.. unless?
			continue
		if(locate(/obj/effect/decal/nuclear_waste) in T)	//No stacking.
			continue
		if(!prob(DIRTY_SHELL_TURF_SLUDGE_PROB))
			continue
		new /obj/effect/decal/nuclear_waste(T)
	var/list/shootat_turfs = RANGE_TURFS(DIRTY_SHELL_PELLET_RANGE, detonation_turf) - RANGE_TURFS(DIRTY_SHELL_PELLET_RANGE-1, detonation_turf)
	for(var/turf/shootat_turf as() in shootat_turfs)
		if(!prob(DIRTY_SHELL_PELLET_PROB))
			continue
		var/obj/item/projectile/energy/nuclear_particle/dirty_shell_stage_three/P = new(detonation_turf)
		//Shooting Code:
		P.random_color_time()
		P.range = DIRTY_SHELL_PELLET_RANGE+1
		P.preparePixelProjectile(shootat_turf, detonation_turf)
		P.fire()


//Dirty Shell: Stage 3 - spread of irradiating pellets
/obj/item/projectile/energy/nuclear_particle/dirty_shell_stage_three
	irradiate = 300	//Less radiation than the "true" gumballs
	name = "irradiated pellet"

/obj/item/projectile/energy/nuclear_particle/dirty_shell_stage_three/on_hit(atom/target, blocked)
	. = ..()
	if(!isturf(target))
		target.AddComponent(/datum/component/radioactive, 300, target, 5 MINUTES)

#undef DIRTY_SHELL_TURF_SLUDGE_PROB
#undef DIRTY_SHELL_SLUDGE_RANGE
#undef DIRTY_SHELL_PELLET_PROB
#undef DIRTY_SHELL_PELLET_RANGE

/obj/item/projectile/bullet/delayed_prime/relayed_incendiary_torpedo
	icon_state = "torpedo_hellfire"
	name = "incendiary torpedo"
	penetration_fuze = 2

/obj/item/projectile/bullet/delayed_prime/relayed_incendiary_torpedo/fuze_trigger_value(atom/target)
	if(isclosedturf(target))
		return 1
	
	if(isliving(target))	//Someone got bonked by an incendiary torpedo, daamn.
		var/mob/living/L = target
		if(L.mind && L.mind.assigned_role == "Clown")
			return (prob(50) ? 2 : -2)	//We all know clowns are cursed.
		return 2	

	return 0

/obj/item/projectile/bullet/delayed_prime/relayed_incendiary_torpedo/is_valid_to_release(atom/newloc)
	if(penetration_fuze > 0 || !isopenturf(newloc))
		return FALSE
	return TRUE

/obj/item/projectile/bullet/delayed_prime/relayed_incendiary_torpedo/release_payload(atom/detonation_location)
	var/turf/detonation_turf = detonation_location
	explosion(detonation_turf, 0, 0, 4, 7, flame_range = 4)
	detonation_turf.atmos_spawn_air("o2=75;plasma=425;TEMP=1000")

/obj/item/projectile/bullet/delayed_prime/relayed_viscerator_torpedo
	icon_state = "torpedo"
	name = "armoured torpedo"
	penetration_fuze = 3
	damage = 25

/obj/item/projectile/bullet/delayed_prime/relayed_viscerator_torpedo/fuze_trigger_value(atom/target)
	if(isclosedturf(target))
		return 1
	return 0

/obj/item/projectile/bullet/delayed_prime/relayed_viscerator_torpedo/is_valid_to_release(atom/newloc)
	if(penetration_fuze > 0 || !isopenturf(newloc))
		return FALSE
	return TRUE

/obj/item/projectile/bullet/delayed_prime/relayed_viscerator_torpedo/release_payload(atom/detonation_location)
	var/turf/detonation_turf = detonation_location
	new /obj/effect/dummy/lighting_obj(detonation_turf, LIGHT_COLOR_WHITE, 9, 4, 2)
	playsound(detonation_turf, 'sound/effects/phasein.ogg', 100, 1)
	for(var/mob/living/L in viewers(7, detonation_turf))
		L.flash_act(affect_silicon = TRUE)
	for(var/i = 1; i <= 13; i++)
		new /mob/living/simple_animal/hostile/viscerator(detonation_turf)	//MANHACKS!1!!
	

/obj/item/projectile/bullet/railgun_slug
	icon_state = "mac"
	name = "tungsten slug"
	icon = 'nsv13/icons/obj/projectiles_nsv.dmi'
	damage = 150
	speed = 1
	homing_turn_speed = 2
	flag = "overmap_heavy"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/torpedo

/obj/item/projectile/bullet/railgun_slug/uranium //Heavier version
	name = "uranium slug"
	damage = 185
	armour_penetration = 10

// I think the idea is that they course-correct slightly, but only once? -Corvid
/obj/item/projectile/bullet/railgun_slug/process_homing()
	. = ..()
	homing = FALSE

/obj/item/projectile/bullet/gauss_slug
	icon_state = "gaussgun"
	name = "tungsten round"
	icon = 'nsv13/icons/obj/projectiles_nsv.dmi'
	damage = 80
	obj_integrity = 500 //Flak doesn't shoot this down....
	flag = "overmap_medium"

/obj/item/projectile/bullet/light_cannon_round
	icon_state = "pdc"
	name = "light cannon round"
	icon = 'nsv13/icons/obj/projectiles_nsv.dmi'
	damage = 40
	armour_penetration = 2
	spread = 2
	flag = "overmap_light"

/obj/item/projectile/bullet/heavy_cannon_round
	icon_state = "pdc"
	name = "heavy cannon round"
	icon = 'nsv13/icons/obj/projectiles_nsv.dmi'
	damage = 30
	spread = 5
	flag = "overmap_medium"

/obj/item/projectile/bullet/hailstorm_bullet
	icon_state = "50cal"
	name = "hailstorm fragment"
	damage = 20
	spread = 90
	flag = "overmap_medium"

/obj/item/projectile/guided_munition
	obj_integrity = 50
	max_integrity = 50
	density = TRUE
	armor = list("overmap_light" = 10, "overmap_medium" = 0, "overmap_heavy" = 0)

/obj/item/projectile/guided_munition/torpedo
	icon_state = "torpedo"
	name = "plasma torpedo"
	icon = 'nsv13/icons/obj/projectiles_nsv.dmi'
	speed = 2.75
	valid_angle = 150
	homing_turn_speed = 35
	damage = 250
	obj_integrity = 40
	max_integrity = 40
	range = 250
	armor = list("overmap_light" = 20, "overmap_medium" = 10, "overmap_heavy" = 0)
	flag = "overmap_heavy"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/torpedo
	spread = 5 //Helps them not get insta-bonked when launching

/obj/item/projectile/guided_munition/torpedo/viscerator
	//icon_state = "???"	- alt sprite would be nice
	name = "armoured torpedo"
	relay_projectile_type = /obj/item/projectile/bullet/delayed_prime/relayed_viscerator_torpedo
	damage = 75	//Simply kinetic damagewise..
	flag = "overmap_medium"
	obj_integrity = 80
	max_integrity = 80

/obj/item/projectile/guided_munition/torpedo/shredder
	icon_state = "torpedo_shredder"
	name = "plasma charge"
	damage = 200
	armour_penetration = 40

/obj/item/projectile/guided_munition/torpedo/decoy
	icon_state = "torpedo"
	damage = 0
	obj_integrity = 200
	max_integrity = 200

/obj/item/projectile/guided_munition/torpedo/hellfire
	icon_state = "torpedo_hellfire"
	name = "hellfire missile"
	damage = 350
	obj_integrity = 25
	max_integrity = 25
	impact_effect_type = /obj/effect/temp_visual/nuke_impact
	shotdown_effect_type = /obj/effect/temp_visual/nuke_impact
	relay_projectile_type = /obj/item/projectile/bullet/delayed_prime/relayed_incendiary_torpedo

/obj/item/projectile/guided_munition/torpedo/disruptor
	icon_state = "torpedo_disruptor"
	name = "disruption torpedo"
	damage = 140	//Lower damage, does some special stuff when it hits a target.

//What you get from an incomplete torpedo.
/obj/item/projectile/guided_munition/torpedo/dud
	icon_state = "torpedo_dud"
	damage = 0

/obj/item/projectile/guided_munition/Initialize()
	. = ..()
	addtimer(CALLBACK(src, .proc/windup), 1 SECONDS)

/obj/item/projectile/guided_munition/proc/windup()
	valid_angle = 360 //Torpedoes "wind up" to hit their target
	homing_turn_speed *= 5
	homing_turn_speed = CLAMP(homing_turn_speed, 0, 360)
	sleep(clearance_time) //Let it get clear of the sender.
	valid_angle = initial(valid_angle)
	homing_turn_speed = initial(homing_turn_speed)

/obj/item/projectile/guided_munition/missile
	name = "\improper Triton cruise missile"
	icon = 'nsv13/icons/obj/projectiles_nsv.dmi'
	icon_state = "conventional_missile"
	speed = 1
	damage = 175
	valid_angle = 120
	homing_turn_speed = 25
	range = 250
	flag = "overmap_medium"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/torpedo
	spread = 5 //Helps them not get insta-bonked when launching

/obj/effect/temp_visual/overmap_explosion
	icon = 'nsv13/goonstation/icons/hugeexplosion.dmi'
	icon_state = "explosion"
	duration = 10

/obj/effect/temp_visual/overmap_explosion/alt
	icon = 'nsv13/goonstation/icons/hugeexplosion2.dmi'
	icon_state = "explosion"
	duration = 10

//Corvid or someone please refactor this to be less messy.
/obj/item/projectile/guided_munition/on_hit(atom/target, blocked = FALSE)
	..()
	if(!check_faction(target))
		return FALSE 	 //Nsv13 - faction checking for overmaps. We're gonna just cut off real early and save some math if the IFF doesn't check out.
	if(isovermap(target)) //Were we to explode on an actual overmap, this would oneshot the ship as it's a powerful explosion.
		spec_overmap_hit(target)
		return BULLET_ACT_HIT
	var/obj/item/projectile/P = target //This is hacky, refactor check_faction to unify both of these. I'm bodging it for now.
	if(isprojectile(target) && P.faction != faction && !P.nodamage) //Because we could be in the same faction and collide with another bullet. Let's not blow ourselves up ok?
		if(obj_integrity <= P.damage) //Tank the hit, take some damage
			qdel(P)
			explode()
			return BULLET_ACT_HIT
		else
			take_damage(P.damage)
			qdel(P)
			return FALSE //Didn't take the hit
	if(!isprojectile(target)) //This is lazy as shit but is necessary to prevent explosions triggering on the overmap when two bullets collide. Fix this shit please.
		detonate(target)
	else
		return FALSE
	return BULLET_ACT_HIT

/obj/item/projectile/guided_munition/proc/spec_overmap_hit(obj/structure/overmap/target)
	return

/obj/item/projectile/guided_munition/torpedo/disruptor/spec_overmap_hit(obj/structure/overmap/target)
	if(length(target.occupying_levels))
		return	//Detonate is gonna handle this for us.

	if(target.ai_controlled)
		target.disruption += 30
		return

	if(istype(target, /obj/structure/overmap/fighter))
		target.disruption += 25
		return

	//Neither of these? I guess just some visibility penalty it is.
	target.add_sensor_profile_penalty(150, 10 SECONDS)

/obj/item/projectile/guided_munition/bullet_act(obj/item/projectile/P)
	. = ..()
	on_hit(P)

/obj/item/projectile/guided_munition/proc/detonate(atom/target)
	explosion(target, 2, 4, 4)

/obj/item/projectile/guided_munition/torpedo/disruptor/detonate(atom/target)
	empulse(get_turf(target), 5, 12)	//annoying emp.
	explosion(target, 0, 2, 6, 4)	//but only a light explosion.

/* Sleep for now, we'll see you again
/obj/item/projectile/guided_munition/torpedo/nuclear/detonate(atom/target)
	var/obj/structure/overmap/OM = target.get_overmap() //What if I just..........
	if ( OM?.essential )
		return FALSE
	OM?.nuclear_impact()
	explosion(target, 3, 6, 8)

	return BULLET_ACT_HIT
*/

/obj/item/projectile/bullet/pdc_round
	icon_state = "pdc"
	name = "PDC round"
	icon = 'nsv13/icons/obj/projectiles_nsv.dmi'
	damage = 15
	flag = "overmap_light"
	spread = 5

/obj/item/projectile/beam/laser/heavylaser/phaser
	name = "phaser beam"
	damage = 200
	flag = "overmap_heavy"
	hitscan = TRUE //Extremely powerful in ship combat
	icon_state = "omnilaser"
	light_color = LIGHT_COLOR_BLUE
	impact_effect_type = /obj/effect/temp_visual/impact_effect/torpedo
	tracer_type = /obj/effect/projectile/tracer/disabler
	muzzle_type = /obj/effect/projectile/muzzle/disabler
	impact_type = /obj/effect/projectile/impact/disabler

/obj/item/projectile/beam/laser/point_defense
	name = "laser pointer"
	damage = 30
	flag = "overmap_light"
	hitscan = TRUE //Extremely powerful in ship combat
	icon_state = "emitter"
	light_color = LIGHT_COLOR_GREEN
	impact_effect_type = /obj/effect/temp_visual/impact_effect/torpedo
	tracer_type = /obj/effect/projectile/tracer/xray
	muzzle_type = /obj/effect/projectile/muzzle/xray
	impact_type = /obj/effect/projectile/impact/xray

//Designed to be spammed like crazy, but can be buffed to do extremely solid damage when you overclock the guns.
/obj/item/projectile/beam/laser/phaser
	damage = 30
	flag = "overmap_medium"
