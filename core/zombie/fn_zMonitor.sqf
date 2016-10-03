/*
	fn_zMonitor
	Author: Sinbane
	Monitors players distance to spawners and spawns zombies if they get close enough
*/
private ["_playerPosArray","_zIndex","_index"];
//-----------------------------------

	while {true} do {
		sleep 10;	
		
		if (HVP_phase_active isEqualTo "true") then {
			if (sunOrMoon isEqualTo 0 || fog >= 0.5 || overcast >= 0.7) then {
				_playerPosArray = [];
				{
					if (isPlayer _x && alive _x && side _x != sideLogic) then {
						if (HVPGameType isEqualTo 1 && side _x != EAST) then {
							_playerPosArray pushBack [_x,(getPos _x)];
						};
						if (HVPGameType isEqualTo 2) then {
							_playerPosArray pushBack [_x,(getPos _x)];
						};
						if (HVPGameType isEqualTo 3 && side _x != RESISTANCE) then {
							_playerPosArray pushBack [_x,(getPos _x)];
						};
					};
				} forEach playableUnits;
				
				_zIndex = 0;
				{
					for "_index" from 0 to ((count _playerPosArray)-1) do {
						if (_x distance ((_playerPosArray select _index) select 1) < 80 && (random 100) < HVP_zSpawnChance) then {
							[_x,HVP_zhordeSize] remoteExec ["z_fnc_spawnZombies", ((_playerPosArray select _index) select 0)];
							HVP_usedSpawnerArray pushback _x;
							HVP_spawnerArray deleteAt _zIndex;
						};
					};
					_zIndex = _zIndex + 1;
				} forEach HVP_spawnerArray;
			} else {
				_zIndex = 0;
				{
					for "_index" from 0 to ((count HVP_usedSpawnerArray)-1) do {
						HVP_spawnerArray pushback _x;
						HVP_usedSpawnerArray deleteAt _zIndex;
					};
					_zIndex = _zIndex + 1;
				} forEach HVP_usedSpawnerArray;
			};
		};
	};

//-----------------------------------