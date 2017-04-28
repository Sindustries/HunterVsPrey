private ["_pos","_size","_houseList","_lootchance","_zAdjustHouse","_zAdjustWild","_safePlace","_gunsWithMags","_chanceWild","_houseList","_roll","_spawnFound","_posCheck","_count","_counter","_lootpositions"];

_pos = _this select 0;
_size = _this select 1;
_lootchance = _this select 2;
_zAdjustHouse = _this select 3;
_zAdjustWild = _this select 4;
_safePlace = _this select 5;
_gunsWithMag = _this select 6;
_chanceWild = _this select 7;

_houseList = _pos nearObjects ["Building",_size];

_counter = (count _houseList);
{
	if ((random 100) < _chanceWild) then {
		private ["_spawnFound","_spawnPos","_posCheck"];
		_spawnPos = [_pos,0,_size] call SIN_fnc_findPos;
		if (_spawnPos in Sinspawn_usedPos) exitWith {};
		Sinspawn_usedPos pushBackUnique _spawnPos;
		_spawnPos = [_spawnPos select 0, _spawnPos select 1, 0];
		[_spawnPos,_zAdjustWild,_gunsWithMag,_safePlace] spawn HVP_fnc_spawnLoot;
		if (HVPZombieMode isEqualTo 1 && (random 100) < (_lootChance * 0.1)) then {
			[_spawnPos] spawn Z_fnc_setSpawn;
		};
	};
	_lootpositions = _x buildingPos -1;
	for "_count" from 0 to (count _lootpositions) do {
		_buildingPos = _x buildingPos _count;
		if (_buildingPos in Sinspawn_usedPos) exitWith {};
		Sinspawn_usedPos pushBackUnique _buildingPos;
		if (str _buildingPos isEqualTo "[0,0,0]") exitwith {};
		if ((random 100) < _lootChance) then {
			[_buildingPos,_zAdjustHouse,_gunsWithMag,_safePlace] call HVP_fnc_spawnLoot;
		};
		if (HVPZombieMode isEqualTo 1 && (random 100) < (_lootChance * 0.033)) then {
			[_buildingPos] spawn Z_fnc_setSpawn;
		};
	};
	_counter = _counter - 1;
	[_counter,(count _houseList)] remoteExec ["HVP_fnc_updateProgressBar", 0];
} forEach _houseList;