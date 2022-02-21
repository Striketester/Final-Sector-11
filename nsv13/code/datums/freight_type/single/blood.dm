/datum/freight_type/single/reagent/blood
	reagent_type = /datum/reagent/blood
	var/blood_type = null
	containers = list(
		/obj/item/reagent_containers/blood
	)
	target = 200 // Standard volume of a blood pack

/datum/freight_type/single/reagent/blood/New( var/type )
	if ( type )
		blood_type = type

	set_item_name()

/datum/freight_type/single/reagent/blood/set_item_name()
	item_name = blood_type
	return TRUE

/datum/freight_type/single/reagent/blood/check_contents( var/datum/freight_type_check/freight_type_check )
	var/list/prepackagedTargets = get_prepackaged_targets( freight_type_check.container )
	if ( prepackagedTargets )
		return prepackagedTargets

	if ( !allow_replacements )
		return FALSE

	var/datum/freight_contents_index/index = new /datum/freight_contents_index()

	for ( var/obj/item/reagent_containers/a in freight_type_check.container.GetAllContents() )
		if ( is_type_in_list( a, containers ) )
			var/datum/reagents/reagents = a.reagents
			for ( var/datum/reagent/blood/R in reagents.reagent_list )
				if ( R.data[ "blood_type" ] == blood_type )
					// Add to contents index for more checks
					index.add_amount( a, R.volume, blood_type )

	var/list/itemTargets = index.get_amount( blood_type, target, TRUE )
	add_inner_contents_as_approved( itemTargets )

	if ( length( itemTargets ) )
		return itemTargets

	return FALSE

/datum/freight_type/single/reagent/blood/get_brief_segment()
	return "blood type [blood_type] ([target] unit" + (target!=1?"s":"") + ")"

/datum/freight_type/single/reagent/blood/get_supply_request_form_segment()
	return "<span>permissible containers: blood bag</span>"
