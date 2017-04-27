/*
	Sin Loot Spawner for HVP2
	Author: Sinbane
	Spawns loot in an area or around players
*/
//-----------------------------------
//-TEAM MODE

if (HVPGameType == 1) then {

Sinspawn_lootList = [
[ //WEAPONS

], [ //PISTOLS
"hgun_Pistol_Signal_F"
], [ //MAGS
"UGL_FlareRed_F",
"SmokeShellRed",
"9Rnd_45ACP_Mag",
"6Rnd_GreenSignal_F",
"30Rnd_65x39_caseless_mag_Tracer",
"SmokeShellBlue",
"UGL_FlareYellow_F",
"6Rnd_RedSignal_F",
"UGL_FlareGreen_F",
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

], [ //THERMALS

]];
};

//-----------------------------------
//-CRUCIBLE AND PREDATOR MODE
if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {

Sinspawn_lootList = [
[ //WEAPONS	-- AUTO FILLED - See below

], [ //PISTOLS	-- AUTO FILLED - See below

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
"optic_AMS_snd",
"optic_KHS_blk",
"optic_KHS_hex",
"optic_KHS_old",
"optic_KHS_tan",
"optic_Arco_blk_F",
"optic_Arco_ghex_F",
"optic_DMS_ghex_F",
"optic_Hamr_khk_F",
"optic_ERCO_blk_F",
"optic_ERCO_khk_F",
"optic_ERCO_snd_F",
"optic_SOS_khk_F",
"optic_LRPS_tna_F",
"optic_LRPS_ghex_F",
"optic_Holosight_blk_F",
"optic_Holosight_khk_F",
"optic_Holosight_smg_blk_F",
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
], [ //THERMALS
"optic_Nightstalker",
"optic_tws",
"optic_tws_mg"
]];
};

//-----------------------------------
//-AUTO-ADDED ITEMS
private ["_cfg","_exclusions","_i","_cfgName"];

