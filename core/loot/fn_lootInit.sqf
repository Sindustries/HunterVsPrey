disableSerialization;
/*
	Sin Loot Spawner for HVP2
	Author: BangaBob | Heavily Modified for HVP by Sinbane
	Spawns loot
*/
private ["_pos","_sizeMult","_size","_lootChance","_zAdjustHouse","_zAdjustWild","_safePlace","_gunsWithMag","_chanceWild"];
if (!isServer) exitwith {};
if (HVPLegacyMode == 1) exitWith {systemChat "Sinspawn:: Legacy Mode enabled, shutting down.."};
//-----------------------------------
//-CONFIG

_pos = HVP_Pos;
_sizeMult = ["lootSpawn_mult"] call HVP_fnc_getSetting;
_size = (HVPZoneSizeMax * 1.25);
_lootChance = HVPLootChance;
_zAdjustHouse = ["lootSpawn_zAdjustHouse"] call HVP_fnc_getSetting;
_zAdjustWild = ["lootSpawn_zAdjustWild"] call HVP_fnc_getSetting;
_safePlace = [0,0,0];
_gunsWithMag = ["lootSpawn_gunsWithMag"] call HVP_fnc_getSetting;
_chanceWild = ["lootSpawn_chanceWild"] call HVP_fnc_getSetting;

if (HVPGameType isEqualTo 1) then {
	Sinspawn_lootChance = ["HVP_lootChance"] call HVP_fnc_getSetting;
};
if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
	Sinspawn_lootChance = ["CRU_lootChance"] call HVP_fnc_getSetting;
};

//-----------------------------------

#include "Sinspawn_lootList.sqf";

Sinspawn_usedPos = [];
Sinspawn_holders = [];
Sinspawn_weaponsSpawned = 0;
Sinspawn_magsSpawned = 0;
Sinspawn_itemsSpawned = 0;
Sinspawn_medSpawned = 0;
Sinspawn_clothingSpawned = 0;
Sinspawn_backpacksSpawned = 0;
Sinspawn_specialClothingSpawned = 0;
Sinspawn_nightVisionSpawned = 0;

//-----------------------------------
//-BEGIN MAIN FUNCTION

[_pos,_size,_lootchance,_zAdjustHouse,_zAdjustWild,_safePlace,_gunsWithMag,_chanceWild] call HVP_fnc_lootMain;
publicVariable "Sinspawn_holders";
remoteExec ["sinspawn_fn_hideLoot", 0];

diag_log format["Sinspawn:: SPAWN COMPLETE"];
diag_log format["WEAPONS: %1",Sinspawn_weaponsSpawned];
diag_log format["MAGS: %1",Sinspawn_magsSpawned];
diag_log format["ITEMS: %1",Sinspawn_itemsSpawned];
diag_log format["MEDICAL: %1",Sinspawn_medSpawned];
diag_log format["CLOTHING: %1",Sinspawn_clothingSpawned];
diag_log format["BACKPACKS: %1",Sinspawn_backpacksSpawned];
diag_log format["SPECIAL CLOTHING: %1",Sinspawn_specialClothingSpawned];
diag_log format["NIGHT VISION: %1",Sinspawn_nightVisionSpawned];

if (HVPDebugMode == 1) then {
	systemChat format["LOOT COUNT: WEAP: %1 : MAG: %2 : ITEM: %3 : MED: %4 CLOTH: %5 : BACK: %6 : SPCLOTH: %7 : NVG: %8",Sinspawn_weaponsSpawned,Sinspawn_magsSpawned,Sinspawn_itemsSpawned,Sinspawn_medSpawned,Sinspawn_clothingSpawned,Sinspawn_backpacksSpawned,Sinspawn_specialClothingSpawned,Sinspawn_nightVisionSpawned];
};

//-----------------------------------