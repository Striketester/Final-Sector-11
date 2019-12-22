///We handle the unity part of plumbing. We track who is connected to who.
/datum/ductnet
	var/list/suppliers = list()
	var/list/demanders = list()
	var/list/obj/machinery/duct/ducts = list()

	var/capacity
///Add a duct to our network
/datum/ductnet/proc/add_duct(obj/machinery/duct/D)
	if(!D || D in ducts)
		return
	ducts += D
	D.duct = src
///Remove a duct from our network and commit suicide, because this is probably easier than to check who that duct was connected to and what part of us was lost
/datum/ductnet/proc/remove_duct(obj/machinery/duct/ducting)
	destroy_network(FALSE)
<<<<<<< HEAD
	for(var/obj/machinery/duct/D in ducting.neighbours)
		addtimer(CALLBACK(D, /obj/machinery/duct/proc/reconnect), 0) //all needs to happen after the original duct that was destroyed finishes destroying itself
		addtimer(CALLBACK(D, /obj/machinery/duct/proc/generate_connects), 0)
=======
	for(var/A in ducting.neighbours)
		var/obj/machinery/duct/D = A
		D.attempt_connect() //we destroyed the network, so now we tell the disconnected ducts neighbours they can start making a new ductnet
>>>>>>> 6019aa33c0e954c94587c43287536eaf970cdb36
	qdel(src)
///add a plumbing object to either demanders or suppliers
/datum/ductnet/proc/add_plumber(datum/component/plumbing/P, dir)
	if(!P.can_add(src, dir))
<<<<<<< HEAD
		return FALSE
=======
		return
>>>>>>> 6019aa33c0e954c94587c43287536eaf970cdb36
	P.ducts[num2text(dir)] = src
	if(dir & P.supply_connects)
		suppliers += P
	else if(dir & P.demand_connects)
		demanders += P
<<<<<<< HEAD
	return TRUE
=======
>>>>>>> 6019aa33c0e954c94587c43287536eaf970cdb36
///remove a plumber. we dont delete ourselves because ductnets dont persist through plumbing objects
/datum/ductnet/proc/remove_plumber(datum/component/plumbing/P)
	suppliers.Remove(P) //we're probably only in one of these, but Remove() is inherently sane so this is fine
	demanders.Remove(P)

	for(var/dir in P.ducts)
		if(P.ducts[dir] == src)
			P.ducts -= dir
<<<<<<< HEAD
	if(!ducts.len) //there were no ducts, so it was a direct connection. we destroy ourselves since a ductnet with only one plumber and no ducts is worthless
		destroy_network()
=======
>>>>>>> 6019aa33c0e954c94587c43287536eaf970cdb36
///we combine ductnets. this occurs when someone connects to seperate sets of fluid ducts
/datum/ductnet/proc/assimilate(datum/ductnet/D)
	ducts.Add(D.ducts)
	suppliers.Add(D.suppliers)
	demanders.Add(D.demanders)
	for(var/A in D.suppliers + D.demanders)
		var/datum/component/plumbing/P = A
		for(var/s in P.ducts)
			if(P.ducts[s] != D)
				continue
			P.ducts[s] = src  //all your ducts are belong to us
	for(var/A in D.ducts)
		var/obj/machinery/duct/M = A
		M.duct = src //forget your old master
<<<<<<< HEAD
	
	destroy_network()
=======
	qdel(D)
>>>>>>> 6019aa33c0e954c94587c43287536eaf970cdb36
///destroy the network and tell all our ducts and plumbers we are gone
/datum/ductnet/proc/destroy_network(delete=TRUE)
	for(var/A in suppliers + demanders)
		remove_plumber(A)
	for(var/A in ducts)
		var/obj/machinery/duct/D = A
		D.duct = null
	if(delete) //I don't want code to run with qdeleted objects because that can never be good, so keep this in-case the ductnet has some business left to attend to before commiting suicide
<<<<<<< HEAD
		qdel(src)
=======
		qdel(src)
>>>>>>> 6019aa33c0e954c94587c43287536eaf970cdb36
