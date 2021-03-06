/*
	HVP End Conditions
	Author: Sinbane
	Ends game when conditions are met
*/
if (!isServer) exitWith {};
private ["_delay","_redalive","_bluAlive","_mercAlive","_allAlive"];
//-----------------------------------
//-DEFINABLE

_delay = 20;

//-----------------------------------
//-FUNCTIONS

end_HVPwinner = {
	maintask setTaskState "Succeeded";
	["TaskSucceeded",["","Win The Games"]] call bis_fnc_showNotification;

	for "_i" from 0 to (8+floor(random 10)) do {
		_pos = [(getPos player),0,30] call SIN_fnc_findPos;
		_launcher = "land_helipadempty_f" createVehicleLocal _pos;
		[_launcher,60] spawn HVP_fnc_fireWorks;
		sleep 1+(random 2);
	};
};

end_HVPloser = {
	maintask setTaskState "Failed";
	["TaskFailed",["","Win The Games"]] call bis_fnc_showNotification;
};

//-----------------------------------
//-HVP MODE

if (HVPGameType isEqualTo 1) then {
	while {true} do {
		_redAlive = {isPlayer _x && (_x getVariable ["HVP_alive",false]) isEqualTo false && side _x isEqualTo east} count allUnits;
		_bluAlive = {isPlayer _x && (_x getVariable ["HVP_alive",false]) isEqualTo false && side _x isEqualTo west} count allUnits;
		_mercAlive = {isPlayer _x && (_x getVariable ["HVP_alive",false]) isEqualTo false && side _x isEqualTo resistance} count allUnits;

		if (_redAlive isEqualTo 0 && _bluAlive > 0 && _mercAlive isEqualTo 0) exitWith {
			{
				if (isPlayer _x && side _x isEqualTo WEST) then {
					remoteExec ["end_HVPwinner", _x];
					if (HVPStatMode isEqualTo 1) then {
						["STAT_timesPlayedHVP",_x] call STAT_addStat;
						["STAT_timesWonHVP",_x] call STAT_addStat;
					};
				};
				if (isPlayer _x && side _x != WEST) then {
					remoteExec ["end_HVPloser", _x];
					if (HVPStatMode isEqualTo 1) then {
						["STAT_timesPlayedHVP",_x] call STAT_addStat;
						["STAT_timesLostHVP",_x] call STAT_addStat;
					};
				};
			} forEach allUnits;

			sleep _delay;
			"bluewin" call BIS_fnc_endMissionServer;
		};
		if (_redAlive > 0 && _bluAlive isEqualTo 0 && _mercAlive isEqualTo 0) exitWith {
			{
				if (isPlayer _x && side _x isEqualTo EAST) then {
					remoteExec ["end_HVPwinner", _x];
					if (HVPStatMode isEqualTo 1) then {
						["STAT_timesPlayedHVP",_x] call STAT_addStat;
						["STAT_timesWonHVP",_x] call STAT_addStat;
					};
				};
				if (isPlayer _x && side _x != EAST) then {
					remoteExec ["end_HVPloser", _x];
					if (HVPStatMode isEqualTo 1) then {
						["STAT_timesPlayedHVP",_x] call STAT_addStat;
						["STAT_timesLostHVP",_x] call STAT_addStat;
					};
				};
			} forEach allUnits;

			sleep _delay;
			"redwin" call BIS_fnc_endMissionServer;
		};
		if (_redAlive isEqualTo 0 && _bluAlive isEqualTo 0 && _mercAlive > 0) exitWith {
			{
				if (isPlayer _x && side _x isEqualTo RESISTANCE) then {
					remoteExec ["end_HVPwinner", _x];
					if (HVPStatMode isEqualTo 1) then {
						["STAT_timesPlayedHVP",_x] call STAT_addStat;
						["STAT_timesWonHVP",_x] call STAT_addStat;
					};
				};
				if (isPlayer _x && side _x != RESISTANCE) then {
					remoteExec ["end_HVPloser", _x];
					if (HVPStatMode isEqualTo 1) then {
						["STAT_timesPlayedHVP",_x] call STAT_addStat;
						["STAT_timesLostHVP",_x] call STAT_addStat;
					};
				};
			} forEach allUnits;

			sleep _delay;
			"mercwin" call BIS_fnc_endMissionServer;
		};
		if (_redAlive isEqualTo 0 && _bluAlive isEqualTo 0 && _mercAlive isEqualTo 0) exitWith {
			{
				if (isPlayer _x) then {
					remoteExec ["end_HVPloser", _x];
					if (HVPStatMode isEqualTo 1) then {
						["STAT_timesPlayedHVP",_x] call STAT_addStat;
						["STAT_timesLostHVP",_x] call STAT_addStat;
					};
				};
			} forEach allUnits;

			sleep _delay;
			"nobodywin" call BIS_fnc_endMissionServer;
		};
		sleep 3;
	};
};

