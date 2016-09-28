/*
	HVP Vehicle Spawn Script
	By Sinbane
	Spawns a variety of vehicles around the first phase
*/
if (!isServer) exitWith {};
private ["_maxNumVeh","_carSel","_spawnPos","_posCheck","_car","_spawnCar","_markerName","_markerstr","_vehCreated","_cfg","_i","_cfgName","_carSel","_usedPosArray","_minDistSpawn","_distCheck","_errorCount","_counter"];
//-----------------------------------
//-VARIABLES

_maxNumVeh = _this select 0;
_vehCreated = 0;
_usedPosArray = [];
_minDistSpawn = ["vehicleCarMinDist"] call HVP_fnc_getSetting;

//-----------------------------------
//-VEHICLE ARRAYS

_carSel = [
"B_Quadbike_01_F",
"B_Truck_01_transport_F",
"B_Truck_01_covered_F",
"B_Truck_01_mover_F",
"B_LSV_01_unarmed_F",
"B_G_Offroad_01_F",
"B_CTRG_LSV_01_light_F",
"O_LSV_02_unarmed_F",
"O_Truck_02_covered_F",
"O_Truck_02_transport_F",
"O_Truck_03_transport_F",
"O_Truck_03_covered_F",
"O_Truck_03_device_F",
"O_G_Van_01_transport_F",
"O_G_Offroad_01_F",
"C_Offroad_01_repair_F",
"C_Hatchback_01_F",
"C_Hatchback_01_sport_F",
"C_Van_01_box_F",
"C_Kart_01_F",
"C_Kart_01_Fuel_F",
"C_Offroad_02_unarmed_F"
];

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
		
		_spawnPos = [HVP_pos,0,(HVPZoneSizeMax * 1.25),0.25,0,0,0] call BIS_fnc_findSafePos;
		_posCheck = [_spawnPos] call SIN_fnc_checkPos;
		_distCheck = [_spawnPos,_usedPosArray,_minDistSpawn] call SIN_fnc_checkDist;
		if (_posCheck && _distCheck) then {
			_spawncar = (selectRandom _carSel) createVehicle _spawnpos;			
			_spawncar allowDamage false;
			_spawncar setDir (random 360);
			_spawncar setfuel 0.2 + (random 0.5);
			clearMagazineCargoGlobal _spawncar;
			clearWeaponCargoGlobal _spawncar;
			clearItemCargoGlobal _spawncar;
			clearBackpackCargoGlobal _spawncar;
			_spawncar setVehicleAmmo 0;
		
			if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
				[_spawncar] call HVP_fnc_airdropLoot;
			};
			_spawncar allowDamage true;
			
			if (HVPZombieMode isEqualTo 1 && (random 100) < 75) then {
				[_spawnPos] spawn Z_fnc_setSpawn;
			};
			
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

//-----------------------------------