if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
	private "_wepMagazines";
	_wepMagazines = [];
	//Rifles, launchers
	private "_weapon";
	_exclusions = ["bv_FlashLight"];
	_cfg = (configFile >> "CfgWeapons");
	for "_i" from 0 to ((count _cfg)-1) do {
		if (isClass (_cfg select _i)) then {
			_cfgName = configName (_cfg select _i);
			if (_cfgName isKindOf ["Rifle", configFile >> "CfgWeapons"] || _cfgName isKindOf ["Launcher", configFile >> "CfgWeapons"]) then {
				if ((getNumber ((_cfg select _i) >> "scope") == 2) && !(_cfgName in _exclusions)) then {
					_weapon = [_cfgName] call BIS_fnc_baseWeapon;
					{
						_wepMagazines pushBackUnique _x;
						if (_x isKindOf ["CA_LauncherMagazine", configFile >> "CfgMagazines"]) then {
							HVP_mines pushBackUnique (getText (configFile >> "CfgMagazines" >> _x >> "ammo"));
						};
					} forEach (getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines"));
					(Sinspawn_lootList select 0) pushBackUnique _weapon;
				};
			};
		};
	};
	//Pistols
	private "_weapon";
	_exclusions = ["bv_FlashLight"];
	_cfg = (configFile >> "CfgWeapons");
	for "_i" from 0 to ((count _cfg)-1) do {
		if (isClass (_cfg select _i)) then {
			_cfgName = configName (_cfg select _i);
			if (_cfgName isKindOf ["Pistol", configFile >> "CfgWeapons"]) then {
				if ((getNumber ((_cfg select _i) >> "scope") == 2) && !(_cfgName in _exclusions)) then {
					_weapon = [_cfgName] call BIS_fnc_baseWeapon;
					{
						_wepMagazines pushBackUnique _x;
						if (_x isKindOf ["CA_LauncherMagazine", configFile >> "CfgMagazines"]) then {
							HVP_mines pushBackUnique (getText (configFile >> "CfgMagazines" >> _x >> "ammo"));
						};
					} forEach (getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines"));
					(Sinspawn_lootList select 1) pushBackUnique _weapon;
				};
			};
		};
	};
	//Magazines/grenades
	_cfg = (configFile >> "CfgMagazines");
	for "_i" from 0 to ((count _cfg)-1) do {
		if (isClass (_cfg select _i)) then {
			_cfgName = configName (_cfg select _i);
			if (_cfgName isKindOf ["CA_Magazine", configFile >> "CfgMagazines"] && !(_cfgName isKindOf ["ATMine_Range_Mag", configFile >> "CfgMagazines"]) && !(_cfgName isKindOf ["SatchelCharge_Remote_Mag", configFile >> "CfgMagazines"]) && !(_cfgName isKindOf ["VehicleMagazine", configFile >> "CfgMagazines"])) then {
				if ((getNumber ((_cfg select _i) >> "scope") == 2) && !(_cfgName in _wepMagazines)) then {
					(Sinspawn_lootList select 2) pushBackUnique _cfgName;
					if (_cfgName isKindOf ["CA_LauncherMagazine", configFile >> "CfgMagazines"]) then {
						HVP_mines pushBackUnique (getText ((_cfg select _i) >> "ammo"));
					};
				};
			};
		};
	};
	//Mines
	_cfg = (configFile >> "CfgMagazines");
	for "_i" from 0 to ((count _cfg)-1) do {
		if (isClass (_cfg select _i)) then {
			_cfgName = configName (_cfg select _i);
			if (_cfgName isKindOf ["ATMine_Range_Mag", configFile >> "CfgMagazines"] || _cfgName isKindOf ["SatchelCharge_Remote_Mag", configFile >> "CfgMagazines"] || _cfgName isKindOf ["CA_LauncherMagazine", configFile >> "CfgMagazines"]) then {
				if (!(_cfgName isKindOf ["VehicleMagazine", configFile >> "CfgMagazines"])) then {
					if ((getNumber ((_cfg select _i) >> "scope") == 2) && !(_cfgName in _wepMagazines)) then {
						(Sinspawn_lootList select 2) pushBackUnique _cfgName;
						HVP_mines pushBackUnique (getText ((_cfg select _i) >> "ammo"));
					};
				};
			};
		};
	};
};

//Helmets
_cfg = (configFile >> "CfgWeapons");
for "_i" from 0 to ((count _cfg)-1) do {
	if (isClass (_cfg select _i)) then {
		_cfgName = configName (_cfg select _i);
		if (_cfgName isKindof ["HelmetBase", configFile >> "CfgWeapons"] || _cfgName isKindOf ["H_HelmetB", configFile >> "CfgWeapons"]) then {
			if ((getNumber ((_cfg select _i) >> "scope") == 2) && !(_cfgName in (Sinspawn_lootList select 7))) then {
				if ((count (getArray ((_cfg select _i) >> "subItems"))) isEqualTo 0) then {
					(Sinspawn_lootList select 5) pushBackUnique _cfgName;
				} else {
					(Sinspawn_lootList select 11) pushBackUnique _cfgName;
				};
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
			if (!(_cfgName in (Sinspawn_lootList select 7))) then {
				(Sinspawn_lootList select 5) pushBackUnique _cfgName;
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
			if (!(_cfgName in (Sinspawn_lootList select 8))) then {
				(Sinspawn_lootList select 5) pushBackUnique _cfgName;
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
				(Sinspawn_lootList select 6) pushBackUnique _cfgName;
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
			(Sinspawn_lootList select 7) pushBackUnique _cfgName;
		};
	};
};

//Night vision -- configfile >> "CfgWeapons" >> "O_NVGoggles_ghex_F" >> "visionMode" array
_cfg = (configFile >> "CfgWeapons");
for "_i" from 0 to ((count _cfg)-1) do {
	if (isClass (_cfg select _i)) then {
		_cfgName = configName (_cfg select _i);
		if (_cfgName isKindOf ["NVGoggles", configFile >> "CfgWeapons"]) then {
			if ((getNumber ((_cfg select _i) >> "scope") == 2)) then {
				if ("TI" in (getArray ((_cfg select _i) >> "visionMode"))) then {
					(Sinspawn_lootList select 11) pushBackUnique _cfgName;
				} else {
					(Sinspawn_lootList select 9) pushBackUnique _cfgName;
				};
			};
		};
	};
};

//-----------------------------------
//-EXTRAS

if (HVPZombieMode isEqualTo 1) then {
	(Sinspawn_lootList select 4) pushBack "RyanZombiesAntiVirusTemporary_Item";
	(Sinspawn_lootList select 4) pushBack "RyanZombiesAntiVirusCure_Item";
};

//-----------------------------------
publicVariable "Sinspawn_lootList";
//-----------------------------------