//-----------------------------------
//-CRUCIBLE MODE

if (HVPGameType isEqualTo 2) then {
	while {true} do {
		_allAlive = {isPlayer _x && (_x getVariable ["HVP_alive",false]) isEqualTo true && side _x != sideLogic} count allUnits;

		if (_allAlive isEqualTo 1) exitWith {
			{
				if (isPlayer _x && alive _x && side _x != sideLogic) then {
					remoteExec ["end_HVPwinner", _x];
					if (HVPStatMode isEqualTo 1) then {
						["STAT_timesPlayedCRU",_x] call STAT_addStat;
						["STAT_timesWonCRU",_x] call STAT_addStat;
					};
				};
				if (isPlayer _x && !alive _x && side _x != sideLogic) then {
					remoteExec ["end_HVPloser", _x];
					if (HVPStatMode isEqualTo 1) then {
						["STAT_timesPlayedCRU",_x] call STAT_addStat;
						["STAT_timesLostCRU",_x] call STAT_addStat;
					};
				};
			} forEach allUnits;

			sleep _delay;
			"solowin" call BIS_fnc_endMissionServer;
		};
		if (_allAlive isEqualTo 0) exitWith {
			{
				if (isPlayer _x && side _x != sideLogic) then {
					remoteExec ["end_HVPloser", _x];
					if (HVPStatMode isEqualTo 1) then {
						["STAT_timesPlayedCRU",_x] call STAT_addStat;
						["STAT_timesLostCRU",_x] call STAT_addStat;
					};
				};
			} forEach allUnits;

			sleep _delay;
			"nobodywin" call BIS_fnc_endMissionServer;
		};
		sleep 3;
	};
};

//-----------------------------------
//-PREDATOR MODE

if (HVPGameType isEqualTo 3) then {
	while {true} do {
		private ["_preyAlive","_predAlive"];
		_preyAlive = {isPlayer _x && (_x getVariable ["HVP_alive",false]) isEqualTo false && side _x != RESISTANCE && side _x != sideLogic} count allUnits;
		_predAlive = {isPlayer _x && (_x getVariable ["HVP_alive",false]) isEqualTo false && side _x isEqualTo resistance} count allUnits;

		if (_preyAlive isEqualTo 0) exitWith {
			{
				if (isPlayer _x && alive _x && side _x != sideLogic) then {
					remoteExec ["end_HVPwinner", _x];
					if (HVPStatMode isEqualTo 1) then {
						["STAT_timesPlayedPRED",_x] call STAT_addStat;
						["STAT_timesWonPRED",_x] call STAT_addStat;
					};
				};
				if (isPlayer _x && !alive _x && side _x != sideLogic) then {
					remoteExec ["end_HVPloser", _x];
					if (HVPStatMode isEqualTo 1) then {
						["STAT_timesPlayedPRED",_x] call STAT_addStat;
						["STAT_timesLostPRED",_x] call STAT_addStat;
					};
				};
			} forEach allUnits;

			sleep _delay;
			"predatorwin" call BIS_fnc_endMissionServer;
		};
		if (_predAlive isEqualTo 0) exitWith {
			{
				if (isPlayer _x && alive _x && side _x != sideLogic) then {
					remoteExec ["end_HVPwinner", _x];
					if (HVPStatMode isEqualTo 1) then {
						["STAT_timesPlayedPRED",_x] call STAT_addStat;
						["STAT_timesWonPRED",_x] call STAT_addStat;
					};
				};
				if (isPlayer _x && !alive _x && side _x != sideLogic) then {
					remoteExec ["end_HVPloser", _x];
					if (HVPStatMode isEqualTo 1) then {
						["STAT_timesPlayedPRED",_x] call STAT_addStat;
						["STAT_timesLostPRED",_x] call STAT_addStat;
					};
				};
			} forEach allUnits;

			sleep _delay;
			"preywin" call BIS_fnc_endMissionServer;
		};
		sleep 3;
	};
};

//-----------------------------------