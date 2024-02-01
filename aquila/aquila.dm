#include "code\__DEFINES\DNA.dm"
#include "code\__DEFINES\inventory.dm"
#include "code\__DEFINES\keybinding.dm"
#include "code\__DEFINES\melee.dm"
#include "code\__DEFINES\nanites.dm"
#include "code\__DEFINES\role_preferences.dm"
#include "code\__DEFINES\say.dm"
#include "code\__DEFINES\sound.dm"
#include "code\__DEFINES\traits.dm"
#include "code\__DEFINES\wires.dm"
#include "code\__HELPERS\names.dm"
#include "code\controllers\configuration\entries\game_options.dm"
#include "code\controllers\subsystem\jukeboxes.dm"
#include "code\controllers\subsystem\vote.dm"
#include "code\datum\wires\wires_jukebox.dm"
#include "code\datums\components\nanites.dm"
#include "code\datums\diseases\transformation.dm"
#include "code\datums\dna.dm"
#include "code\datums\emotes.dm"
#include "code\datums\keybinding\emote.dm"
#include "code\datums\keybinding\keybindings.dm"
#include "code\datums\keybinding\mob.dm"
#include "code\datums\looping_sounds\machinery_sounds.dm"
#include "code\datums\martial\nanojutsu.dm"
#include "code\datums\mutations\_combined.dm"
#include "code\datums\mutations\actions.dm"
#include "code\datums\mutations\body.dm"
#include "code\datums\saymode.dm"
#include "code\game\atoms_movable.dm"
#include "code\game\dynamic\dynamic_rulesets_roundstart.dm"
#include "code\game\effects\decals\turfdecal\markings.dm"
#include "code\game\gamemodes\monkey\monkey.dm"
#include "code\game\machinery\computer\_computer.dm"
#include "code\game\machinery\doors\airlock_types.dm"
#include "code\game\machinery\doors\firedoor.dm"
#include "code\game\machinery\fabricators\modular_fabricator.dm"
#include "code\game\machinery\jukebox.dm"
#include "code\game\machinery\newscaster.dm"
#include "code\game\machinery\spaceheater.dm"
#include "code\game\machinery\status_display.dm"
#include "code\game\objects\RCD.dm"
#include "code\game\objects\effects\contraband.dm"
#include "code\game\objects\effects\decals\cleanable.dm"
#include "code\game\objects\effects\decals\cleanable\humans.dm"
#include "code\game\objects\effects\spawners\lootdrop.dm"
#include "code\game\objects\effects\spawners\xenospawner.dm"
#include "code\game\objects\items\AI_modules.dm"
#include "code\game\objects\items\circuitboards\circuitboard.dm"
#include "code\game\objects\items\circuitboards\machine_circuitboards.dm"
#include "code\game\objects\items\clown_items.dm"
#include "code\game\objects\items\devices\geiger_counter.dm"
#include "code\game\objects\items\devices\glue.dm"
#include "code\game\objects\items\devices\multitool.dm"
#include "code\game\objects\items\devices\scanners.dm"
#include "code\game\objects\items\dna_injector.dm"
#include "code\game\objects\items\flamethrower.dm"
#include "code\game\objects\items\implants\implant_explosive.dm"
#include "code\game\objects\items\implants\implant_security.dm"
#include "code\game\objects\items\inducer.dm"
#include "code\game\objects\items\manuals.dm"
#include "code\game\objects\items\tools\crowbar.dm"
#include "code\game\objects\items\tools\powertools.dm"
#include "code\game\objects\items\tools\screwdriver.dm"
#include "code\game\objects\items\tools\weldingtool.dm"
#include "code\game\objects\items\tools\wirecutters.dm"
#include "code\game\objects\items\tools\wrench.dm"
#include "code\game\objects\structures\barsigns.dm"
#include "code\game\objects\structures\crate_lockers\closets\secure\scientist.dm"
#include "code\game\objects\structures\door_assembly_types.dm"
#include "code\game\objects\structures\signs\signs_departments.dm"
#include "code\game\objects\structures\signs\signs_maps.dm"
#include "code\game\objects\structures\signs\signs_warning.dm"
#include "code\modules\admin\verbs\modify_metacoins.dm"
#include "code\modules\antagonists\monkey\monkey.dm"
#include "code\modules\antagonists\role_preference\role_monkey.dm"
#include "code\modules\cargo\packs.dm"
#include "code\modules\client\preferences.dm"
#include "code\modules\client\preferences_toggles.dm"
#include "code\modules\clothing\clothing.dm"
#include "code\modules\clothing\head\mind_monkey_helmet.dm"
#include "code\modules\clothing\head\misc.dm"
#include "code\modules\clothing\shoes\miscellaneous.dm"
#include "code\modules\clothing\spacesuits\hardsuit.dm"
#include "code\modules\clothing\suits\jobs.dm"
#include "code\modules\clothing\under\costume.dm"
#include "code\modules\clothing\under\jobs\rnd.dm"
#include "code\modules\clothing\under\syndicate.dm"
#include "code\modules\events\monkey_uprising.dm"
#include "code\modules\food_and_drinks\drinks\drinks.dm"
#include "code\modules\food_and_drinks\food\snacks_pie.dm"
#include "code\modules\food_and_drinks\recipes\drinks_recipes.dm"
#include "code\modules\mining\equipment\mineral_scanner.dm"
#include "code\modules\mining\machine_bluespaceminer.dm"
#include "code\modules\mob\living\carbon\alien\alien.dm"
#include "code\modules\mob\living\carbon\emote.dm"
#include "code\modules\mob\living\carbon\human\emote.dm"
#include "code\modules\mob\living\carbon\human\species.dm"
#include "code\modules\mob\living\carbon\human\species_types\IPC.dm"
#include "code\modules\mob\living\carbon\human\species_types\android.dm"
#include "code\modules\mob\living\carbon\human\species_types\apid.dm"
#include "code\modules\mob\living\carbon\human\species_types\debug.dm"
#include "code\modules\mob\living\carbon\human\species_types\dullahan.dm"
#include "code\modules\mob\living\carbon\human\species_types\ethereal.dm"
#include "code\modules\mob\living\carbon\human\species_types\felinid.dm"
#include "code\modules\mob\living\carbon\human\species_types\flypeople.dm"
#include "code\modules\mob\living\carbon\human\species_types\golems.dm"
#include "code\modules\mob\living\carbon\human\species_types\humans.dm"
#include "code\modules\mob\living\carbon\human\species_types\jellypeople.dm"
#include "code\modules\mob\living\carbon\human\species_types\lizardpeople.dm"
#include "code\modules\mob\living\carbon\human\species_types\monkey.dm"
#include "code\modules\mob\living\carbon\human\species_types\mothmen.dm"
#include "code\modules\mob\living\carbon\human\species_types\oozelings.dm"
#include "code\modules\mob\living\carbon\human\species_types\plasmamen.dm"
#include "code\modules\mob\living\carbon\human\species_types\podpeople.dm"
#include "code\modules\mob\living\carbon\human\species_types\shadowpeople.dm"
#include "code\modules\mob\living\carbon\human\species_types\skeletons.dm"
#include "code\modules\mob\living\carbon\human\species_types\snail.dm"
#include "code\modules\mob\living\carbon\human\species_types\vampire.dm"
#include "code\modules\mob\living\carbon\human\species_types\zombies.dm"
#include "code\modules\mob\living\carbon\monkey\monkey.dm"
#include "code\modules\mob\living\emote.dm"
#include "code\modules\mob\living\say.dm"
#include "code\modules\mob\living\silicon\silicon.dm"
#include "code\modules\mob\living\silicon\robot\robot_modules.dm"
#include "code\modules\mob\living\simple_animal\constructs.dm"
#include "code\modules\mob\living\simple_animal\friendly\cat.dm"
#include "code\modules\mob\living\simple_animal\friendly\cockroach.dm"
#include "code\modules\mob\living\simple_animal\friendly\dog.dm"
#include "code\modules\mob\living\simple_animal\friendly\drone\_drone.dm"
#include "code\modules\mob\living\simple_animal\friendly\gondola.dm"
#include "code\modules\mob\living\simple_animal\friendly\mouse.dm"
#include "code\modules\mob\living\simple_animal\friendly\snake.dm"
#include "code\modules\mob\living\simple_animal\hostile\alien.dm"
#include "code\modules\mob\living\simple_animal\hostile\carp.dm"
#include "code\modules\mob\living\simple_animal\hostile\gorilla\gorilla.dm"
#include "code\modules\mob\living\simple_animal\hostile\headcrab.dm"
#include "code\modules\mob\living\simple_animal\hostile\hivebot.dm"
#include "code\modules\mob\living\simple_animal\hostile\mining_mobs\hivelord.dm"
#include "code\modules\mob\living\simple_animal\hostile\retaliate\clown.dm"
#include "code\modules\mob\living\simple_animal\hostile\retaliate\dolphin.dm"
#include "code\modules\mob\living\simple_animal\hostile\skeleton.dm"
#include "code\modules\mob\living\simple_animal\parrot.dm"
#include "code\modules\mob\living\simple_animal\simple_animal.dm"
#include "code\modules\mob\living\simple_animal\slime\slime.dm"
#include "code\modules\power\generator.dm"
#include "code\modules\power\smes.dm"
#include "code\modules\projectiles\guns\energy\energy.dm"
#include "code\modules\projectiles\guns\energy\laser.dm"
#include "code\modules\projectiles\guns\energy\pulse.dm"
#include "code\modules\reagents\chemistry\reagents\alcohol_reagents.dm"
#include "code\modules\reagents\chemistry\reagents\other_reagents.dm"
#include "code\modules\research\designs\machine_designs.dm"
#include "code\modules\research\designs\medical_designs.dm"
#include "code\modules\research\designs\nanite_designs.dm"
#include "code\modules\research\designs\weapon_designs.dm"
#include "code\modules\research\machinery\_production.dm"
#include "code\modules\research\nanites\nanite_misc_items.dm"
#include "code\modules\research\nanites\nanite_misc_mobs.dm"
#include "code\modules\research\nanites\nanite_programs.dm"
#include "code\modules\research\nanites\nanite_programs\buffing.dm"
#include "code\modules\research\nanites\nanite_programs\protocols.dm"
#include "code\modules\research\nanites\nanite_programs\sensor.dm"
#include "code\modules\research\nanites\nanite_programs\suppression.dm"
#include "code\modules\research\nanites\nanite_programs\utility.dm"
#include "code\modules\research\nanites\nanite_programs\weapon.dm"
#include "code\modules\research\nanites\program_disks.dm"
#include "code\modules\research\stock_parts.dm"
#include "code\modules\research\techweb\all_nodes.dm"
#include "code\modules\shuttle\super_cruise\orbital_map_components\orbital_objects\beacon.dm"
#include "code\modules\uplink\uplink_items.dm"
#include "code\modules\vending\boozeomat.dm"
