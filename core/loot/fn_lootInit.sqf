disableSerialization;
/*
	Sin Loot Spawner for HVP2
	Author: BangaBob | Heavily Modified for HVP by Sinbane
	Spawns loot
*/
private ["_pos","_sizeMult","_size","_lootChance","_zAdjustHouse","_zAdjustWild","_safePlace","_gunsWithMag","_chanceWild"];
if (!isServer) exitwith {};
//-----------------------------------
//-CONFIG

_pos = HVP_Pos;
_sizeMult = ["lootSpawn_mult"] call HVP_fnc_getSetting;
_size = (HVPZoneSizeMax * 1.25);
if (HVPGameType isEqualTo 1) then {
	HVP_lootSpawnChance = ["lootSpawn_HVPchance"] call HVP_fnc_getSetting;
};
if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
	HVP_lootSpawnChance = ["lootSpawn_CRUchance"] call HVP_fnc_getSetting;
};
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

//-----------------------------------
//-BEGIN MAIN FUNCTION

[_pos,_size,HVP_lootSpawnChance,_zAdjustHouse,_zAdjustWild,_safePlace,_gunsWithMag,_chanceWild] call HVP_fnc_lootMain;
publicVariable "Sinspawn_holders";
remoteExec ["sinspawn_fn_hideLoot", 0];

//-----------------------------------