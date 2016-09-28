/*
	HVP Disarm Ability
	Author: Sinbane
	Immediatly disarms nearby enemies of their current weapon
*/
//-----------------------------------
//-GET POS FOR DISARM

(findDisplay 46) displayRemoveEventHandler ["KeyDown", SIN_abilityDEH];

titleText ["DISARM ACTIVATED", "PLAIN DOWN", 0.5];

[(getPos player),player] remoteExec ["HVP_fnc_disarmAbilEffect", 0];

//-----------------------------------
//-ADD AT NEXT PHASE

["Disarm"] spawn HVP_fnc_addAbility;	