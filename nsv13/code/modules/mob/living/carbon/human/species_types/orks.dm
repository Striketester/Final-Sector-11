#define isork(A) (is_species(A, /datum/species/ork))

//They follow standard naming conventions, usually either a streetname or a chinese name tho.
//Not really any notable history, they've never formed a modern nation or major movement.
//Due to being newer to the scene, along with short lived, and slightly lower intelligence.
//Their major downside is a notable lack of upward mobility and equipment thats shoddy at best.

//Still more options than a troll though.
//More than likely they might see a ork sized eva suit, but probably not.

/datum/species/ork //Not to be confused with the warhammer 40k ork, this is a shadowrun ork.
	name = "Ork" //A close relative to the human, hes just a bit stronger. With a vastly shorter lifespan.
	id = "ork" //Also called Homo sapiens robustus. Known to be less intelligent.
	default_color = "FFFFFF" //Capable of interbreeding, can be any skintone or race.
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,NO_UNDERWEAR)
	inherent_traits = list(TRAIT_STRONG_GRABBER) //Not resistant to the environment like dorves.
	default_features = list("mcolor" = "FFF", "wings" = "None") //Nothing special about these guys.
	limbs_id = "ork"
	use_skintones = 1 //Standard skintones.
	skinned_type = /obj/item/stack/sheet/animalhide/human
	liked_food = JUNKFOOD | FRIED //Similar tastes to a humans.
	disliked_food = GROSS | PINEAPPLE //Willing to eat raw food, hates gross food and pineapples.
	brutemod = 0.9 //All he has going for him is a tiny bit of innate damage reduction.
	burnmod = 0.9 //Burns less to lasers.
	armor = 5 //and a slightly tougher hide, actually more of a pure-bred warrior race than humanity
	speedmod = 0.2 //And should be faster than humans, but need more downsides.
	punchdamagelow = 3 //And greater punch potential.
	punchdamagehigh = 15 // Pretty good, but still worse than many combat melee weapons (along with rng)

	//Pixel X, and Pixel Y.
	offset_features = list(
		OFFSET_UNIFORM = list(0,0), 
		OFFSET_ID = list(0,0), 
		OFFSET_GLOVES = list(0,0), 
		OFFSET_GLASSES = list(0,1), 
		OFFSET_EARS = list(0,1), 
		OFFSET_SHOES = list(0,0), 
		OFFSET_S_STORE = list(0,0), 
		OFFSET_FACEMASK = list(0,1), 
		OFFSET_HEAD = list(0,1), 
		OFFSET_HAIR = list(0,1), //1 pixel taller than a human.
		OFFSET_FHAIR = list(0,1), 
		OFFSET_FACE = list(0,1), 
		OFFSET_BELT = list(0,0), 
		OFFSET_BACK = list(0,2), //haha ah ha
		OFFSET_SUIT = list(0,0), 
		OFFSET_NECK = list(0,1)
		)

/mob/living/carbon/human/species/ork //species spawn path
	race = /datum/species/ork //and the race the path is set to.

/datum/species/ork/qualifies_for_rank(rank, list/features)
	if(rank in GLOB.command_positions) //no orks in command.
		return 0
	if(rank in GLOB.medical_positions) //no orks in medical, untrustworthy
		return 0
	if(rank in GLOB.science_positions) //and no orks in science, not like they live long enough.
		return 0
	if(rank in GLOB.engineering_positions) //while capable of engineering, thats not what they'd be hired for.
		return 0
	//List of Civ positions not allowed in as they can take some
	var/list/civpositions = list("Lawyer","Curator","Mime","Chaplain")
	if(rank in civpositions)
		return 0
	//List of Sec positions not allowed in as they can take some
	var/list/secpositions = list("Master At Arms")
	if(rank in secpositions)
		return 0
	//List of Supply positions not allowed in as they can take some
	var/list/supplypositions = list("Shaft Miner")
	if(rank in supplypositions)
		return 0
	return 1 //Otherwise you can enjoy security, or service.

/datum/species/ork/before_equip_job(datum/job/J, mob/living/carbon/human/H, visualsOnly = FALSE)
	var/current_job = J.title
	var/datum/outfit/ork/O = new /datum/outfit/ork //Species Job Outfits.
	switch(current_job) //See: nsv13/code/modules/clothing/outfits/ork.dm for the object paths

		if("Assistant") //Basically it runs before job equip, the normal job equip happens after.
			O = new /datum/outfit/ork/assistant //The normal job outfit is only equipped if possible.
	
		if("Botanist")
			O = new /datum/outfit/ork/botany

		if("Bartender")
			O = new /datum/outfit/ork/bar

		if("Janitor")
			O = new /datum/outfit/ork/janitor

		if("Cook")
			O = new /datum/outfit/ork/chef

		if("Security Officer")
			O = new /datum/outfit/ork/security

		if("Detective")
			O = new /datum/outfit/ork/detective

		if("Quartermaster")
			O = new /datum/outfit/ork/quartermaster

		if("Cargo Technician")
			O = new /datum/outfit/ork/cargotech

		if("Clown")
			O = new /datum/outfit/ork/clown

	H.equipOutfit(O, visualsOnly)
	return 0