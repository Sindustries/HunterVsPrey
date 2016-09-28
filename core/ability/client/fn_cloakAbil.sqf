/* 
	Cloaking Script
	By XxRTEKxX, HallyG & DreadedEntity
	Adapted for HVP2 by Sin
*/
private ["_minTime","_maxTime","_time"];
//-----------------------------------
//-EFFECT

_minTime = ["cloakMinTime"] call HVP_fnc_getSetting;
_maxTime = ["cloakMaxTime"] call HVP_fnc_getSetting;
_time = (_minTime + random(_maxTime - _minTime));

(findDisplay 46) displayRemoveEventHandler ["KeyDown", SIN_abilityDEH];

[_time] spawn HVP_fnc_cloakAbilEffect;
[_time] call HVP_fnc_progressBar;

titleText ["CLOAK DEACTIVATED", "PLAIN DOWN", 0.5];

//-----------------------------------
//-ADD AT NEXT PHASE

["Cloak"] spawn HVP_fnc_addAbility;	