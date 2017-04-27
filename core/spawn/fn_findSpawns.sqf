/*
	HVP Player Spawn Finder
	Author: Sinbane
	Finds a spawn location for each player
*/
if (!isServer) exitWith {};
private ["_usedSpawnPos","_allPlayers","_readyPlayers","_mercAlive","_spawns","_spawn","_spawnFound","_posCheck","_distCheck","_spawnPos"];
//-----------------------------------

_usedSpawnPos = [];
_allPlayers = {isPlayer _x && alive _x && side _x != sideLogic} count playableUnits;
_readyPlayers = {(_x getVariable "HVP_ready") isEqualTo true && (_x getVariable "HVP_spawned") isEqualTo false} count playableUnits;

_unconsciousChance = ["groundChanceUnconscious"] call HVP_fnc_getSetting;

while {_readyPlayers != _allPlayers} do {
	_allPlayers = {isPlayer _x && alive _x && side _x != sideLogic} count playableUnits;
	_readyPlayers = {(_x getVariable "HVP_ready") isEqualTo true} count playableUnits;
	sleep 1;
};
waitUntil {_readyPlayers isEqualTo _allPlayers};

//-----------------------------------
//-SPAWN !

{
	if (isPlayer _x && alive _x) then {
		if (HVPSpawnType isEqualTo 0) then {
			_spawns = ["Ground","HALO","Heli","Pod"];
			_spawn = selectRandom _spawns;
			if (_spawn isEqualTo "Ground") then {
				_spawnFound = false;
				while {!_spawnFound} do {
					_spawnPos = [HVP_Pos,0,(HVPZoneSizeMax*1.2),0.25,0,0,0] call SIN_fnc_findPos;
					_distCheck = [_spawnPos,_usedSpawnPos,((HVPZoneSizeMax*2)/_allPlayers)] call SIN_fnc_checkDist;
					if (_distCheck) then {
						_spawnFound = true;
						_usedSpawnPos pushBack _spawnPos;
						_x setPos [_spawnPos select 0,_spawnPos select 1,0];
						_x setDir (random 360);
						_x setVariable ["HVP_spawned", true, true];
						if ((random 100) < _unconsciousChance && HVPTestMode isEqualTo 0) then {
							[_x, 10] remoteExec ["SMS_fnc_setUnconscious", _x];
						};
					};
				};
			};
			if (_spawn isEqualTo "HALO") then {
				_spawnFound = false;
				while {!_spawnFound} do {
					_spawnPos = [HVP_Pos,0,(HVPZoneSizeMax * 1.2),0,0,0,0] call SIN_fnc_findPos;
					_distCheck = [_spawnPos,_usedSpawnPos,((HVPZoneSizeMax*2)/_allPlayers)] call SIN_fnc_checkDist;
					if (_distCheck) then {
						_spawnFound = true;
						_usedSpawnPos pushBack _spawnPos;
						[_spawnPos] remoteExec ["HVP_fnc_haloSpawn", _x];
					};
				};
			};
			if (_spawn isEqualTo "Heli") then {
				_spawnFound = false;
				while {!_spawnFound} do {
					_spawnPos = [HVP_Pos,0,(HVPZoneSizeMax * 1),0,0,0,0] call SIN_fnc_findPos;
					_distCheck = [_spawnPos,_usedSpawnPos,((HVPZoneSizeMax*2)/_allPlayers)] call SIN_fnc_checkDist;
					if (_distCheck) then {
						_spawnFound = true;
						_usedSpawnPos pushBack _spawnPos;
						[(side _x),_spawnPos] remoteExec ["HVP_fnc_heliSpawn", _x];
					};
				};
			};
			if (_spawn isEqualTo "Pod") then {
				_spawnFound = false;
				while {!_spawnFound} do {
					_spawnPos = [HVP_Pos,0,(HVPZoneSizeMax * 1.2),0,0,0,0] call SIN_fnc_findPos;
					_distCheck = [_spawnPos,_usedSpawnPos,((HVPZoneSizeMax*2)/_allPlayers)] call SIN_fnc_checkDist;
					if (_distCheck) then {
						_spawnFound = true;
						_usedSpawnPos pushBack _spawnPos;
						[(side _x),_spawnPos] remoteExec ["HVP_fnc_podSpawn", _x];
					};
				};
			};
		};
		if (HVPSpawnType isEqualTo 1) then {
			_spawnFound = false;
			while {!_spawnFound} do {
				_spawnPos = [HVP_Pos,0,(HVPZoneSizeMax * 1.2),0.25,0,0,0] call SIN_fnc_findPos;
				_distCheck = [_spawnPos,_usedSpawnPos,((HVPZoneSizeMax*2)/_allPlayers)] call SIN_fnc_checkDist;
				if (_distCheck) then {
					_spawnFound = true;
					_usedSpawnPos pushBack _spawnPos;
					_x setPos [_spawnPos select 0,_spawnPos select 1,0];
					_x setDir (random 360);
					if ((random 100) < _unconsciousChance && HVPTestMode isEqualTo 0) then {
						_x enableSimulation true;
						[_x, 10] remoteExec ["SMS_fnc_setUnconscious", _x];
					};
					_x setVariable ["HVP_spawned", true, true];
				};
			};
		};
		if (HVPSpawnType isEqualTo 2) then {
			_spawnFound = false;
			while {!_spawnFound} do {
				_spawnPos = [HVP_Pos,0,(HVPZoneSizeMax * 1.2),0,0,0,0] call SIN_fnc_findPos;
				_distCheck = [_spawnPos,_usedSpawnPos,((HVPZoneSizeMax*2)/_allPlayers)] call SIN_fnc_checkDist;
				if (_distCheck) then {
					_spawnFound = true;
					_usedSpawnPos pushBack _spawnPos;
					[_spawnPos] remoteExec ["HVP_fnc_haloSpawn", _x];
				};
			};
		};
		if (HVPSpawnType isEqualTo 3) then {
			_spawnFound = false;
				while {!_spawnFound} do {
				_spawnPos = [HVP_Pos,0,(HVPZoneSizeMax * 1),0,0,0,0] call SIN_fnc_findPos;
				_distCheck = [_spawnPos,_usedSpawnPos,((HVPZoneSizeMax*2)/_allPlayers)] call SIN_fnc_checkDist;
				if (_distCheck) then {
					_spawnFound = true;
					_usedSpawnPos pushBack _spawnPos;
					[(side _x),_spawnPos] remoteExec ["HVP_fnc_heliSpawn", _x];
				};
			};
		};
		if (HVPSpawnType isEqualTo 4) then {
			_spawnFound = false;
			while {!_spawnFound} do {
				_spawnPos = [HVP_Pos,0,(HVPZoneSizeMax * 1.2),0,0,0,0] call SIN_fnc_findPos;
				_distCheck = [_spawnPos,_usedSpawnPos,((HVPZoneSizeMax*2)/_allPlayers)] call SIN_fnc_checkDist;
				if (_distCheck) then {
					_spawnFound = true;
					_usedSpawnPos pushBack _spawnPos;
					[(side _x),_spawnPos] remoteExec ["HVP_fnc_podSpawn", _x];
				};
			};
		};
	};
} forEach playableUnits;


//-----------------------------------