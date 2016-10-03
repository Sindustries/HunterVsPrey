/*
	fn_zMonitor
	Author: Sinbane
	Monitors player distance to spawners and spawns zombies if they get close enough
*/
private ["_playerPosArray","_zIndex","_index"];
//-----------------------------------

	while {true} do {
		sleep 10;	
		
		if (HVP_phase_active isEqualTo "true") then {
			if (sunOrMoon isEqualTo 0 || fog >= 0.5 || overcast >= 0.7) then {
				_zIndex = 0;
				{
					if (_x distance (getPos player) < 80 && (random 100) < HVP_zSpawnChance) then {
						[_x,HVP_zhordeSize] call z_fnc_spawnZombies;
						HVP_usedSpawnerArray pushback _x;
						HVP_spawnerArray deleteAt _zIndex;
						publicVariable "HVP_usedSpawnerArray";
						publicVariable "HVP_spawnerArray";
					};
					_zIndex = _zIndex + 1;
				} forEach HVP_spawnerArray;
			} else {
				if (isServer) then {
					_zIndex = 0;
					{
						for "_index" from 0 to ((count HVP_usedSpawnerArray)-1) do {
							HVP_spawnerArray pushback _x;
							HVP_usedSpawnerArray deleteAt _zIndex;
							publicVariable "HVP_usedSpawnerArray";
							publicVariable "HVP_spawnerArray";
						};
						_zIndex = _zIndex + 1;
					} forEach HVP_usedSpawnerArray;
				};
			};
		};
	};

//-----------------------------------