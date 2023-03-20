/datum/design/replicator
	var/cost
	var/list/alt_name = list()

/datum/design/replicator/tier1/boiledegg
	name = "Boiled egg"
	id = "boiledegg"
	alt_name = list("egg")
	build_type = REPLICATOR
	build_path = /obj/item/reagent_containers/food/snacks/boiledegg
	category = list("initial","Tier 1")

/datum/design/replicator/tier1/boiledrice
	name = "Boiled rice"
	id = "boiledrice"
	alt_name = list("rice")
	build_type = REPLICATOR
	build_path = /obj/item/reagent_containers/food/snacks/salad/boiledrice
	category = list("initial","Tier 1")

/datum/design/replicator/tier1/rationpack
	name = "Ration pack"
	id = "rationpack"
	alt_name = list("nutrients", "nutritional supplement")
	build_type = REPLICATOR
	build_path = /obj/item/reagent_containers/food/snacks/rationpack
	category = list("initial","Tier 1")

/datum/design/replicator/tier1/drinkingglass
	name = "Drinking glass"
	id = "drinkingglass"
	alt_name = list("glass")
	build_type = REPLICATOR
	build_path = /obj/item/reagent_containers/food/drinks/drinkingglass
	category = list("initial","Tier 1")

/datum/design/replicator/tier1/shotglass
	name = "Shot glass"
	id = "shotglass"
	build_type = REPLICATOR
	build_path = /obj/item/reagent_containers/food/drinks/drinkingglass/shotglass
	category = list("initial","Tier 1")

/datum/design/replicator/tier1/tea
	name = "Tea Earl Grey"
	id = "tea"
	build_type = REPLICATOR
	category = list("initial","Tier 1")

/datum/design/replicator/tier1/surprise
	name = "Surprise me"
	id = "surprise"
	alt_name = list("you choose", "something", "i dont care")
	build_type = REPLICATOR
	category = list("initial","Tier 1")

/datum/design/replicator/tier1/tier2disk
	name = "Pattern Upgrade disk (Tier 2)"
	id = "tier2disk"
	build_type = REPLICATOR
	build_path = /obj/item/disk/design_disk/replicator/tier2
	cost = 2000 // 2000 Biomass in order to unlock the Tier 2 recipes
	category = list("initial","Tier 1")

/datum/design/replicator/tier2/burger
	name = "Burger"
	id = "burger"
	build_type = REPLICATOR
	build_path = /obj/item/reagent_containers/food/snacks/burger/plain
	category = list("Tier 2")

/datum/design/replicator/tier2/steak
	name = "Steak"
	id = "steak"
	build_type = REPLICATOR
	build_path = /obj/item/reagent_containers/food/snacks/meat/steak/plain
	category = list("Tier 2")

/datum/design/replicator/tier2/fries
	name = "Fries"
	id = "fries"
	build_type = REPLICATOR
	build_path = /obj/item/reagent_containers/food/snacks/fries
	category = list("Tier 2")

/datum/design/replicator/tier2/onionrings
	name = "Onion rings"
	id = "onionrings"
	build_type = REPLICATOR
	build_path = /obj/item/reagent_containers/food/snacks/onionrings
	category = list("Tier 2")

/datum/design/replicator/tier2/pancakes
	name = "Pancakes"
	id = "pancakes"
	build_type = REPLICATOR
	build_path = /obj/item/reagent_containers/food/snacks/pancakes
	category = list("Tier 2")

/datum/design/replicator/tier2/coffee
	name = "Coffee"
	id = "coffee"
	build_type = REPLICATOR
	category = list("Tier 2")

/datum/design/replicator/tier2/tier3disk
	name = "Pattern Upgrade disk (Tier 3)"
	id = "tier3disk"
	build_type = REPLICATOR
	build_path = /obj/item/disk/design_disk/replicator/tier3
	cost = 3000 // 3000 Biomass in order to unlock the Tier 3 recipes
	category = list("Tier 2")

/datum/design/replicator/tier3/cheesepizza
	name = "Cheese pizza"
	id = "cheesepizza"
	build_type = REPLICATOR
	build_path = /obj/item/reagent_containers/food/snacks/pizzaslice/margherita
	category = list("Tier 3")

