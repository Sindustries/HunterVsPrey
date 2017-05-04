/*
	HVP Vehicle Spawn Script
	By Sinbane
	Spawns a variety of vehicles around the first phase
*/
if (!isServer) exitWith {};
private ["_maxNumVeh","_carSel","_spawnPos","_posCheck","_car","_spawnCar","_markerName","_markerstr","_vehCreated","_cfg","_i","_cfgName","_carSel","_usedPosArray","_minDistSpawn","_distCheck","_errorCount","_counter"];
//-----------------------------------
//-VARIABLES

_minDistSpawn = ["vehicleCarMinDist"] call HVP_fnc_getSetting;
_lootChance = ["vehicleCarLootChance"] call HVP_fnc_getSetting;
_maxNumVeh = 100;			//((HVPZoneSizeMax*2)/_minDistSpawn);
_vehCreated = 0;
_usedPosArray = [];
_carArray = [];

//-----------------------------------
//-VEHICLE ARRAYS

_carSel = [];
if (HVPGameType isEqualTo 1) then {
	_cfg = (configFile >> "CfgVehicles");
	for "_i" from 0 to ((count _cfg)-1) do {
		if (isClass (_cfg select _i)) then {
			_cfgName = configName (_cfg select _i);
			if (_cfgName isKindOf "Car" && (getNumber ((_cfg select _i) >> "scope") isEqualTo 2) && (getNumber ((_cfg select _i) >> "isUav")) isEqualTo 0 && (getText ((_cfg select _i) >> "faction")) isEqualTo "CIV_F") then {
				_carSel pushBackUnique _cfgName;
			};
		};
	};
};
if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
	_cfg = (configFile >> "CfgVehicles");
	for "_i" from 0 to ((count _cfg)-1) do {
		if (isClass (_cfg select _i)) then {
			_cfgName = configName (_cfg select _i);
			if (_cfgName isKindOf "Car" && (getNumber ((_cfg select _i) >> "scope") isEqualTo 2) && (getNumber ((_cfg select _i) >> "isUav")) isEqualTo 0) then {
				_carSel pushBackUnique _cfgName;
			};
		};
	};
};

//-----------------------------------
//-SPAWN CARS

if (isServer) then {
	_counter = _maxNumVeh;
	_errorCount = 0;
	while {_vehCreated < _maxNumVeh} do {

		_spawnPos = [HVP_pos,0,(HVPZoneSizeMax * 4),0.25] call SIN_fnc_findPos;
		_distCheck = [_spawnPos,_usedPosArray,_minDistSpawn] call SIN_fnc_checkDist;
		if (_distCheck) then {
			_spawncar = (selectRandom _carSel) createVehicle _spawnpos;
			_spawncar allowDamage false;
			_spawncar setDir (random 360);
			_spawncar setfuel 0.2 + (random 0.5);
			clearMagazineCargoGlobal _spawncar;
			clearWeaponCargoGlobal _spawncar;
			clearItemCargoGlobal _spawncar;
			clearBackpackCargoGlobal _spawncar;
			_spawncar setVehicleAmmo 0;
			_spawncar disableTIEquipment true;

			if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
				[_spawncar] call HVP_fnc_airdropLoot;
			};
			_spawncar setPos (getPos _spawncar);
			_spawncar allowDamage true;

			if (HVPZombieMode isEqualTo 1 && (random 100) < 75) then {
				[_spawnPos] spawn Z_fnc_setSpawn;
			};

			_spawncar addEventHandler ["HandleDamage", {
				[(_this select 0),(_this select 1),(_this select 2),(_this select 3),(_this select 4)] spawn {
					private ["_veh","_selectionName","_damage","_source","_projectile"];
					_veh = _this select 0;
					_selectionName = _this select 1;
					_damage = _this select 2;
					_source = _this select 3;
					_projectile = _this select 4;

					if (_projectile in HVP_mines) then {
						_damage = (damage _veh)+0;
					} else {
						_veh setHit [_selectionName,_damage];
					};
				};
			}];

			_carArray pushBack _spawncar;
			_spawncar enableSimulation false;

			if (HVPDebugMode isEqualTo 1) then {
				_markername = format["car%1",_vehCreated];
				_markerstr = createMarker [str(_markername), getPos _spawncar];
				str(_markername) setMarkerShape "ICON";
				str(_markername) setMarkerType "respawn_motor";
				str(_markername) setMarkerSize [0.75, 0.75];
				str(_markername) setMarkerColor "ColorBlufor";
				str(_markername) setMarkerAlpha 0.8;
			};

			_vehCreated = _vehCreated + 1;
			_usedPosArray pushBackUnique _spawnpos;
			sleep 0.01;
		} else {
			_errorCount = _errorCount + 1;
		};
		_counter = _counter - 1;
		[_counter,_maxNumVeh] remoteExec ["HVP_fnc_updateProgressBar", 0];
		if (_errorCount >= _maxNumVeh) exitWith {};
	};
};

{
	_x enableSimulation true;
} forEach _carArray;

//-----------------------------------