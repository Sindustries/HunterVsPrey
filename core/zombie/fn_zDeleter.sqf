/*
	fn_zDeleter
	Author: Sinbane
	Deletes zombies further than a distance from players
*/
private ["_deleteDist","_delCount","_playerPosArray","_index"];
//-----------------------------------

	_deleteDist = ["HVP_zDeleteDist"] call HVP_fnc_getSetting;

	while {true} do {
		sleep 10;
		_delCount = 0;
		
		//FILL ZOMBIE ARRAY
		HVP_zombieArray = [];
		{
			if (alive _x && (typeOf _x) in ((HVP_zombies)+(HVP_BossZombies))) then {
				HVP_zombieArray pushBack _x;
			};
		} forEach allUnits;
		
		//GET PLAYER POSITIONS
		_playerPosArray = [];
		{
			if (isPlayer _x && alive _x) then {
				_playerPosArray pushBack (getPos _x);
			};
		} forEach playableUnits;
		
		//DELETE ZOMBIES
		{
			for "_index" from 0 to ((count _playerPosArray)-1) do {
				if (_x distance (_playerPosArray select _index) > _deleteDist && alive _x) then {
					_delCount = _delCount + 1;
				};
			};
			if (_delCount isEqualTo (count _playerPosArray) then {
				deleteVehicle _x;
			};
		} forEach HVP_zombieArray;
	};

//-----------------------------------