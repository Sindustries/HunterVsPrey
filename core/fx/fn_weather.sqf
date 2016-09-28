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

if (HVPTimeMult <= 120) then {
	setTimeMultiplier HVPTimeMult;
} else {
	if (daytime < 6 && daytime >= 0 || daytime < 24 && daytime > 18) then {
		setTimeMultiplier _nightMult;
	};
	if (daytime > 6 && daytime <= 18) then {
		setTimeMultiplier _dayMult;
	};
	[_dayMult,_nightMult] spawn {
		private ["_dayMult","_nightMult"];
		_dayMult = _this select 0;
		_nightMult = _this select 1;
		while {true} do {
			waitUntil {sleep 1; daytime > 5 && daytime < 6 || daytime > 17 && daytime < 18};
			if (daytime > 5 && daytime < 6) then {
				setTimeMultiplier _dayMult;
				waitUntil {sleep 1; daytime > 6};
			};
			if (daytime > 17 && daytime < 18) then {
				setTimeMultiplier _nightMult;
				waitUntil {sleep 1; daytime > 18};
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
	
	_onGround = {isPlayer _x && isTouchingGround _x && (getPosATL _x select 2) < 1} count allUnits;
	_allUnits = {isPlayer _x && side _x != sideLogic} count allUnits;
	while {_onGround != _allUnits} do {
		_onGround = {isPlayer _x && isTouchingGround _x && (getPosATL _x select 2) < 1} count allUnits;
		_allUnits = {isPlayer _x && side _x != sideLogic} count allUnits;
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
	if (daytime < 6 && daytime >= 0 || daytime < 24 && daytime > 18) then {
		0 setOvercast (random 1);
		0 setFog (random 0.8);
	};
	if (daytime > 6 && daytime <= 18) then {
		0 setOvercast (random 1);
		0 setFog (random 0.8);
	};
	waitUntil {sleep 1; daytime > 5 && daytime < 6 || daytime > 17 && daytime < 18};
	while {true} do {
		if (daytime > 5 && daytime < 6) then {
			(30 * timeMultiplier) setOvercast (random 1);
			waitUntil {sleep 1; daytime > 6};
			(30 * timeMultiplier) setFog (random 0.8);
		};
		if (daytime > 17 && daytime < 18) then {
			(30 * timeMultiplier) setOvercast (random 1);
			waitUntil {sleep 1; daytime > 18};
			(30 * timeMultiplier) setFog (random 0.8);
		};
		sleep 1;
		waitUntil {sleep 1; daytime > 5 && daytime < 6 || daytime > 17 && daytime < 18};
	};
};

//-----------------------------------