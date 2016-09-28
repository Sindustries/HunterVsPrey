#define true 1
#define false 0
/*
    MASTER CONFIG
*/
class HVP {
	
/* ADAPTIVE TIME SETTINGS */

	daytimeMultiplier = 80;				//Time multiplier during the day	>> BOTH THESE SETTINGS HAVE A MAX OF 120 <<
	nighttimeMultiplier = 120;			//Time multiplier during the night
	
/* SPAWN SETTINGS */

	groundChanceUnconscious = 25;		//Chance of being unconscious during "Ground" spawn
	
/* LOADOUT SETTINGS */

	loadoutMapChance = 25;				//Chance of spawning with a map (HVP Mode)
	loadoutAmmoChance = 25;				//Chance of spawning with ammo for main weapon (HVP Mode)
	loadoutMedChance = 25;				//Chance of spawning with a First Aid Kit (HVP Mode)
	
/* ABILITY SETTINGS */

	/* Timed Abilities >> ALL IN SECS << */
	
	invincibilityMinTime = 10;
	invincibilityMaxTime = 30;
	cloakMinTime = 30;
	cloakMaxTime = 60;
	fatigueFreeMinTime = 30;		//Effects both Fatigue Free and Healing Aura
	fatigueFreeMaxTime = 60;		//Same as above
	nightVisionMinTime = 20;		//Effects both Night Vision Thief and Temporary Night Vision
	nightVisionMaxTime = 40;		//Same as above
	
	randomHeadgear[] = { "H_MilCap_ocamo","H_MilCap_mcamo","H_MilCap_oucamo","H_MilCap_rucamo","H_MilCap_gry","H_MilCap_dgtl","H_MilCap_blue","H_Bandanna_khk","H_Bandanna_khk_hs","H_Bandanna_cbr","H_Bandanna_sgg","H_Bandanna_gry","H_Beret_blk","H_Beret_red","H_Beret_grn","H_Beret_grn_SF","H_Beret_brn_SF","H_Beret_ocamo","H_Watchcap_blk","H_Watchcap_cbr","H_Watchcap_khk","H_Watchcap_camo","H_Watchcap_sgg" };
	randomHeadgearAPEX[] = { "G_Balaclava_TI_blk_F","G_Balaclava_TI_tna_F","G_Balaclava_TI_G_blk_F","G_Balaclava_TI_G_tna_F" };
	randomUniforms[] = { "U_IG_Guerilla1_1","U_IG_Guerilla2_1","U_IG_Guerilla2_2","U_IG_Guerilla2_3","U_IG_Guerilla3_1","U_IG_Guerilla3_2","U_I_G_Story_Protagonist_F","U_I_G_resistanceLeader_F","U_IG_Guerrilla_6_1" };
	randomUniformsAPEX[] = { "U_I_C_Soldier_Bandit_1_F","U_I_C_Soldier_Bandit_2_F","U_I_C_Soldier_Bandit_3_F","U_I_C_Soldier_Bandit_4_F","U_I_C_Soldier_Bandit_5_F" };
	randomGhillies[] = { "U_B_GhillieSuit","U_O_GhillieSuit","U_I_GhillieSuit" };
	randomGhilliesMARKSMAN[] = { "U_B_FullGhillie_lsh","U_B_FullGhillie_sard","U_B_FullGhillie_ard","U_O_FullGhillie_lsh","U_O_FullGhillie_sard","U_O_FullGhillie_ard","U_I_FullGhillie_lsh","U_I_FullGhillie_sard","U_I_FullGhillie_ard","U_O_T_FullGhillie_tna_F","U_B_T_FullGhillie_tna_F" };
	randomMercUniformAPEX[] = { "U_B_CTRG_Soldier_F","U_B_CTRG_Soldier_3_F","U_O_V_Soldier_Viper_F" };
	
