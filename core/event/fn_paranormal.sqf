/*
	HVP2 Paranormal Activity Event Script
	By Sinbane
*/
//waitUntil {HVP_phase_active isEqualTo "true"};
private ["_eventRoll","_event"];
//-----------------------------------
//-TEAM MODE
if (HVPGameType isEqualTo 1) then {
//-----------------------------------
//-BEGIN LOOP
	while {alive player} do {
//-----------------------------------
//-ROLL FOR EVENT

		sleep HVP_rareEvent;
		if (HVP_suddenDeath) exitWith {};

		if (sunOrMoon isEqualTo 0) then {
			if (vehicle player isEqualTo player) then {

				_eventRoll = floor (random 5);
				player setCaptive true;

				if (_eventRoll isEqualTo 0) then {
					if (side player isEqualTo WEST || side player isEqualTo RESISTANCE) then {
						[] call HVP_fnc_paraGhost;
					};
					if (side player isEqualTo EAST) then {
						[] call HVP_fnc_paraTeleport;
					};
				};
				if (_eventRoll isEqualTo 1) then {
					if (side player isEqualTo WEST || side player isEqualTo RESISTANCE) then {
						[] call HVP_fnc_paraDecoy;
					};
					if (side player isEqualTo EAST) then {
						[] call HVP_fnc_paraDarkness;
					};
				};
				if (_eventRoll isEqualTo 2) then {
					player additem "ACE_Banana";
				};
				if (_eventRoll isEqualTo 3) then {
					_allUnits = {isPlayer _x && alive _x && side _x != sideLogic} count playableUnits;
					if (_allUnits > 4) then {
						[] call HVP_fnc_paraChat;
					};
				};
				if (_eventRoll isEqualTo 4) then {
					[] call HVP_fnc_paraSkydive;
				};
				player setCaptive false;
			};
		};

//-----------------------------------
//-STOP LOOP
	};
};
//-----------------------------------
//-CRUCIBLE/PREDATOR MODE
if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
//-----------------------------------
//-BEGIN LOOP
	while {alive player} do {
//-----------------------------------
//-ROLL FOR EVENT

		sleep HVP_rareEvent;
		if (HVP_suddenDeath) exitWith {};

		if (sunOrMoon isEqualTo 0) then {
			if (vehicle player isEqualTo player) then {

				_eventRoll = floor (random 7);
				player setCaptive true;

				if (_eventRoll isEqualTo 0) then {
					[] call HVP_fnc_paraGhost;
				};
				if (_eventRoll isEqualTo 1) then {
					[] call HVP_fnc_paraTeleport;
				};
				if (_eventRoll isEqualTo 2) then {
					[] call HVP_fnc_paraDecoy;
				};
				if (_eventRoll isEqualTo 3) then {
					[] call HVP_fnc_paraDarkness;
				};
				if (_eventRoll isEqualTo 4) then {
					player additem "ACE_Banana";
				};
				if (_eventRoll isEqualTo 5) then {
					_allUnits = {isPlayer _x && alive _x && side _x != sideLogic} count playableUnits;
					if (_allUnits > 4) then {
						[] call HVP_fnc_paraChat;
					};
				};
				if (_eventRoll isEqualTo 6) then {
					[] call HVP_fnc_paraSkydive;
				};
				player setCaptive false;
			};
		};

//-----------------------------------
//-STOP LOOP
	};
};