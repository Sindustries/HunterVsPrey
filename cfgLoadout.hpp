/*
    LOADOUT CONFIG
*/
class LOADOUT {	
	/* HUNTER VS PREY MODE */
	class HVP {	
		/* BLUE TEAM */
		class BLUE {
			class TeamLeader {
				loadoutType = "B_Soldier_TL_F";
				loadoutMainWeapon = "arifle_MX_F";
				loadoutMainWeaponAccessories[] = { "acc_flashlight" };
				loadoutMainWeaponAmmo[] = { "30Rnd_65x39_caseless_mag_Tracer" };
				loadoutSideWeapon = "hgun_ACPC2_F";
				loadoutSideWeaponAccessories[] = {};
				loadoutSideWeaponAmmo[] = { "9Rnd_45ACP_Mag" };
				loadoutUniform = "";
				loadoutVest = "V_Rangemaster_belt";
				loadoutHelmet = "";
				loadoutBackpack = "";
				loadoutBinoculars = "";
				loadoutNightVision = "";
				loadoutMask = "";
				loadoutLinkedItems[] = { "itemMap", "itemWatch", "itemRadio", "itemCompass" };
				loadoutInventoryItems[] = { "FirstAidKit" };
				loadoutInventoryMagazines[] = {};
			};
			class Grenadier {
				loadoutType = "B_Soldier_GL_F";
				loadoutMainWeapon = "arifle_MX_GL_F";
				loadoutMainWeaponAccessories[] = { "acc_flashlight" };
				loadoutMainWeaponAmmo[] = { "30Rnd_65x39_caseless_mag_Tracer" };
				loadoutSideWeapon = "hgun_ACPC2_F";
				loadoutSideWeaponAccessories[] = {};
				loadoutSideWeaponAmmo[] = { "9Rnd_45ACP_Mag" };
				loadoutUniform = "";
				loadoutVest = "V_BandollierB_cbr";
				loadoutHelmet = "";
				loadoutBackpack = "";
				loadoutBinoculars = "";
				loadoutNightVision = "";
				loadoutMask = "";
				loadoutLinkedItems[] = { "itemMap", "itemWatch", "itemRadio", "itemCompass" };
				loadoutInventoryItems[] = { "FirstAidKit" };
				loadoutInventoryMagazines[] = { "1Rnd_SmokeGreen_Grenade_shell","1Rnd_SmokeBlue_Grenade_shell","UGL_FlareGreen_F" }; 
			};
			class Medic {
				loadoutType = "B_medic_F";
				loadoutMainWeapon = "arifle_MXC_Black_F";
				loadoutMainWeaponAccessories[] = { "acc_flashlight" };
				loadoutMainWeaponAmmo[] = { "30Rnd_65x39_caseless_mag_Tracer" };
				loadoutSideWeapon = "hgun_ACPC2_F";
				loadoutSideWeaponAccessories[] = {};
				loadoutSideWeaponAmmo[] = { "9Rnd_45ACP_Mag" };
				loadoutUniform = "";
				loadoutVest = "V_BandollierB_cbr";
				loadoutHelmet = "";
				loadoutBackpack = "B_Kitbag_cbr";
				loadoutBinoculars = "";
				loadoutNightVision = "";
				loadoutMask = "";
				loadoutLinkedItems[] = { "itemMap", "itemWatch", "itemRadio", "itemCompass" };
				loadoutInventoryItems[] = { "FirstAidKit","MediKit" };
				loadoutInventoryMagazines[] = {};
			};
			class Tech {
				loadoutType = "B_soldier_exp_F";
				loadoutMainWeapon = "arifle_MX_F";
				loadoutMainWeaponAccessories[] = { "acc_flashlight" };
				loadoutMainWeaponAmmo[] = { "30Rnd_65x39_caseless_mag_Tracer" };
				loadoutSideWeapon = "hgun_ACPC2_F";
				loadoutSideWeaponAccessories[] = {};
				loadoutSideWeaponAmmo[] = { "9Rnd_45ACP_Mag" };
				loadoutUniform = "";
				loadoutVest = "V_BandollierB_cbr";
				loadoutHelmet = "";
				loadoutBackpack = "B_Kitbag_cbr";
				loadoutBinoculars = "";
				loadoutNightVision = "";
				loadoutMask = "";
				loadoutLinkedItems[] = { "itemMap", "itemWatch", "itemRadio", "itemCompass" };
				loadoutInventoryItems[] = { "FirstAidKit","ToolKit","MineDetector" };
				loadoutInventoryMagazines[] = {};
			};
		};
		/* RED TEAM */
		class RED {
			class TeamLeader {
				loadoutType = "O_Soldier_TL_F";
				loadoutMainWeapon = "";
				loadoutMainWeaponAccessories[] = {};
				loadoutMainWeaponAmmo[] = {};
				loadoutSideWeapon = "hgun_P07_F";
				loadoutSideWeaponAccessories[] = { "muzzle_snds_L" };
				loadoutSideWeaponAmmo[] = { "16Rnd_9x21_red_Mag" };
				loadoutUniform = "";
				loadoutVest = "V_RebreatherIA";
				loadoutHelmet = "";
				loadoutBackpack = "";
				loadoutBinoculars = "";
				loadoutNightVision = "NVGoggles_OPFOR";
				loadoutMask = "";
				loadoutLinkedItems[] = { "itemMap", "itemWatch", "itemRadio", "itemCompass" };
				loadoutInventoryItems[] = { "FirstAidKit" };
				loadoutInventoryMagazines[] = { "SmokeShellRed","ACE_M84" };
			};
			class Stalker {
				loadoutType = "O_spotter_F";
				loadoutMainWeapon = "";
				loadoutMainWeaponAccessories[] = {};
				loadoutMainWeaponAmmo[] = {};
				loadoutSideWeapon = "hgun_P07_F";
				loadoutSideWeaponAccessories[] = { "muzzle_snds_L" };
				loadoutSideWeaponAmmo[] = { "16Rnd_9x21_red_Mag" };
				loadoutUniform = "";
				loadoutVest = "V_RebreatherIA";
				loadoutHelmet = "";
				loadoutBackpack = "";
				loadoutBinoculars = "Laserdesignator";
				loadoutNightVision = "NVGoggles_blk_F";
				loadoutMask = "";
				loadoutLinkedItems[] = { "itemMap", "itemWatch", "itemRadio", "itemCompass" };
				loadoutInventoryItems[] = { "FirstAidKit" };
				loadoutInventoryMagazines[] = { "SmokeShellRed","ACE_M84" };
			};
			class Boomer {
				loadoutType = "O_soldier_exp_F";
				loadoutMainWeapon = "";
				loadoutMainWeaponAccessories[] = {};
				loadoutMainWeaponAmmo[] = {};
				loadoutSideWeapon = "hgun_P07_F";
				loadoutSideWeaponAccessories[] = { "muzzle_snds_L" };
				loadoutSideWeaponAmmo[] = { "16Rnd_9x21_red_Mag" };
				loadoutUniform = "";
				loadoutVest = "V_RebreatherIA";
				loadoutHelmet = "";
				loadoutBackpack = "B_Kitbag_cbr";
				loadoutBinoculars = "";
				loadoutNightVision = "NVGoggles_OPFOR";
				loadoutMask = "";
				loadoutLinkedItems[] = { "itemMap", "itemWatch", "itemRadio", "itemCompass" };
				loadoutInventoryItems[] = { "FirstAidKit","ToolKit","MineDetector" };
				loadoutInventoryMagazines[] = { "SmokeShellRed","ACE_M84","APERSTripMine_Wire_Mag","DemoCharge_Remote_Mag","APERSBoundingMine_Range_Mag" };
			};
			class Wraith {
				loadoutType = "O_soldier_UAV_F";
				loadoutMainWeapon = "";
				loadoutMainWeaponAccessories[] = {};
				loadoutMainWeaponAmmo[] = {};
				loadoutSideWeapon = "hgun_P07_F";
				loadoutSideWeaponAccessories[] = { "muzzle_snds_L" };
				loadoutSideWeaponAmmo[] = { "16Rnd_9x21_red_Mag" };
				loadoutUniform = "";
				loadoutVest = "V_RebreatherIA";
				loadoutHelmet = "";
				loadoutBackpack = "O_UAV_01_backpack_F";
				loadoutBinoculars = "";
				loadoutNightVision = "NVGoggles_OPFOR";
				loadoutMask = "";
				loadoutLinkedItems[] = { "itemMap", "itemWatch", "itemRadio", "itemCompass", "O_UavTerminal" };
				loadoutInventoryItems[] = { "FirstAidKit" };
				loadoutInventoryMagazines[] = { "SmokeShellRed","ACE_M84" };
			};			
		};
		/* MERCENARY */
		class MERC {
			class merc {
				loadoutType = "I_medic_F";
				loadoutMainWeapon = "arifle_MX_GL_Black_F";
				loadoutMainWeaponAccessories[] = { "acc_flashlight" };
				loadoutMainWeaponAmmo[] = { "30Rnd_65x39_caseless_mag_Tracer" };
				loadoutSideWeapon = "hgun_ACPC2_F";
				loadoutSideWeaponAccessories[] = { "" };
				loadoutSideWeaponAmmo[] = { "9Rnd_45ACP_Mag" };
				loadoutUniform = "";
				loadoutVest = "V_BandollierB_cbr";
				loadoutHelmet = "";
				loadoutBackpack = "B_Bergen_blk";
				loadoutBinoculars = "Rangefinder";
				loadoutNightVision = "";
				loadoutMask = "";
				loadoutLinkedItems[] = { "itemMap", "itemWatch", "itemRadio", "itemCompass", "itemGPS" };
				loadoutInventoryItems[] = { "FirstAidKit","ToolKit","MineDetector" };
				loadoutInventoryMagazines[] = { "1Rnd_SmokeRed_Grenade_shell","1Rnd_SmokeBlue_Grenade_shell","UGL_FlareGreen_F","APERSTripMine_Wire_Mag","DemoCharge_Remote_Mag","APERSBoundingMine_Range_Mag" };
			};
		};
	};
/* CRUCIBLE MODE */
	class CRU {
		loadoutType = "";
		loadoutMainWeapon = "";
		loadoutMainWeaponAccessories[] = {};
		loadoutMainWeaponAmmo[] = {};
		loadoutSideWeapon = "bv_flashlight";
		loadoutSideWeaponAccessories[] = {};
		loadoutSideWeaponAmmo[] = {};
		loadoutUniform = "";
		loadoutVest = "";
		loadoutHelmet = "";
		loadoutBackpack = "";
		loadoutBinoculars = "";
		loadoutNightVision = "";
		loadoutMask = "";
		loadoutLinkedItems[] = { "itemMap", "itemWatch", "itemRadio", "itemCompass" };
		loadoutInventoryItems[] = { "acc_flashlight" };
		loadoutInventoryMagazines[] = {};

	};
/* PREDATOR MODE */
	class PRED {
		class Prey {
			loadoutType = "";
			loadoutMainWeapon = "";
			loadoutMainWeaponAccessories[] = {};
			loadoutMainWeaponAmmo[] = {};
			loadoutSideWeapon = "bv_flashlight";
			loadoutSideWeaponAccessories[] = {};
			loadoutSideWeaponAmmo[] = {};
			loadoutUniform = "";
			loadoutVest = "";
			loadoutHelmet = "";
			loadoutBackpack = "";
			loadoutBinoculars = "";
			loadoutNightVision = "";
			loadoutMask = "";
			loadoutLinkedItems[] = { "itemMap", "itemWatch", "itemRadio", "itemCompass" };
			loadoutInventoryItems[] = { "acc_flashlight" };
			loadoutInventoryMagazines[] = {};
		};
		class Predator {
			loadoutType = "I_medic_F";
			loadoutMainWeapon = "Random";
			loadoutMainWeaponAccessories[] = {};
			loadoutMainWeaponAmmo[] = {};
			loadoutSideWeapon = "Random";
			loadoutSideWeaponAccessories[] = {};
			loadoutSideWeaponAmmo[] = {};
			loadoutUniform = "";
			loadoutVest = "V_PlateCarrierSpec_blk";
			loadoutHelmet = "H_HelmetO_ViperSP_ghex_F";
			loadoutBackpack = "B_Kitbag_cbr";
			loadoutBinoculars = "Laserdesignator";
			loadoutNightVision = "";
			loadoutMask = "Mask_M50";
			loadoutLinkedItems[] = { "itemMap", "itemWatch", "itemRadio", "itemCompass", "itemGPS" };
			loadoutInventoryItems[] = { "FirstAidKit","MineDetector" };
			loadoutInventoryMagazines[] = { "SmokeShellRed", "APERSBoundingMine_Range_Mag","ACE_M84" };
		};		
	};	
};
	