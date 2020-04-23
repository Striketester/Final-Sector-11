/client/verb/mentorhelp(msg as text)
	set category = "Mentor"
	set name = "Mentorhelp"

	if(prefs.muted & MUTE_MHELP)
		to_chat(src, "<span class='danger'>Error: MENTORHELP: You cannot send mentorhelps (Muted).</span>")
		return

	//clean the input msg
	if(!msg)	return

	//remove out mentorhelp verb temporarily to prevent spamming of mentors.
	verbs -= /client/verb/mentorhelp
	spawn(300)
		verbs += /client/verb/mentorhelp	// 30 second cool-down for mentorhelp

	msg = sanitize(copytext(msg,1,MAX_MESSAGE_LEN))
	if(!msg)	return
	if(!mob)	return						//this doesn't happen

	new /datum/admin_help(msg, src, FALSE, _state="mentor")
	return

/proc/get_mentor_counts()
	. = list("total" = 0, "afk" = 0, "present" = 0)
	for(var/X in GLOB.mentors)
		var/client/C = X
		.["total"]++
		if(C.is_afk())
			.["afk"]++
		else
			.["present"]++

/proc/key_name_mentor(var/whom, var/include_link = null, var/include_name = 0, var/include_follow = 0, var/char_name_only = 0)
	var/mob/M
	var/client/C
	var/key
	var/ckey

	if(!whom)	return "*null*"
	if(istype(whom, /client))
		C = whom
		M = C.mob
		key = C.key
		ckey = C.ckey
	else if(ismob(whom))
		M = whom
		C = M.client
		key = M.key
		ckey = M.ckey
	else if(istext(whom))
		key = whom
		ckey = ckey(whom)
		C = GLOB.directory[ckey]
		if(C)
			M = C.mob
	else
		return "*invalid*"

	. = ""

	if(!ckey)
		include_link = 0

	if(key)
		if(include_link)
			. += "<a href='?_src_=mentor;mentor_msg=[REF(C.current_ticket)];[MentorHrefToken(TRUE)]'>"

		if(C && C.holder && C.holder.fakekey)
			. += "Administrator"
		else if (char_name_only && CONFIG_GET(flag/mentors_mobname_only))
			if(istype(C.mob,/mob/dead/new_player) || istype(C.mob, /mob/dead/observer)) //If they're in the lobby or observing, display their ckey
				. += key
			else if(C?.mob) //If they're playing/in the round, only show the mob name
				. += C.mob.name
			else //If for some reason neither of those are applicable and they're mentorhelping, show ckey
				. += key
		else
			. += key
		if(!C)
			. += "\[DC\]"

		if(include_link)
			. += "</a>"
	else
		. += "*no key*"

	if(include_follow)
		. += " (<a href='?_src_=mentor;mentor_follow=[REF(M)];[MentorHrefToken(TRUE)]'>F</a>)"

	return .
