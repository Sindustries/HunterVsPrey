class SIN {
	tag = "SIN";
	class core {
		file = "core\sin";
		class checkPos {};
		class checkDist {};
		class findPos {};
	};
}

class HVP_Core {
    tag = "HVP";
	class core {
		file = "core\core";
		class getSetting {};
		class getSettings {};
		class keyHandler {};
		class updateProgressBar {};
		class HFSCompCreator {};
		class HFSCompSpawner {};
		class HFSDrop {};
		class HFSHouseFinder {};
		class HFSMove {};
		class HFSMoveComp {};
		class HFSRotate {};
	};

	class loot {
		file = "core\loot";
		class airdropLoot {};
		class heliCrashLoot {};
		class lootInit {};
		class lootMain {};
		class spawnLoot {};
		class hideLoot {};
	}

    class spawn {
        file = "core\spawn";
        class findSpawns {};
        class haloSpawn {};
		class heliSpawn {};
        class podSpawn {};
    };

	class game {
		file = "core\game";
		class antiCamp {};
		class carPenalty {};
		class deathLoop {};
		class endConditions {};
		class eventHandlers {};
		class fireworks {};
		class intro {};
		class loadout {};
		class manual {};
		class phaseClock {};
		class phaseInit {};
		class phaseManager {};
		class phaseWarning {};
		class playermarkers {};
		class sideTasks {};
		class spawnBoats {};
		class spawnRadObjects {};
		class spawnVeh {};
		class tips {};
		class tpw_air {};
		class tpw_animals {};
		class tpw_core {};
	};

	class events {
		file = "core\event";
		class eventManager {};
		class showEventIcon {};
		class hideEventIcon {};
		class airdrop {};
		class artillery {};
		class quake {};
		class nuke {};
		class uav {};
		class chemAttack {};
		class heliCrash {};
		class dropPod {};
		class paranormal {};
	};

	class paranormal {
		file = "core\event\paranormal";
		class paraChat {};
		class paraDarkness {};
		class paraDecoy {};
		class paraGhost {};
		class paraSkydive {};
		class paraTeleport {};
	}

	class abilitycore {
		file = "core\ability";
		class abilitymanager {};
		class addAbility {};
		class progressBar {};
		class useAbility {};
		class useAbilityKey {};
	};

	class abilityClient {
		file = "core\ability\client";
		class artilleryAbil {};
		class banishAbil {};
		class biohazardAbil {};
		class blackoutAbil {};
		class cloakAbil {};
		class disarmAbil {};
		class escapeAbil {};
		class fatigueAuraAbil {};
		class fatigueFreeAbil {};
		class healingAuraAbil {};
		class invincibilityAbil {};
		class nightVisionThiefAbil {};
		class revealAbil {};
		class supplyDropAbil {};
		class temporaryNightVisionAbil {};
	};

	class abilityFX {
		file = "core\ability\effects";
		class banishAbilEffect {};
		class biohazardAbilEffect {};
		class blackoutAbilEffect {};
		class cloakAbilEffect {};
		class disarmAbilEffect {};
		class fatigueAuraAbilEffect {};
		class healingAuraAbilEffect {};
		class healthRegenAbilEffect {};
		class nightVisionThiefAbilEffect {};
		class revealAbilEffect {};
	};

	class FX {
		file = "core\fx";
		class fwrLumina {};
		class fwrRock {};
		class fwrSparks {};
		class gasMask {};
		class knockOutGun {};
		class mineDetector {};
		class nukeFXash {};
		class nukeFXdamage {};
		class nukeFXdust {};
		class nukeFXfalling {};
		class nukeFXfog {};
		class nukeFXignite {};
		class nukeFXweather {};
		class parasmoke {};
		class proximity {};
		class quakeFX {};
		class radLocation {};
		class radObject {};
		class redHp {};
		class redSpeech {};
		class toxicGas {};
		class weather {};
	}
};

class Zombies {
    tag = "Z";
	class core {
		file = "core\zombie";
		class init {};
		class setSpawn {};
		class spawnZombies {};
		class zDeleter {};
		class zMask {};
		class zMonitor {};
		class zCamo {};
	};
};

class SMS {
	tag = "SMS";
	class core {
		file = "core\SMS";
		class init {};
		class bloodLevel {};
		class handleDamage {};
		class handleHeal {};
		class healAction {};
		class setBleeding {};
		class setBleedout {};
		class setUnconscious {};
		class updateHP {};
	}
}



