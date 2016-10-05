/*
	fn_setZSpawn
	Author: Sinbane
	Sets a spawn loction for zombies
*/
private ["_pos","_count","_posFound","_spawnPos","_posCheck","_distCheck"];
//-----------------------------------

	_pos = _this select 0;

	_spawnPos = [_pos,0,50,0.05,0,0,0] call SIN_fnc_findPos;
	HVP_spawnerArray pushBack _spawnPos;

//-----------------------------------