/*
	HVP2 Fatigue Free Ability
	By Sinbane
	Grants immunity to fatigue
*/
private ["_minTime","_maxTime","_time"];
//-----------------------------------
//-EFFECT

_minTime = ["fatigueFreeMinTime"] call HVP_fnc_getSetting;
_maxTime = ["fatigueFreeMaxTime"] call HVP_fnc_getSetting;
_time = (_minTime + random(_maxTime - _minTime));

titleText ["FATIGUE FREE ACTIVATED", "PLAIN DOWN", 0.5];
player setVariable ["isFatigueFree",true];
player enableStamina false;

[_time] call HVP_fnc_progressBar;

player enableStamina true;
player setVariable ["isFatigueFree",false];

//-----------------------------------
//-ADD AT NEXT PHASE

["FatigueFree"] spawn HVP_fnc_addAbility;	