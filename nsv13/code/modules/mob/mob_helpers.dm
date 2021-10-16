
/proc/shake_with_inertia(mob/M, duration=0, strength=1, dampenerData=null)
	set waitfor = FALSE
	if(M.ckey) // These inertial dampener checks are probably expensive, we're only going to run calculations on people who are able to observe these camera shakes 
		var/nearestDistance = INFINITY
		var/obj/machinery/inertial_dampener/nearestMachine = null

		if(dampenerData && islist(dampenerData))
			// if we are already provided a nearest machine, we don't have to look for it 
			var/list/D = dampenerData
			nearestDistance = D["distance"]
			nearestMachine = D["machine"] 
		else 
			for(var/obj/machinery/inertial_dampener/machine in GLOB.inertia_dampeners)
				CHECK_TICK	//Usually shouldn't happen but if someone makes 20000 dampeners for some reason might be useful.
				var/dist = get_dist(M, machine)
				if(dist < nearestDistance && machine.on)
					nearestDistance = dist 
					nearestMachine = machine

		if(nearestMachine) 
			strength = nearestMachine.reduceStrength(nearestDistance, strength) 

	shake_camera(M, duration, strength)
