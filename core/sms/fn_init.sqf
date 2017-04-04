/*
	Sinbane Medical System
	Author: Sinbane
	Launchers all controllers for the SMS
*/
//-----------------------------------
private ["_unit"];

["SMS"] call HVP_fnc_getSettings;
SMS_maxBlood = ["SMS_maxBlood"] call HVP_fnc_getSetting;
SMS_bloodRegen = ["SMS_bloodRegen"] call HVP_fnc_getSetting;
SMS_bloodRegenRate = ["SMS_bloodRegenRate"] call HVP_fnc_getSetting;
SMS_bleedRate = ["SMS_bleedRate"] call HVP_fnc_getSetting;
SMS_bleedRateMax = ["SMS_bleedRateMax"] call HVP_fnc_getSetting;
SMS_passOutNum = ["SMS_passOutNum"] call HVP_fnc_getSetting;
SMS_passOutChance = ["SMS_passOutChance"] call HVP_fnc_getSetting;
SMS_bleedOutNum = ["SMS_bleedOutNum"] call HVP_fnc_getSetting;
SMS_bleedoutChance = ["SMS_bleedoutChance"] call HVP_fnc_getSetting;
SMS_bloodLossCOEF = ["SMS_bloodLossCOEF"] call HVP_fnc_getSetting;
SMS_fallDamage = ["SMS_fallDamage"] call HVP_fnc_getSetting;

//-----------------------------------

_unit = _this select 0;
if (_unit != player) exitWith {};

if (getText (configFile >> "cfgVehicles" >> typeOf player >> "role") isEqualTo "CombatLifeSaver") then {
	_unit setVariable ["SMS_isMedic", true];
} else {
	_unit setVariable ["SMS_isMedic", false];
};

//-----------------------------------

_unit setVariable ["SMS_bleeding", false];
_unit setVariable ["SMS_bloodLevel", SMS_maxBlood];
_unit setVariable ["SMS_bleedingRate", 0];
_unit setVariable ["SMS_isUnconscious", false];
_unit setVariable ["SMS_inBleedout", false];

[_unit] call SMS_fnc_handleDamage;
[_unit] call SMS_fnc_handleHeal;
[_unit] spawn SMS_fnc_bloodLevel;
//[_unit] spawn SMS_fnc_healAction;

//-----------------------------------