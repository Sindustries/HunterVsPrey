/*
	Sin Loot Spawner for HVP2
	Author: Sinbane
	Spawns loot in an area or around players
*/
//-----------------------------------
//-TEAM MODE

if (HVPGameType == 1) then {

Sinspawn_lootList = [
[ 
//WEAPONS
"hgun_Pistol_Signal_F"
], [ //MAGS
"UGL_FlareRed_F",
"SmokeShellPurple",
"SmokeShellRed",
"9Rnd_45ACP_Mag",
"6Rnd_GreenSignal_F",
"SmokeShellYellow",
"30Rnd_65x39_caseless_mag_Tracer",
"SmokeShellBlue",
"UGL_FlareYellow_F",
"6Rnd_RedSignal_F",
"UGL_FlareGreen_F",
"SmokeShellOrange",
"9Rnd_45ACP_Mag",
"SmokeShellGreen",
"ACE_HandFlare_White",
"ACE_HandFlare_Red",
"ACE_HandFlare_Green",
"ACE_HandFlare_Yellow",
"ACE_M84"
], [ //ITEMS
"ItemGPS",
"ItemMap",
"ACE_earplugs",
"optic_Hamr",
"optic_Aco",
"optic_Holosight"
], [ //MEDICAL
"FirstAidKit"
], [ //CLOTHING -- AUTO FILLED! see below

], [ //VESTS -- AUTO FILLED! see below

], [ //BACKPACKS -- AUTO FILLED! see below

], [ //SPECIAL CLOTHING
"U_B_GhillieSuit",
"U_O_GhillieSuit",
"U_I_GhillieSuit",
"U_B_FullGhillie_lsh",
"U_B_FullGhillie_sard",
"U_B_FullGhillie_ard",
"U_O_FullGhillie_lsh",
"U_O_FullGhillie_sard",
"U_O_FullGhillie_ard",
"U_I_FullGhillie_lsh",
"U_I_FullGhillie_sard",
"U_I_FullGhillie_ard",
"U_B_T_Sniper_F",
"U_B_T_FullGhillie_tna_F",
"U_O_T_Sniper_F",
"U_O_T_FullGhillie_tna_F",
"Mask_M50",
"Mask_M40",
"Mask_M40_OD"
], [ //NIGHT VISION

], [ //SUPPRESORS

]];
};

//-----------------------------------
//-CRUCIBLE AND PREDATOR MODE
if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {

Sinspawn_lootList = [
[ //WEAPONS	-- AUTO FILLED - See below

], [ //MAGAZINES -- AUTO FILLED - See below

], [ //ITEMS
"Rangefinder",
"Binocular",
"Laserdesignator",
"MineDetector",
"ItemGPS",
"ACE_earplugs",
"optic_Arco",
"optic_Hamr",
"optic_Aco",
"optic_ACO_grn",
"optic_Aco_smg",
"optic_ACO_grn_smg",
"optic_Holosight",
"optic_Holosight_smg",
"optic_SOS",
"optic_MRCO",
"optic_NVS",
"optic_DMS",
"optic_Yorris",
"optic_MRD",
"optic_LRPS",
"optic_AMS",
"optic_KHS_blk",
"acc_flashlight",
"acc_pointer_IR"
], [ //MEDICAL
"FirstAidKit"
], [ //CLOTHING	-- AUTO FILLED! see below

], [ //VESTS -- AUTO FILLED! see below

], [ //BACKPACKS -- AUTO FILLED! see below

], [ //SPECIAL CLOTHING
"U_B_GhillieSuit",
"U_O_GhillieSuit",
"U_I_GhillieSuit",
"U_B_FullGhillie_lsh",
"U_B_FullGhillie_sard",
"U_B_FullGhillie_ard",
"U_O_FullGhillie_lsh",
"U_O_FullGhillie_sard",
"U_O_FullGhillie_ard",
"U_I_FullGhillie_lsh",
"U_I_FullGhillie_sard",
"U_I_FullGhillie_ard",
"U_B_T_Sniper_F",
"U_B_T_FullGhillie_tna_F",
"U_O_T_Sniper_F",
"U_O_T_FullGhillie_tna_F",
"Mask_M50",
"Mask_M40",
"Mask_M40_OD"
], [ //NIGHT VISION
"NVGoggles_OPFOR",
"NVGoggles_blk_F",
"O_NVGoggles_urb_F"
], [ //SUPPRESSORS
"muzzle_snds_H",
"muzzle_snds_L",
"muzzle_snds_M",
"muzzle_snds_B",
"muzzle_snds_H_MG",
"muzzle_snds_acp",
"muzzle_snds_338_black",
"muzzle_snds_93mmg",
"muzzle_snds_58_blk_F",
"muzzle_snds_65_TI_blk_F"
]];
};

//-----------------------------------
//-AUTO-ADDED ITEMS
private ["_cfg","_exclusions","_i","_cfgName"];

