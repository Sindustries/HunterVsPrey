/*
	HVP Escape Ability
	Author: Sinbane
	Immediatly teleports the user to a new location	
*/
private ["_spawnFound","_pos","_posCheck"];
//-----------------------------------

(findDisplay 46) displayRemoveEventHandler ["KeyDown", SIN_abilityDEH];

_safePlayer = player;
[_safePlayer,(getPos player)] remoteExec ["HVP_fnc_banishAbilEffect", 0];

titleText ["BANISH ACTIVATED", "PLAIN DOWN", 0.5];

//-----------------------------------
//-ADD AT NEXT PHASE

["Banish"] spawn HVP_fnc_addAbility;	