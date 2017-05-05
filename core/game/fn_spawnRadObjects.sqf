/*
	HVP Radioactive Object Spawn Script
	By Sinbane
	Spawns a variety of radioactive objects and areas around the map
*/
if (!isServer) exitWith {};
private [];
//-----------------------------------
//-VARIABLES

_minDistSpawn = ["radObjMinDist"] call HVP_fnc_getSetting;
_radChance = ["radObjRadChance"] call HVP_fnc_getSetting;
_minDistLocation = 0.1;
_maxNumObj = 100;
_maxNumObjLoc = 30;
_objCreated = 0;
_usedPosArray = [];
HVPRadioActiveObjects = [];
HVPRadioActiveLocations = [];

_message = {
	_msg = format["LOADING RADIOACTIVE ZONE %1/%2",RAD_locNum,RAD_noLocs];
	cutText [_msg, "BLACK FADED", 999];
};

//-----------------------------------
//-OBJECT ARRAYS

_radObjCars = [
"Land_Wreck_BMP2_F",
"Land_Wreck_BRDM2_F",
"Land_Wreck_HMMWV_F",
"Land_Wreck_Skodovka_F",
"Land_Wreck_Truck_F",
"Land_Wreck_Car2_F",
"Land_Wreck_Car_F",
"Land_Wreck_Car3_F",
"Land_Wreck_Hunter_F",
"Land_Wreck_Offroad_F",
"Land_Wreck_Offroad2_F",
"Land_Wreck_UAZ_F",
"Land_Wreck_Ural_F",
"Land_Wreck_Truck_dropside_F",
"Land_UWreck_MV22_F",
"Land_Wreck_Slammer_F",
"Land_Wreck_Slammer_hull_F",
"Land_Wreck_T72_hull_F"
];

_radObjAir = [
"Land_Wreck_Heli_Attack_02_F",
"Land_UWreck_Heli_Attack_02_F",
"Land_Wreck_Plane_Transport_01_F",
"Land_HistoricalPlaneWreck_01_F",
"Land_HistoricalPlaneWreck_03_F",
"Land_HistoricalPlaneWreck_02_rear_F",
"Land_HistoricalPlaneWreck_02_front_F",
"Land_HistoricalPlaneWreck_02_wing_left_F",
"Land_HistoricalPlaneWreck_02_wing_right_F",
"Land_HistoricalPlaneDebris_01_F",
"Land_HistoricalPlaneDebris_02_F",
"Land_HistoricalPlaneDebris_03_F",
"Land_HistoricalPlaneDebris_04_F"
];

_radObjArray = (_radObjCars+_radObjAir);

//-----------------------------------
//-SPAWN OBJECTS (INSIDE LOCATIONS)

