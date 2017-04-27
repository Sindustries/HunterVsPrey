/*
	HVP Zombie Spawner
	Author: Sinbane
	Grabs zombies from Ryans Zombie & Demon's mod and spawns them when called
*/
private ["_cfg","_i","_cfgName","_counter","_temp","_exclusions"];
//-----------------------------------
//-DON'T EDIT
["Z"] call HVP_fnc_getSettings;
HVP_maxZombies = ["HVP_maxZombies"] call HVP_fnc_getSetting;
HVP_zhordeSize = ["HVP_zhordeSize"] call HVP_fnc_getSetting;;
HVP_zSpawnChance = ["HVP_zSpawnChance"] call HVP_fnc_getSetting;
HVP_zBossChance = ["HVP_zBossChance"] call HVP_fnc_getSetting;

HVP_spawnerArray = [];
HVP_usedSpawnerArray = [];
HVP_zombies = [];
HVP_zombieArray = [];
HVP_zombieArrayClient = [];

player setVariable ["z_CamoApplied",false];

//-----------------------------------
//-GET ZOMBIES
if (isServer) then {

	_exclusions = ["RyanZombiePlayer1","RyanZombiePlayer2","RyanZombiePlayer3","RyanZombiePlayer4","RyanZombiePlayer5","RyanZombiePlayer6","RyanZombiePlayer7","RyanZombiePlayer8","RyanZombiePlayer9","RyanZombiePlayer10","RyanZombiePlayer11","RyanZombiePlayer12","RyanZombiePlayer13","RyanZombiePlayer14","RyanZombiePlayer15","RyanZombiePlayer16","RyanZombiePlayer17","RyanZombiePlayer18","RyanZombiePlayer19","RyanZombiePlayer20","RyanZombiePlayer21","RyanZombiePlayer22","RyanZombiePlayer23","RyanZombiePlayer24","RyanZombiePlayer25","RyanZombiePlayer26","RyanZombiePlayer27","RyanZombiePlayer28","RyanZombiePlayer29","RyanZombiePlayer30","RyanZombiePlayer31","RyanZombiePlayer32"];

	HVP_BossZombies = ["RyanZombieboss1","RyanZombieboss2","RyanZombieboss3","RyanZombieboss4","RyanZombieboss5","RyanZombieboss6","RyanZombieboss7","RyanZombieboss8","RyanZombieboss9","RyanZombieboss10","RyanZombieboss11","RyanZombieboss12","RyanZombieboss13","RyanZombieboss14","RyanZombieboss15","RyanZombieboss16","RyanZombieboss17","RyanZombieboss18","RyanZombieboss19","RyanZombieboss20","RyanZombieboss21","RyanZombieboss22","RyanZombieboss23","RyanZombieboss24","RyanZombieboss25","RyanZombieboss26","RyanZombieboss27","RyanZombieboss28","RyanZombieboss29","RyanZombieboss30","RyanZombieboss31","RyanZombieboss32"];

	_cfg = (configFile >> "CfgVehicles");
	for "_i" from 0 to ((count _cfg)-1) do {
		if (isClass (_cfg select _i)) then {
			_cfgName = configName (_cfg select _i);
			if (_cfgName isKindOf "Man" && (getNumber ((_cfg select _i) >> "scope") == 2) && (getText ((_cfg select _i) >> "faction") isEqualTo "Ryanzombiesfaction") && (!(_cfgName in _exclusions)) &&
			(!(_cfgName in HVP_BossZombies))) then {
				HVP_zombies pushBackUnique _cfgName;
			};
		};
	};

	publicVariable "HVP_BossZombies";
	publicVariable "HVP_zombies";

	//-SPAWN EACH ZOMBIE ONCE AND DELETE (TO CACHE)
	_counter = (count HVP_zombies);
	{
		_temp = createVehicle [_x,[0,0,0], [], 0, "NONE"];
		deleteVehicle _temp;
		_counter = _counter - 1;
		[_counter,(count HVP_zombies)] remoteExec ["HVP_fnc_updateProgressBar", 0];
	} forEach (HVP_zombies+HVP_BossZombies);
};
//-----------------------------------
//-LAUNCH FUNCS

[] spawn {
	waitUntil {sleep 1; HVP_phase_active isEqualTo "true"};
	[] spawn z_fnc_zMonitor;
	if (isServer) then {
		[] spawn z_fnc_zDeleter;
	};
};

//-----------------------------------
//-ZOMBIE CAMO ACTION

zCamo_action = [player addAction["Zombie Camouflage",z_fnc_zCamo,"",0,false,false,"",'
!isNull cursorObject && player distance cursorObject < 3.5 && (typeOf cursorObject) in ((HVP_zombies)+(HVP_BossZombies)) && !alive cursorObject && vehicle player isEqualTo player']];
// && (player getVariable ["z_CamoApplied",false]) isEqualTo false
//-----------------------------------