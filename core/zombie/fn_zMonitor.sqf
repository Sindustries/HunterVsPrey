/*
	fn_zMonitor
	Author: Sinbane
	Monitors player distance to spawners and spawns zombies if they get close enough
*/
private ["_zIndex","_index","_toDelete"];
//-----------------------------------

	while {true} do {
		sleep 10;	
		
		if (HVP_phase_active isEqualTo "true" && alive player) then {
			if (sunOrMoon isEqualTo 0 || fog >= 0.5 || overcast >= 0.7) then {
				{
					if (_x distance player < 80 && (random 100) < HVP_zSpawnChance && !(_x in HVP_usedSpawnerArray)) then {
						[_x,HVP_zhordeSize] call z_fnc_spawnZombies;
						HVP_usedSpawnerArray pushBack _x;
					};
				} forEach HVP_spawnerArray;
				publicVariable "HVP_usedSpawnerArray";
			} else {
				if (isServer) then {
					HVP_usedSpawnerArray = [];
					publicVariable "HVP_usedSpawnerArray";
				};
			};
		};
		if ((count HVP_zombieArrayClient) > 0) then {
			//Sun Damage
			if (sunOrMoon isEqualTo 1 && fog < 0.5 && overcast < 0.7) then {
				{
					_x setDamage ((damage _x) + (random 0.1));
				} forEach HVP_zombieArrayClient;
			};
			//remove dead or deleted Z's from client array
			_toDelete = [];
			{
				if (!alive _x || isNull _x) then {
					_toDelete pushBack _x;
				};				
			} forEach HVP_zombieArrayClient;
			HVP_zombieArrayClient = HVP_zombieArrayClient - _toDelete;
		};
	};

//-----------------------------------