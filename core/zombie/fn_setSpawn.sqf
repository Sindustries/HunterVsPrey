/*
	fn_setZSpawn
	Author: Sinbane
	Sets a spawn loction for zombies
*/
private ["_pos","_count","_posFound","_spawnPos","_posCheck","_distCheck"];
//-----------------------------------

	_pos = _this select 0;

	_posFound = false;
	while {!_posFound} do {
		_spawnPos = [_pos,0,50,0.05,0,0,0] call BIS_fnc_findSafePos;
		_posCheck = [_spawnPos] call SIN_fnc_checkPos;
		_distCheck = [_spawnPos,HVP_spawnerArray,80] call SIN_fnc_checkDist;
		if (_posCheck && _distCheck) then {
			_posFound = true;
			HVP_spawnerArray pushBack _spawnPos;
		};
	};

//-----------------------------------