/*
	fn_useAbility.sqf
	Author: Sinbane
	Executes the players ability
*/
//-----------------------------------

waitUntil {!(isNull (findDisplay 46))};
SIN_abilityDEH = (findDisplay 46) displayAddEventHandler ["KeyDown", {
private ["_source","_keyCode","_isShift","_isCtrl","_isAlt"];
_source  = _this select 0;
_keyCode = _this select 1;
_isShift = _this select 2;
_isCtrl  = _this select 3;
_isAlt   = _this select 4;
if (_keyCode isEqualTo 28 && _isShift) then {
	[] spawn HVP_fnc_useAbility;
	true;
}
}];

//-----------------------------------