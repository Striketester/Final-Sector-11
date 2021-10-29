/datum/job/hos
	title = "Head of Security"
	flag = HOS
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD|DEADMIN_POSITION_SECURITY
	department_head = list("Captain")
	department_flag = ENGSEC
	head_announce = list(RADIO_CHANNEL_SECURITY)
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
	selection_color = "#ffdddd"
	chat_color = "#D33049"
	req_admin_notify = 1
	minimal_player_age = 14
	exp_requirements = 1200
	exp_type = EXP_TYPE_SECURITY
	exp_type_department = EXP_TYPE_SECURITY

	outfit = /datum/outfit/job/hos
	mind_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_SEC_RECORDS, ACCESS_BRIG, ACCESS_BRIGPHYS, ACCESS_ARMORY, ACCESS_COURT, ACCESS_WEAPONS, ACCESS_MECH_SECURITY,
			            ACCESS_FORENSICS_LOCKERS, ACCESS_MORGUE, ACCESS_MAINT_TUNNELS, ACCESS_ALL_PERSONAL_LOCKERS, ACCESS_AUX_BASE,
			            ACCESS_RESEARCH, ACCESS_ENGINE, ACCESS_MINING, ACCESS_MEDICAL, ACCESS_CONSTRUCTION, ACCESS_MAILSORTING,
			            ACCESS_HEADS, ACCESS_HOS, ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_GATEWAY, ACCESS_MAINT_TUNNELS, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_SEC_RECORDS, ACCESS_BRIG, ACCESS_BRIGPHYS, ACCESS_ARMORY, ACCESS_COURT, ACCESS_WEAPONS, ACCESS_MECH_SECURITY,
			            ACCESS_FORENSICS_LOCKERS, ACCESS_MORGUE, ACCESS_MAINT_TUNNELS, ACCESS_ALL_PERSONAL_LOCKERS, ACCESS_AUX_BASE,
			            ACCESS_RESEARCH, ACCESS_ENGINE, ACCESS_MINING, ACCESS_MEDICAL, ACCESS_CONSTRUCTION, ACCESS_MAILSORTING,
			            ACCESS_HEADS, ACCESS_HOS, ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_GATEWAY, ACCESS_MAINT_TUNNELS, ACCESS_MINERAL_STOREROOM)
	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SEC

	display_order = JOB_DISPLAY_ORDER_HEAD_OF_SECURITY
	departments = DEPARTMENT_SECURITY | DEPARTMENT_COMMAND

	species_outfits = list(
		SPECIES_PLASMAMAN = /datum/outfit/plasmaman/hos
	)

/datum/outfit/job/hos
	name = "Head of Security"
	jobtype = /datum/job/hos

	id = /obj/item/card/id/silver
	belt = /obj/item/pda/heads/hos
	ears = /obj/item/radio/headset/heads/hos/alt
	uniform = /obj/item/clothing/under/ship/peacekeeper
	shoes = /obj/item/clothing/shoes/jackboots
	suit = /obj/item/clothing/suit/ship/peacekeeper/jacket
	gloves = /obj/item/clothing/gloves/color/black/hos
	head = /obj/item/clothing/head/HoS/beret
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	r_pocket = /obj/item/assembly/flash/handheld
	l_pocket = /obj/item/restraints/handcuffs
	backpack_contents = list(/obj/item/melee/baton/loaded=1,
		/obj/item/gun/ballistic/tazer,  /obj/item/ammo_box/magazine/tazer_cartridge_storage=1, /obj/item/book/granter/martial/jujitsu, /obj/item/club=1) //NSV13 this line)

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	box = /obj/item/storage/box/security

	implants = list(/obj/item/implant/mindshield)

	chameleon_extras = list(/obj/item/gun/ballistic/automatic/pistol/glock/command/hos, /obj/item/stamp/hos)

/datum/outfit/job/hos/hardsuit
	name = "Head of Security (Hardsuit)"

	mask = /obj/item/clothing/mask/gas/sechailer
	suit = /obj/item/clothing/suit/space/hardsuit/security/hos
	suit_store = /obj/item/tank/internals/oxygen
	backpack_contents = list(/obj/item/melee/baton/loaded=1)

