/*
	HVP2 Fatigue Free Ability
	By Sinbane
	Grants immunity to fatigue and health regen to nearby friendlies
*/
private ["_regenHP","_regenRate","_abilTime","_pos","_minTime","_maxTime","_time"];
//-----------------------------------
//--VARIABLES

_regenHP = 0.05;
_regenRate = 15;
_abilTime = 120;

_minTime = ["cloakMinTime"] call HVP_fnc_getSetting;
_maxTime = ["cloakMaxTime"] call HVP_fnc_getSetting;
_time = (_minTime + random(_maxTime - _minTime));

_pos = _this select 0;

//-----------------------------------
//-TEAM MODE

if (side player isEqualTo WEST && HVPGameType isEqualTo 1 || HVPGameType isEqualTo 3) then {
	if ((player distance _pos) < 80) then {
		titleText ["TEMPORARY IMMUNITY TO FATIGUE AND HEALTH REGENERATION", "PLAIN DOWN", 0.6];
		
		[_regenHP,_regenRate,_abilTime] spawn HVP_fnc_healthRegenAbilEffect;
		
		player setVariable ["isFatigueFree",true];
		player enableStamina false;
		
		[_time] call HVP_fnc_progressBar;
		
		player enableStamina true;
		player setVariable ["isFatigueFree",false];
		
		titleText ["IMMUNITY TO FATIGUE EXPIRED", "PLAIN DOWN", 0.6];
	};
};

//-----------------------------------
//-SOLO MODE

if (HVPGameType isEqualTo 2) then {
	titleText ["TEMPORARY IMMUNITY TO FATIGUE AND HEALTH REGENERATION", "PLAIN DOWN", 0.6];
		
	[_regenHP,_regenRate,_abilTime] spawn HVP_fnc_healthRegenAbilEffect;
		
	player setVariable ["isFatigueFree",true];
	player enableStamina false;
		
	[_time] call HVP_fnc_progressBar;
		
	player enableStamina true;
	player setVariable ["isFatigueFree",false];
	
	titleText ["IMMUNITY TO FATIGUE EXPIRED", "PLAIN DOWN", 0.6];
};

//-----------------------------------