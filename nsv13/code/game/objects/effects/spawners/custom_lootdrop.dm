/obj/effect/spawner/lootdrop/anti_air
	name = "anti-air gun supplies spawner"
	loot = list(
		/obj/item/ammo_box/magazine/nsv/anti_air = 15,
		/obj/machinery/computer/anti_air = 2,
		/obj/machinery/ship_weapon/anti_air = 1,
		/obj/machinery/ship_weapon/anti_air/heavy = 1
		)
	lootcount = 1

/obj/effect/spawner/lootdrop/railgun
	name = "railgun supplies spawner"
	loot = list(
		/obj/item/ship_weapon/ammunition/railgun_ammo = 15,
		/obj/item/circuitboard/computer/ship/munitions_computer = 2,
		/obj/machinery/ship_weapon/railgun = 1
		)
	lootcount = 2

/obj/effect/spawner/lootdrop/nac_ammo
	name = "NAC ammo spawner"
	loot = list(
		/obj/item/ship_weapon/ammunition/naval_artillery = 1,
		/obj/item/ship_weapon/ammunition/naval_artillery/ap = 1,
		/obj/item/powder_bag = 1,
		/obj/item/powder_bag/plasma = 1,
		/obj/item/ship_weapon/ammunition/naval_artillery/cannonball = 1
		)
	lootcount = 3

/obj/effect/spawner/lootdrop/nac_supplies
	name = "NAC stuff spawner"
	loot = list(
		/obj/item/powder_bag = 10,
		/obj/machinery/computer/deckgun = 1,
		/obj/machinery/deck_turret = 1,
		/obj/machinery/deck_turret/payload_gate = 1,
		/obj/machinery/deck_turret/autoelevator = 1,
		/obj/machinery/deck_turret/powder_gate = 1
		)
	lootcount = 1

/obj/effect/spawner/lootdrop/syndicate_fighter
	name = "syndicate fighter / raptor / frame spawner"
	loot = list(
		/obj/structure/overmap/fighter/light/syndicate = 2,
		/obj/structure/overmap/fighter/dropship/sabre/syndicate = 1,
		/obj/structure/fighter_frame = 1
		)
	lootcount = 1

/obj/effect/spawner/lootdrop/fighter
	name = "nanotrasen fighter / raptor / frame spawner"
	loot = list(
		/obj/structure/overmap/fighter/light = 2,
		/obj/structure/overmap/fighter/dropship/sabre = 1,
		/obj/structure/overmap/fighter/heavy = 1,
		/obj/structure/fighter_frame = 1
		)
	lootcount = 1
