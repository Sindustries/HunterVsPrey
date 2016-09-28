/*
	fn_zDeleter
	Author: Sinbane
	Deletes zombies further than a distance from players
*/
private ["_deleteDist","_playerPosArray","_zIndex","_index"];
//-----------------------------------

	_deleteDist = ["HVP_zDeleteDist"] call HVP_fnc_getSetting;;

	while {true} do {
		sleep 20;
		waitUntil {sleep 20; (count HVP_zombieArray > 0)};
		
		_playerPosArray = [];
		{
			if (isPlayer _x && alive _x) then {
				_playerPosArray pushBack (getPos _x);
			};
		} forEach playableUnits;
		
		_zIndex = 0;
		{
			for "_index" from 0 to (count _playerPosArray) do {
				if (_x distance (_playerPosArray select _index) > _deleteDist && alive _x) then {
					deleteVehicle _x;
					HVP_zombieArray deleteAt _zIndex;
				};
				if (!alive _x) then {
					HVP_zombieArray deleteAt _zIndex;
				};
			};
			_zIndex = _zIndex + 1;
		} forEach HVP_zombieArray;
	};

//-----------------------------------