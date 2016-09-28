/*
	fn_zSpawn
	Author: Sinbane
	Spawns zombies on a defined pos if a player gets too close to it
*/
private ["_playerPosArray","_zIndex","_index"];
//-----------------------------------

	while {true} do {
		sleep 20;	
		
		if (daytime < 6 && daytime >= 0 || daytime < 24 && daytime > 18 || fog >= 0.5 || overcast >= 0.7) then {
			_playerPosArray = [];
			{
				if (isPlayer _x && alive _x && side _x != sideLogic) then {
					if (HVPGameType isEqualTo 1 && side _x != EAST) then {
						_playerPosArray pushBack (getPos _x);
					};
					if (HVPGameType isEqualTo 2) then {
						_playerPosArray pushBack (getPos _x);
					};
					if (HVPGameType isEqualTo 3 && side _x != RESISTANCE) then {
						_playerPosArray pushBack (getPos _x);
					};
				};
			} forEach playableUnits;
			
			_zIndex = 0;
			{
				for "_index" from 0 to (count _playerPosArray) do {
					if (_x distance (_playerPosArray select _index) < 80 && (random 100) < HVP_zSpawnChance) then {
						[_x,HVP_zhordeSize] call z_fnc_spawnZombies;
						HVP_usedSpawnerArray pushback _x;
						HVP_spawnerArray deleteAt _zIndex;
					};
				};
				_zIndex = _zIndex + 1;
			} forEach HVP_spawnerArray;
		} else {
			_zIndex = 0;
			{
				for "_index" from 0 to (count HVP_usedSpawnerArray) do {
					HVP_spawnerArray pushback _x;
					HVP_usedSpawnerArray deleteAt _zIndex;
				};
				_zIndex = _zIndex + 1;
			} forEach HVP_usedSpawnerArray;
		};
	};

//-----------------------------------