/datum/design/replicator/tier3/meatpizza
	name = "Meat pizza"
	id = "meatpizza"
	build_type = REPLICATOR
	build_path = /obj/item/reagent_containers/food/snacks/pizzaslice/meat
	category = list("Tier 3")

/datum/design/replicator/tier3/mushroompizza
	name = "Mushroom pizza"
	id = "mushroompizza"
	build_type = REPLICATOR
	build_path = /obj/item/reagent_containers/food/snacks/pizzaslice/mushroom
	category = list("Tier 3")

/datum/design/replicator/tier3/veggiepizza
	name = "Vegetable pizza"
	id = "veggiepizza"
	alt_name = list("veggie pizza")
	build_type = REPLICATOR
	build_path = /obj/item/reagent_containers/food/snacks/pizzaslice/vegetable
	category = list("Tier 3")

/datum/design/replicator/tier3/pineapplepizza
	name = "Pineapple pizza"
	id = "pineapplepizza"
	alt_name = list("an insult to pizza")
	build_type = REPLICATOR
	build_path = /obj/item/reagent_containers/food/snacks/pizzaslice/pineapple
	category = list("Tier 3")

/datum/design/replicator/tier3/donkpizza
	name = "Donkpocket pizza"
	id = "donkpizza"
	alt_name = list("donk pizza")
	build_type = REPLICATOR
	build_path = /obj/item/reagent_containers/food/snacks/pizzaslice/donkpocket
	category = list("Tier 3")

/datum/design/replicator/tier3/tier4disk
	name = "Pattern Upgrade disk (Tier 4)"
	id = "tier4disk"
	build_type = REPLICATOR
	build_path = /obj/item/disk/design_disk/replicator/tier4
	cost = 4000 // 4000 Biomass in order to unlock the Tier 3 recipes
	category = list("Tier 3")

/datum/design/replicator/tier4/cakebatter
	name = "Cake batter"
	id = "cakebatter"
	build_type = REPLICATOR
	build_path = /obj/item/reagent_containers/food/snacks/cakebatter
	category = list("Tier 4")

/datum/design/replicator/tier4/dough
	name = "Dough"
	id = "dough"
	build_type = REPLICATOR
	build_path = /obj/item/reagent_containers/food/snacks/dough
	category = list("Tier 4")

/datum/design/replicator/tier4/eggbox
	name = "Egg box"
	id = "eggbox"
	build_type = REPLICATOR
	build_path = /obj/item/storage/fancy/egg_box
	category = list("Tier 4")

/datum/design/replicator/tier4/flour
	name = "Flour"
	id = "flour"
	build_type = REPLICATOR
	build_path = /obj/item/reagent_containers/food/condiment/flour
	category = list("Tier 4")

/datum/design/replicator/tier4/milk
	name = "Milk"
	id = "milkies"
	build_type = REPLICATOR
	build_path = /obj/item/reagent_containers/food/condiment/milk
	category = list("Tier 4")

/datum/design/replicator/tier4/enzymes
	name = "Enzymes"
	id = "enzymes"
	build_type = REPLICATOR
	build_path = /obj/item/reagent_containers/food/condiment/enzyme
	category = list("Tier 4")

/datum/design/replicator/tier4/cheesewheel
	name = "Cheese wheel"
	id = "cheesywheely"
	build_type = REPLICATOR
	build_path = /obj/item/reagent_containers/food/snacks/store/cheesewheel
	category = list("Tier 4")

/datum/design/replicator/tier4/meatslab
	name = "Meat slab"
	id = "meatslab"
	alt_name = list("slab of meat")
	build_type = REPLICATOR
	build_path = /obj/item/reagent_containers/food/snacks/meat/slab
	category = list("Tier 4")

/datum/design/replicator/tier4/active_iguana
	name = "Activate iguana"
	id = "activeiguana"
	build_type = REPLICATOR
	category = list("Tier 4")

/datum/design/replicator/tier4/deactive_iguana
	name = "Deactivate iguana"
	id = "deactiveiguana"
	build_type = REPLICATOR
	category = list("Tier 4")
