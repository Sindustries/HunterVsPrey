/*
	HVP2 Temporary Night Vision Ability Effect
	By Sinbane
	Gives mercenary temporary night vision
*/
private ["_minTime","_maxTime","_time"];
//-----------------------------------
//-EFFECT

_minTime = ["nightVisionMinTime"] call HVP_fnc_getSetting;
_maxTime = ["nightVisionMaxTime"] call HVP_fnc_getSetting;
_time = (_minTime + random(_maxTime - _minTime));

player action ["GunLightOff", player];
player action ["nvGoggles", player];
titleText ["TEMPORARY NIGHT VISION", "PLAIN DOWN", 0.5];

[_time] call HVP_fnc_progressBar;

player action ["nvGogglesOff", player];
	
//-----------------------------------
//-ADD AT NEXT PHASE

["TemporaryNightVision"] spawn HVP_fnc_addAbility;	