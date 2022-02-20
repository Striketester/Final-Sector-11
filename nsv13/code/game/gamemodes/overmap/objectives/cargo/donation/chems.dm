/datum/overmap_objective/cargo/donation/chems
	name = "Donate medical chemicals"
	desc = "Donate 1 or more chemical bottles"
	pick_same_destination = TRUE
	crate_name = "Chemicals crate"
	var/list/chemicals = list()

/datum/overmap_objective/cargo/donation/chems/New( var/datum/reagent/medicine )
	if ( medicine )
		chemicals += medicine
	else // Haven't picked one yet? Don't worry, we got you covered!
		get_random_chems()
	setup_freight_type_group()

/datum/overmap_objective/cargo/donation/chems/proc/get_random_chems()
	message_admins( "get_random_chems" )
	var/list/possible_chemicals = list()

	for( var/D in subtypesof( /datum/chemical_reaction ) )
		var/datum/chemical_reaction/C = new D()
		if ( C.id )
			if ( ispath( C.id, /datum/reagent/medicine ) )
				possible_chemicals += C.id

	for( var/i = 0; i < rand( 1, 3 ); i++ )
		var/datum/reagent/medicine/picked = pick_n_take( possible_chemicals )
		chemicals += picked
	message_admins( length( chemicals ) )

/datum/overmap_objective/cargo/donation/chems/proc/setup_freight_type_group()
	message_admins( "setup_freight_type_group" )
	message_admins( length( chemicals ) )
	var/list/F = list()

	for ( var/picked in chemicals )
		var/list/A = list()
		message_admins( picked )
		var/datum/freight_type/single/reagent/R = new /datum/freight_type/single/reagent( picked )
		R.target = ( 90 / length( chemicals ) )
		A += R
		var/datum/freight_type/single/reagent/pill_patch/P = new /datum/freight_type/single/reagent/pill_patch( picked )
		P.target = R.target
		A += P

		// Create a group for a single medicine type, such that any one of these medicine types may be submitted
		F += new /datum/freight_type/group/require/any( A )

	message_admins( length( F ) )
	// Bundle all medicine types together and require one of each medicine to be submitted
	freight_type_group = new /datum/freight_type/group/require/all( F )

