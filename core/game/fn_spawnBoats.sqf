/*
	HVP Boat Spawner
	Author: Sinbane
	Spawns boats around the coast (if coast exists)
*/
if (!isServer) exitWith {};
private ["_maxNumBoats","_boatsCreated","_usedPosArray","_boatSelection","_cfg","_i","_cfgName","_counter","_errorCount","_shorePos","_posCheck","_spawnPos","_grp","_monkey","_depth","_spawnBoat","_markerName","_markerStr"];
//-----------------------------------
//-VARIABLES

_maxNumBoats = _this select 0;
_boatsCreated = 0;
_usedPosArray = [];
_minDistSpawn = ["vehicleBoatMinDist"] call HVP_fnc_getSetting;

//-----------------------------------
//-VEHICLE ARRAYS

_boatSelection = [];	
_cfg = (configFile >> "CfgVehicles");
for "_i" from 0 to ((count _cfg)-1) do {
	if (isClass (_cfg select _i)) then {
		_cfgName = configName (_cfg select _i);			
		if (_cfgName isKindOf "Ship" && (getNumber ((_cfg select _i) >> "scope") == 2) && (getNumber ((_cfg select _i) >> "isUav")) == 0) then {
			_boatSelection pushBackUnique _cfgName;
		};
	};
};

//-----------------------------------
//-SPAWN BOATS

if (isServer) then {
	_counter = _maxNumBoats;
	_errorCount = 0;
	while {_boatsCreated < _maxNumBoats} do {
		
		_shorePos = [HVP_pos,0,HVPZoneSizeMax,0,0,9999,1] call BIS_fnc_findSafePos;
		_posCheck = [_shorePos] call SIN_fnc_checkPos;
		if (_posCheck) then {
			_spawnPos = [_shorePos,0,50,0,2,9999,0] call BIS_fnc_findSafePos;
			_posCheck = [_spawnPos] call SIN_fnc_checkPos;
			_distCheck = [_spawnPos,_usedPosArray,_minDistSpawn] call SIN_fnc_checkDist;
			if (_posCheck && _distCheck) then {
				_grp = createGroup WEST;
				_monkey = _grp createUnit ["B_crew_F",_spawnPos, [], 0, "FORM"];
				_monkey hideobjectglobal true;
				sleep 0.05;
				_depth = (getPosATL _monkey select 2);
				if (_depth >= 1) then {
					_spawnBoat = (selectRandom _boatSelection) createVehicle _spawnPos;
					_spawnBoat allowDamage false;
					_spawnBoat setDir (random 360);
					_spawnBoat setfuel 0.2 + (random 0.7);
					clearMagazineCargoGlobal _spawnBoat;
					clearWeaponCargoGlobal _spawnBoat;
					clearItemCargoGlobal _spawnBoat;
					clearBackpackCargoGlobal _spawnBoat;
					_spawnBoat setVehicleAmmo 0;
					_spawnBoat allowDamage true;
					
					if (HVPDebugMode == 1) then {
						_markername = format["boat%1",_boatsCreated];
						_markerstr = createMarker [str(_markername), getPos _spawnBoat];
						str(_markername) setMarkerShape "ICON";
						str(_markername) setMarkerType "respawn_naval";
						str(_markername) setMarkerSize [0.75, 0.75];
						str(_markername) setMarkerColor "ColorBlufor";
						str(_markername) setMarkerAlpha 0.8;
					};
					
					_usedPosArray pushBackUnique _spawnPos;
					_boatsCreated = _boatsCreated + 1;
				};
				sleep 0.05;
				deleteVehicle _monkey;
			} else {
				_errorCount = _errorCount + 1;
			};
		} else {
			_errorCount = _errorCount + 1;
		};
		_counter = _counter - 1;
		[_counter,_maxNumBoats] remoteExec ["HVP_fnc_updateProgressBar", 0];
		if (_errorCount >= _maxNumBoats) exitWith {};
	};
};

//-----------------------------------