	/* Admin menu PID's */
	SIN_adminUIDs[] = { /*JAY*/"76561197983563875" };
	/* Music tracks to be played while game is loading */
	HVP_music[] = { "AmbientTrack01_F_EXP","AmbientTrack01a_F_EXP","AmbientTrack01b_F_EXP","Fallout","Wasteland","MAD","BackgroundTrack01_F_EPC","AmbientTrack01_F_EPB" };
	/* Gas Masks */
	HVP_gasMasks[] = { "H_PilotHelmetFighter_B","H_PilotHelmetFighter_O","H_PilotHelmetFighter_I","H_CrewHelmetHeli_B","H_CrewHelmetHeli_O","H_CrewHelmetHeli_I","H_Shemag_khk","H_Shemag_tan","H_Shemag_olive","H_Shemag_olive_hs","H_ShemagOpen_khk","H_ShemagOpen_tan","H_RacingHelmet_1_F","H_RacingHelmet_2_F","H_RacingHelmet_3_F","H_RacingHelmet_4_F","H_RacingHelmet_1_black_F","H_RacingHelmet_1_blue_F","H_RacingHelmet_1_green_F","H_RacingHelmet_1_red_F","H_RacingHelmet_1_white_F","H_RacingHelmet_1_yellow_F","H_RacingHelmet_1_orange_F","G_Bandanna_aviator","G_Bandanna_beast","G_Bandanna_blk","G_Bandanna_khk","G_Bandanna_oli","G_Bandanna_shades","G_Bandanna_sport","G_Bandanna_tan","H_HelmetO_ViperSP_hex_F","H_HelmetO_ViperSP_ghex_F","G_Balaclava_TI_blk_F","G_Balaclava_TI_G_blk_F","G_Balaclava_TI_G_tna_F","G_Balaclava_TI_tna_F","Mask_M50","Mask_M40","Mask_M40_OD" };
	/* Non-lethal mines */
	HVP_mines[] = { "APERSTripMine_Wire_Ammo","APERSBoundingMine_Range_Ammo","APERSMine_Range_Ammo","ATMine_Range_Ammo","ClaymoreDirectionalMine_Remote_Ammo","SLAMDirectionalMine_Wire_Ammo" };
	/* Red Team "knockout" guns */
	HVP_redGuns[] = { "hgun_P07_F" };
	HVP_redAmmo[] = { "B_9x21_Ball_Tracer_Red" };
	
/* LOOT SETTINGS */

	lootSpawn_mult = 1.5;				//Multiplier of area (radius) from position to spawn loot
	lootSpawn_zAdjustHouse = 0.15;		//Height adjustment to prevent loot spawning in the floor
	lootSpawn_zAdjustWild = 0.04;		//Same as above, but for wild loot
	lootSpawn_gunsWithMag = true;		//Whether or not guns should spawn with appropriate mags on same area
	lootSpawn_chanceWild = 20;			//% chance of loot spawning in the wild
	
	/* Loot chance table */

	HVP_lootChance[] = {	//Hunter vs Prey Mode
		5,		//weapons
		20,		//magazines
		8,		//items
		4,		//medical
		10,		//clothing
		5,		//backpacks
		0,		//ghillies & other special clothing
		0,		//night vision
		0		//mines
	};
	
	CRU_lootChance[] = {	//Crucible & Predator mode
		20,		//weapons
		45,		//magazines
		12,		//items
		4.5,	//medical
		10,		//clothing
		8,		//backpacks
		0.65,	//ghillies & other special clothing
		1.9,	//night vision
		1.35	//mines
	};	
	
/* VEHICLE SPAWN SETTINGS */

	vehicleCarMinDist = 250;			//Min distance (METERS) between car spawns
	vehicleBoatMinDist = 100;			//Min distance (METERS) between boat spawns	
	
/* PHASE SETTINGS */

	adaptiveZoneMinSize = 750;			//Min Size of adaptive zone (RADIUS)
	adaptiveZoneMaxSize = 4000;			//Max Size of adaptive zone (RADIUS)	
	adaptiveZoneMinTime = 180;			//Min Time of adaptive zone (SEC)
	adaptiveZoneMaxTime = 900;			//Max Time of adaptive zone (SEC)
	
	singlePhaseReduceSize = 0.5;		//Distance (METERS) single phase type will reduce by every second
	singlePhaseShiftSize = 5;			//Distance (METERS) single phase type will move by every second
	
	phaseBreakTime = 0.5;				//Multiplier applied to active phase time to get inactive phase time	
	phaseTimeDecay = 0.75;				//Multiplier applied to overall phase time after each phase
	phaseSizeDecay = 0.75;				//Multiplier applied to phase size between each phase
	
};
	
class SMS {
	SMS_maxBlood = 1000;				//Max blood level
	SMS_bloodRegen = 5;					//How much blood to be replenished
	SMS_bloodRegenRate = 10;			//How often to replenish (in sec)
	SMS_bleedRate = 8;					//How often bleed ticks happen (in sec)
	SMS_passOutNum = 0.40;				//At what % blood to pass out
	SMS_passOutChance = 10;				//Chance of passing out each bleed tick
	SMS_bleedOutNum = 0.10;				//At what % blood to enter bleedout
	SMS_bleedoutChance = 10;			//Chance that the player will bleedout each bleed tick while lower than bleedout threshold
	SMS_bloodLossCOEF = 1.5;			//Overall damage to blood level after adding up damage to all body parts
	SMS_fallDamage = 0.25;				//Amount of fall damage received
};
	
class Z {
	HVP_maxZombies = 100;				//Total number of alive zombies
	HVP_zhordeSize = 8; 				//Max num to spawn on each spawner
	HVP_zSpawnChance = 75;				//Chance of a spawner spawning zombies (%)
	HVP_zDeleteDist = 300;				//Distance (METERS) from players to remove zombies
};

#include "cfgLoadout.hpp"
#include "cfgAbilities.hpp"
