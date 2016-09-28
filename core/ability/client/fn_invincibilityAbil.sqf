/*
	HVP2 Invincibility Ability Effect
	By Sinbane
	Become invincible temporarily
*/
private ["_count","_timer","_chemLight","_minTime","_maxTime","_time"];
//-----------------------------------
//-EFFECT

_minTime = ["invincibilityMinTime"] call HVP_fnc_getSetting;
_maxTime = ["invincibilityMaxTime"] call HVP_fnc_getSetting;
_time = (_minTime + random(_maxTime - _minTime));

(findDisplay 46) displayRemoveEventHandler ["KeyDown", SIN_abilityDEH];

titleText ["INVINCIBILITY ACTIVATED", "PLAIN DOWN", 0.5];
_chemLight = createVehicle ["Chemlight_Red", [0,0,0], [], 0, "NONE"];
_chemLight attachTo [player, [-0.1, 0.1, 0.15], "Pelvis"];
player allowDamage false;

[_time] call HVP_fnc_progressBar;

player allowDamage true;
deleteVehicle _chemLight;
titleText ["INVINCIBILITY DEACTIVATED", "PLAIN DOWN", 0.5];

//-----------------------------------
//-ADD AT NEXT PHASE

["Invincibility"] spawn HVP_fnc_addAbility;	