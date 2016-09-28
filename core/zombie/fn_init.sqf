#define LIFE_SETTINGS(TYPE,SETTING) TYPE(missionConfigFile >> "Life_Settings" >> SETTING);
/*
	HVP Zombie Spawner
	Author: Sinbane
	Grabs zombies from Ryans Zombie & Demon's mod and spawns them when called
*/
private ["_cfg","_i","_cfgName","_counter","_temp"];
//-----------------------------------
//-DON'T EDIT
["Z"] call HVP_fnc_getSettings;
HVP_maxZombies = ["HVP_maxZombies"] call HVP_fnc_getSetting;
HVP_zhordeSize = ["HVP_zhordeSize"] call HVP_fnc_getSetting;;
HVP_zSpawnChance = ["HVP_zSpawnChance"] call HVP_fnc_getSetting;;

HVP_spawnerArray = [];
HVP_usedSpawnerArray = [];
HVP_zombies = [];
HVP_zombieArray = [];
HVP_zombieCount = 0;
//-----------------------------------
//-GET ZOMBIES

_exclusions = ["RyanZombiePlayer1","RyanZombiePlayer2","RyanZombiePlayer3","RyanZombiePlayer4","RyanZombiePlayer5","RyanZombiePlayer6","RyanZombiePlayer7","RyanZombiePlayer8","RyanZombiePlayer9","RyanZombiePlayer10","RyanZombiePlayer11","RyanZombiePlayer12","RyanZombiePlayer13","RyanZombiePlayer14","RyanZombiePlayer15","RyanZombiePlayer16","RyanZombiePlayer17","RyanZombiePlayer18","RyanZombiePlayer19","RyanZombiePlayer20","RyanZombiePlayer21","RyanZombiePlayer22","RyanZombiePlayer23","RyanZombiePlayer24","RyanZombiePlayer25","RyanZombiePlayer26","RyanZombiePlayer27","RyanZombiePlayer28","RyanZombiePlayer29","RyanZombiePlayer30","RyanZombiePlayer31","RyanZombiePlayer32"];

_cfg = (configFile >> "CfgVehicles");
for "_i" from 0 to ((count _cfg)-1) do {
	if (isClass (_cfg select _i)) then {
		_cfgName = configName (_cfg select _i);			
		if (_cfgName isKindOf "Man" && (getNumber ((_cfg select _i) >> "scope") == 2) && (getText ((_cfg select _i) >> "faction") isEqualTo "Ryanzombiesfaction") && (!(_cfgName in _exclusions))) then {
			HVP_zombies pushBackUnique _cfgName;
		};
	};
};

//-SPAWN EACH ZOMBIE ONCE AND DELETE (TO CACHE)
_counter = (count HVP_zombies);
{
	_temp = createVehicle [_x,[0,0,0], [], 0, "NONE"];
	deleteVehicle _temp;
	_counter = _counter - 1;
	[_counter,(count HVP_zombies)] remoteExec ["HVP_fnc_updateProgressBar", 0];
} forEach HVP_zombies;

//-----------------------------------
//-LAUNCH FUNCS

[] spawn {
	waitUntil {sleep 1; HVP_phase_active isEqualTo "true"};
	[] spawn z_fnc_zMonitor;
	[] spawn z_fnc_zDeleter;
};

//-----------------------------------