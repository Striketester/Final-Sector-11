/datum/overmap_objective/cargo/donation/social_supplies
	name = "Donate social supplies"
	desc = "Donate 1 or more social supplies"
	crate_name = "Social Supplies crate"

/datum/overmap_objective/cargo/donation/social_supplies/New() 
	// Pick a cake 
	var/list/picked = pick( list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain,
		/obj/item/reagent_containers/food/snacks/store/cake/carrot,
		/obj/item/reagent_containers/food/snacks/store/cake/birthday,
		/obj/item/reagent_containers/food/snacks/store/cake/cheese,
		/obj/item/reagent_containers/food/snacks/store/cake/chocolate,
		/obj/item/reagent_containers/food/snacks/store/cake/holy_cake,
		/obj/item/reagent_containers/food/snacks/store/cake/pound_cake,
	) )
	var/datum/freight_type/object/cake = new /datum/freight_type/object( new picked() )
	
	// Pick a beer 
	var/list/possible_chemicals = list()

	// Get only craftable chemicals of consumable ethanol 
	for( var/D in subtypesof( /datum/chemical_reaction ) )
		var/datum/chemical_reaction/C = new D()
		if ( C.id )
			if ( ispath( C.id, /datum/reagent/consumable/ethanol ) )
				possible_chemicals += C.id

	var/datum/reagent/consumable/ethanol/picked_ethanol = pick( possible_chemicals )
	var/datum/freight_type/reagent/drinks = new /datum/freight_type/reagent( new picked_ethanol() )
	drinks.target = 200

	// Setup presents 
	var/atom/parcel = new /obj/item/smallDelivery()
	parcel.name = "small parcel"
	var/datum/freight_type/reagent/presents = new /datum/freight_type/object( parcel )
	presents.target = 3

	freight_types += cake
	freight_types += drinks
	freight_types += presents