if (isServer) then {
	private ["_objPos","_add","_dir"];
	RAD_noLocs = 1;
	RAD_locNum = 0;
	{
		if ((_x select 0) distance2D HVP_pos < (HVPZoneSizeMax*2)) then {
			HVPRadioActiveLocations pushBack [(_x select 0),((_x select 1) select 0)];
			RAD_noLocs = RAD_noLocs + 1;
			publicVariable "RAD_noLocs";
		};
	} forEach HVP_mapLocations;

	{
		if ((_x select 0) distance2D HVP_pos < (HVPZoneSizeMax*2)) then {
			RAD_locNum = RAD_locNum + 1;
			publicVariable "RAD_locNum";
			_message remoteExec ["bis_fnc_call", 0];
			_maxNumObjLoc = (((_x select 1) select 0)/5);
			_counter = _maxNumObjLoc;
			_errorCount = 0;
			_objCreated = 0;
			while {_objCreated < _maxNumObjLoc} do {
				_roadFound = false;
				_add = 5;
				while {!_roadFound} do {
					_spawnPos = [(_x select 0),0,((_x select 1) select 0),0.2] call SIN_fnc_findPos;
					_nearRoads = _spawnPos nearRoads _add;
					if (count _nearRoads > 0) then {
						_roadFound = true;
						_road = (_nearRoads select 0);
						_connectedRoads = roadsConnectedTo _road;
						_dir = [_road, (_connectedRoads select 0)] call BIS_fnc_DirTo;
						_objPos = (getPos _road);
					} else {
						_add = _add + 5;
					};
					if (_add >= ((_x select 1) select 0)) then {
						_roadFound = true;
						_spawnPos = [(_x select 0),0,((_x select 1) select 0),0.2] call SIN_fnc_findPos;
						_dir = (random 360);
					};
				};

				_spawnPos = [(_x select 0),0,((_x select 1) select 0),0.2] call SIN_fnc_findPos;
				_distCheck = [_spawnPos,_usedPosArray,_minDistLocation] call SIN_fnc_checkDist;
				if (_distCheck) then {
					_obj = (selectRandom _radObjCars) createVehicle _objPos;
					_obj allowDamage false;
					_obj setDir (_dir+(random 75)-(random 75));
					_obj setPos (getPos _obj);
					_obj allowDamage true;

					_size = (getNumber (configfile >> "CfgVehicles" >> (typeOf _obj) >> "mapSize"));
					if ((random 100) < _radChance) then {
						HVPRadioActiveObjects pushBackUnique [_spawnPos,(_size*3)];
					};

					_objCreated = _objCreated + 1;
					_usedPosArray pushBackUnique _objPos;
					sleep 0.01;
				} else {
					_errorCount = _errorCount + 1;
				};
				_counter = _counter - 1;
				[_counter,_maxNumObjLoc] remoteExec ["HVP_fnc_updateProgressBar", 0];
				if (_errorCount >= _maxNumObjLoc) exitWith {};
			};
		};
	} forEach HVP_mapLocations;
};

//-----------------------------------
//-SPAWN OBJECTS (OUTSIDE LOCATIONS)

if (isServer) then {
	RAD_locNum = RAD_locNum + 1;
	publicVariable "RAD_locNum";
	_message remoteExec ["bis_fnc_call", 0];
	_counter = _maxNumObj;
	_errorCount = 0;
	_objCreated = 0;
	while {_objCreated < _maxNumObj} do {

		_spawnPos = [HVP_pos,0,(HVPZoneSizeMax * 4),0.1,0,0,0] call SIN_fnc_findPos;
		_distCheck = [_spawnPos,_usedPosArray,_minDistSpawn] call SIN_fnc_checkDist;
		if (_distCheck) then {
			_obj = (selectRandom _radObjArray) createVehicle _spawnpos;
			_obj allowDamage false;
			_obj setDir (random 360);
			_obj setPos (getPos _obj);
			_obj allowDamage true;

			if (HVPZombieMode isEqualTo 1 && (random 100) < 90) then {
				[_spawnPos] spawn Z_fnc_setSpawn;
			};

			_size = (getNumber (configfile >> "CfgVehicles" >> (typeOf _obj) >> "mapSize"));
			HVPRadioActiveObjects pushBackUnique [_spawnPos,(_size*3)];

			_objCreated = _objCreated + 1;
			_usedPosArray pushBackUnique _spawnpos;
			sleep 0.01;
		} else {
			_errorCount = _errorCount + 1;
		};
		_counter = _counter - 1;
		[_counter,_maxNumObj] remoteExec ["HVP_fnc_updateProgressBar", 0];
		if (_errorCount >= _maxNumObj) exitWith {};
	};
};

//-----------------------------------
//-MAP MARKERS
IF (HVPDebugMode isEqualTo 1) then {
	{
		_aMarkername = format["radZone%1",(_x select 0)];
		_radMarker = createMarker [_aMarkername, (_x select 0)];
		_radMarker setMarkerShape "ELLIPSE";
		_radMarker setMarkerBrush "Solid";
		_radMarker setMarkerColor "ColorOrange";
		_radMarker setMarkerSize [((_x select 1)/2),((_x select 1)/2)];
		_radMarker setMarkerAlpha 0.66;
	} forEach HVPRadioActiveObjects;
};
//-----------------------------------
publicVariable "HVPRadioActiveObjects";
publicVariable "HVPRadioActiveLocations";
RAD_locNum = nil;
RAD_noLocs = nil;
publicVariable "RAD_locNum";
publicVariable "RAD_noLocs";
//-----------------------------------