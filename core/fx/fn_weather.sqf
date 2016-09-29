/*
	HVP Weather Controller
	Author: Sinbane
	Sets weather depending on game mode and time of day
*/
private ["_dayMult","_nightMult"];
//-----------------------------------
//-TIME CONTROL

_dayMult = ["daytimeMultiplier"] call HVP_fnc_getSetting;
_nightMult = ["nighttimeMultiplier"] call HVP_fnc_getSetting;

if (HVPGameType isEqualTo 1) then {
	setTimeMultiplier 0;
};
if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
	if (sunOrMoon isEqualTo 0) then {
		setTimeMultiplier _nightMult;
	};
	if (sunOrMoon > 0) then {
		setTimeMultiplier _dayMult;
	};
	[_dayMult,_nightMult] spawn {
		private ["_dayMult","_nightMult"];
		_dayMult = _this select 0;
		_nightMult = _this select 1;
		while {true} do {
			waitUntil {sleep 0.5; sunOrMoon isEqualTo 0 || sunOrMoon isEqualTo 1};
			if (sunOrMoon > 0) then {
				setTimeMultiplier _dayMult;
				waitUntil {sleep 0.5; sunOrMoon isEqualTo 0};
			};
			if (sunOrMoon isEqualTo 0) then {
				setTimeMultiplier _nightMult;
				waitUntil {sleep 0.5; sunOrMoon > 0};
			};
		sleep 1;
		};
	};
};

//-----------------------------------
//-PREVENT WIND RELATED SPAWN DEATHS

setWind [0, 0, true];
[] spawn {
	private ["_onGround","_allUnits"];
	waitUntil {HVP_phase_num isEqualTo 1};
	
	_onGround = {isPlayer _x && isTouchingGround _x && (getPosATL _x select 2) < 1} count playableUnits;
	_allUnits = {isPlayer _x && side _x != sideLogic} count playableUnits;
	while {_onGround != _allUnits} do {
		_onGround = {isPlayer _x && isTouchingGround _x && (getPosATL _x select 2) < 1} count playableUnits;
		_allUnits = {isPlayer _x && side _x != sideLogic} count playableUnits;
		sleep 5;
	};
	sleep 10;
	setWind [0, 0, false];
};

//-----------------------------------
//-TEAM MODE

if (HVPGameType isEqualTo 1) exitWith {
	0 setOvercast 0.7;
	0 setFog 0.8;
	0 setRain (random 0.25);
	forceWeatherChange;
};

//-----------------------------------
//-CRUCIBLE & PREDATOR MODE

if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {	
	while {true} do {
		if (sunOrMoon isEqualTo 1) then {
			(30 * timeMultiplier) setOvercast (random 1);
			sleep 30;
			(30 * timeMultiplier) setFog (random 0.8);
			waitUntil {sleep 5; sunOrMoon isEqualTo 0};
		};
		if (sunOrMoon isEqualTo 0) then {
			(30 * timeMultiplier) setOvercast (random 1);
			sleep 30;
			(30 * timeMultiplier) setFog (random 0.8);
			waitUntil {sleep 5; sunOrMoon isEqualTo 1};
		};
		sleep 1;
	};
};

//-----------------------------------