if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
	//Weapons
	private "_weapon";
	_cfg = (configFile >> "CfgWeapons");
	for "_i" from 0 to ((count _cfg)-1) do {
		if (isClass (_cfg select _i)) then {
			_cfgName = configName (_cfg select _i);			
			if (_cfgName isKindOf ["Rifle", configFile >> "CfgWeapons"] || _cfgName isKindOf ["Pistol", configFile >> "CfgWeapons"] || _cfgName isKindOf ["Launcher", configFile >> "CfgWeapons"]) then {
				if ((getNumber ((_cfg select _i) >> "scope") == 2)) then {
					_weapon = (configName (inheritsFrom ((_cfg select _i))));
					if ((getNumber (_cfg >> _weapon >> "scope") == 2)) then {
						(Sinspawn_lootList select 0) pushBackUnique _weapon;
					};						
				};
			};
		};
	};
	//Magazines
	_exclusions = ["ATMine_Range_Mag","APERSMine_Range_Mag","SLAMDirectionalMine_Wire_Mag","SatchelCharge_Remote_Mag","IEDUrbanBig_Remote_Mag","IEDLandBig_Remote_Mag","IEDUrbanSmall_Remote_Mag","IEDLandSmall_Remote_Mag"];
	_cfg = (configFile >> "CfgMagazines");
	for "_i" from 0 to ((count _cfg)-1) do {
		if (isClass (_cfg select _i)) then {
			_cfgName = configName (_cfg select _i);			
			if (_cfgName isKindOf ["CA_Magazine", configFile >> "CfgMagazines"] && !(_cfgName isKindOf ["VehicleMagazine", configFile >> "CfgMagazines"])) then {
				if ((getNumber ((_cfg select _i) >> "scope") == 2) && !(_cfgName in _exclusions)) then {
					(Sinspawn_lootList select 1) pushBackUnique _cfgName;					
				};
			};
		};
	};
};

//Helmets
_cfg = (configFile >> "CfgWeapons");
_exclusions = ["H_HelmetO_ViperSP_hex_F","H_HelmetO_ViperSP_ghex_F"];
for "_i" from 0 to ((count _cfg)-1) do {
	if (isClass (_cfg select _i)) then {
		_cfgName = configName (_cfg select _i);	
		if (_cfgName isKindof ["HelmetBase", configFile >> "CfgWeapons"] && (getNumber ((_cfg select _i) >> "scope") == 2)) then {
			if (!(_cfgName in (Sinspawn_lootList select 6)) || !(_cfgName in _exclusions)) then { 
				(Sinspawn_lootList select 4) pushBackUnique _cfgName;
			};
		};
	};
};
_cfg = (configFile >> "CfgWeapons");
_exclusions = ["H_HelmetO_ViperSP_hex_F","H_HelmetO_ViperSP_ghex_F"];
for "_i" from 0 to ((count _cfg)-1) do {
	if (isClass (_cfg select _i)) then {
		_cfgName = configName (_cfg select _i);			
		if (_cfgName isKindOf ["H_HelmetB", configFile >> "CfgWeapons"] && (getNumber ((_cfg select _i) >> "scope") == 2)) then {
			if (!(_cfgName in (Sinspawn_lootList select 6)) || !(_cfgName in _exclusions)) then { 
				(Sinspawn_lootList select 4) pushBackUnique _cfgName;
			};
		};
	};
};

//Uniform
_cfg = (configFile >> "CfgWeapons");
for "_i" from 0 to ((count _cfg)-1) do {
	if (isClass (_cfg select _i)) then {
		_cfgName = configName (_cfg select _i);			
		if (_cfgName isKindOf ["Uniform_Base", configFile >> "CfgWeapons"] && (getNumber ((_cfg select _i) >> "scope") == 2)) then {
			if (!(_cfgName in (Sinspawn_lootList select 6))) then {
				(Sinspawn_lootList select 4) pushBackUnique _cfgName;
			};
		};
	};
};

//Glasses/Goggles/Masks
_cfg = (configFile >> "CfgGlasses");
for "_i" from 0 to ((count _cfg)-1) do {
	if (isClass (_cfg select _i)) then {
		_cfgName = configName (_cfg select _i);			
		if (_cfgName isKindOf ["None", configFile >> "CfgGlasses"] && (getNumber ((_cfg select _i) >> "scope") == 2)) then {
			if (!(_cfgName in (Sinspawn_lootList select 6))) then {
				(Sinspawn_lootList select 4) pushBackUnique _cfgName;
			};
		};
	};
};

//Vests
_cfg = (configFile >> "CfgWeapons");
for "_i" from 0 to ((count _cfg)-1) do {
	if (isClass (_cfg select _i)) then {
		_cfgName = configName (_cfg select _i);			
		if (_cfgName isKindOf ["Vest_NoCamo_Base", configFile >> "CfgWeapons"] || _cfgName isKindOf ["Vest_Camo_Base", configFile >> "CfgWeapons"]) then {
			if ((getNumber ((_cfg select _i) >> "scope") == 2)) then {
				(Sinspawn_lootList select 5) pushBackUnique _cfgName;
			};
		};
	};
};

//Backpacks
_cfg = (configFile >> "CfgVehicles");
for "_i" from 0 to ((count _cfg)-1) do {
	if (isClass (_cfg select _i)) then {
		_cfgName = configName (_cfg select _i);			
		if (_cfgName isKindOf "Bag_Base" && (getNumber ((_cfg select _i) >> "scope") == 2) && (getText ((_cfg select _i) >> "faction") isEqualTo "Default")) then {
			(Sinspawn_lootList select 6) pushBackUnique _cfgName;
		};
	};
};

//-----------------------------------
//-EXTRAS

if (HVPZombieMode isEqualTo 1) then {
	(Sinspawn_lootList select 3) pushBack "RyanZombiesAntiVirusTemporary_Item";
	(Sinspawn_lootList select 2) pushBack "RyanZombiesAntiVirusCure_Item";
};

//-----------------------------------
publicVariable "Sinspawn_lootList";
//-----------------------------------