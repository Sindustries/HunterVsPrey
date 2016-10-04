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
		waitUntil {sleep 10; (count HVP_zombieArray > 0)};
		_delCount = 0;
		
		_playerPosArray = [];
		{
			if (isPlayer _x && alive _x) then {
				_playerPosArray pushBack (getPos _x);
			};
		} forEach playableUnits;
		
		{
			for "_index" from 0 to ((count _playerPosArray)-1) do {
				if (_x distance (_playerPosArray select _index) > _deleteDist && alive _x) then {
					_delCount = _delCount + 1;
				};
			};
			for "_index" from 0 to ((count HVP_zombieArray)-1) do {
				if (_delCount isEqualTo (count _playerPosArray)) then {
					deleteVehicle _x;
					HVP_zombieArray deleteAt _index;
					publicVariable "HVP_zombieArray";
				};
				if (!alive _x) then {
					HVP_zombieArray deleteAt _index;
					publicVariable "HVP_zombieArray";
				};
			};
		};
	};

//-----------------------------------