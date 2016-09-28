/*
	fn_zDeleter
	Author: Sinbane
	Deletes zombies further than a distance from players
*/
if (HVP_zombieCount >= HVP_maxZombies) exitWith {};
private ["_pos","_zombieCount","_zombie","_group","_posFound","_spawnPos","_posCheck"];
//-----------------------------------

	_pos = _this select 0;
	_maxNum = _this select 1;
	_group = createGroup resistance;
		
	for "_zombieCount" from 0 to (floor(random _maxNum)+1) do {
		if (HVP_zombieCount <= HVP_maxZombies) then {
			_posFound = false;
			while {!_posFound} do {
				_spawnPos = [_pos,0,15,0,0,0,0] call BIS_fnc_findSafePos;
				_posCheck = [_spawnPos] call SIN_fnc_checkPos;
				if (_posCheck) then {
					_posFound = true;
					_zombie = _group createUnit [(selectRandom HVP_Zombies), _spawnPos, [], 0, "NONE"];
					_zombie switchMove "AmovPercMstpSnonWnonDnon_SaluteOut";
					HVP_zombieArray pushBack _zombie;
					HVP_zombieCount = (count HVP_zombieArray);
					publicVariable "HVP_zombieCount";
				};
			};
		};
	};

//-----------------------------------