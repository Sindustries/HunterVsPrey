/*
	HVP Helicopter Spawn V3
	Author: Sinbane
	Spawns players in a team helicopter
*/
private ["_side","_cfg","_i","_cfgName","_heliSelection","_scenarios","_scenario","_posFound","_posCheck","_heliSpawnPos","_heliLandPos","_heli","_pilot","_light","_helipad","_heligroup","_heliEndPos"];
//-----------------------------------

_side = _this select 0;

//-----------------------------------
_heliSelection = [];
_scenarios = [
"Land",
"Explode",
"Parachute"
];

//-----------------------------------
//-FILL HELI ARRAY FROM CONFIG

if (HVPGameType isEqualTo 1) then {
	_cfg = (configFile >> "CfgVehicles");
	for "_i" from 0 to ((count _cfg)-1) do {
		if (isClass (_cfg select _i)) then {
			_cfgName = configName (_cfg select _i);			
			if (_cfgName isKindOf "Helicopter" && (getNumber ((_cfg select _i) >> "scope") == 2) && (getNumber ((_cfg select _i) >> "isUav")) == 0 && (getNumber ((_cfg select _i) >> "transportSoldier") >= 4)) then {
				_heliSelection pushBackUnique _cfgName;
			};
		};
	};
};
if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
	_cfg = (configFile >> "CfgVehicles");
	for "_i" from 0 to ((count _cfg)-1) do {
		if (isClass (_cfg select _i)) then {
			_cfgName = configName (_cfg select _i);			
			if (_cfgName isKindOf "Helicopter" && (getNumber ((_cfg select _i) >> "scope") == 2) && (getNumber ((_cfg select _i) >> "isUav")) == 0 && (getNumber ((_cfg select _i) >> "transportSoldier") >= 1)) then {
				_heliSelection pushBackUnique _cfgName;
			};
		};
	};
};

//-----------------------------------
//-FIND A SPAWN LOCATION FOR HELI

_posFound = false;
while {!_posFound} do {
	_heliSpawnPos = [HVP_phase_pos,(HVP_phase_radius * 1.25),(HVP_phase_radius * 1.66),0,1,0,0] call BIS_fnc_findSafePos;
	_posCheck = [_heliSpawnPos] call SIN_fnc_checkPos;
	if (_posCheck) then {
		_posFound = true;
	};
};

//-----------------------------------
//-CREATE A LANDING ZONE

_posFound = false;
while {!_posFound} do {
	_heliLandPos = [HVP_phase_pos,0,HVP_phase_radius,10,0,0.25,0] call BIS_fnc_findSafePos;
	_posCheck = [_heliLandPos] call SIN_fnc_checkPos;
	if (_posCheck) then {
		_posFound = true;
		_helipad = createVehicle ["Land_HelipadEmpty_F", _heliLandPos, [], 0, "NONE"];
	};
};

//-----------------------------------
//-CREATE HELI AND PILOT, MOVE TO LANDING ZONE

_heli = createVehicle [(selectRandom _heliSelection), [(_heliSpawnPos select 0),(_heliSpawnPos select 1),200],[], 0, "FLY"];
clearItemCargoGlobal _heli;
clearMagazineCargoGlobal _heli;
clearBackpackCargoGlobal _heli;
clearWeaponCargoGlobal _heli;
_heli flyInHeight 100+(random 50);
_heli setDir ((getPos _heli) getDir _heliLandPos);
	
_heligroup = createGroup _side; 
_pilot = _heligroup createUnit ["B_Helipilot_F", [5,5,5], [], 0, "NONE"];
_pilot setcaptive true;
_pilot setskill 0;
_pilot disableAI "TARGET";
_pilot disableAI "AUTOTARGET";
_heligroup setBehaviour "CARELESS"; 
_heligroup setCombatMode "BLUE"; 	
_heligroup allowfleeing 0;
_heli lock true;
_heli allowDamage false;
_pilot allowDamage false;
_pilot assignAsDriver _heli;
 
_pilot moveindriver _heli;	
_pilot doMove _heliLandPos;
_heligroup setSpeedMode "FULL";

[_heli] spawn {
	_heli = _this select 0;
	while {_heli isEqualTo _heli && alive _heli} do {
		player action ["lightOn", _heli];
		sleep 0.01;
	};
};
	
//-----------------------------------
//-MOVE PLAYERS INTO CHOPPER

if (HVPGameType isEqualTo 1) then {
	{
		if (isPlayer _x && side _x isEqualTo _side) then {
			if (HVPSpawnType isEqualTo 0 && (_x getVariable "HVP_playerSpawn") isEqualTo "Heli" || HVPSpawnType isEqualTo 3) then {
				[_x] remoteExec ["ace_hearing_fnc_putInEarplugs", _x];
				_x assignAsCargo _heli;
				_x moveInCargo _heli;
				_x setVariable ["HVP_spawned", true, true];
			};
		};
	} forEach allUnits;
};
if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
	[player] call ace_hearing_fnc_putInEarplugs;
	player assignAsCargo _heli;
	player moveInCargo _heli;
	player setVariable ["HVP_spawned", true, true];
};

//-----------------------------------
//-CHOOSE SCENARIO

_scenario = selectRandom _scenarios;

//-----------------------------------
//-LAND HELI, MOVE PLAYERS OUT

if (_scenario isEqualTo "Land") then {

	waitUntil {_heli distance2D _helipad < 100 && unitReady _pilot};

	_heli land "GET OUT";
	waitUntil {isTouchingGround _heli && (velocityModelSpace _heli select 2) >= 0};

	{
		if (isPlayer _x) then {
			doGetOut _x;
			[_x] call ace_hearing_fnc_removeEarplugs;
			_x removeItem "ACE_earplugs";
		};
	} forEach crew _heli;

	waitUntil {(count crew _heli) isEqualTo 1};
	sleep 3;
};

//-----------------------------------
//-OR EXPLODE.. OR KICK OUT MIDAIR..

if (_scenario isEqualTo "Explode" || _scenario isEqualTo "Parachute") then {
	private "_saveMe";
	_saveMe = {
		private ["_unit","_pack","_class","_magazines","_weapons","_items"];
		_unit = _this select 0;
		if (!isNull (unitBackpack _unit) && (backpack _unit) != "b_parachute") then {
			_pack	   = unitBackpack _unit;
			_class	   = typeOf _pack;
			_magazines = getMagazineCargo _pack;
			_weapons   = getWeaponCargo _pack;
			_items	   = getItemCargo _pack;

			removeBackpack _unit;
			_unit addBackpack "b_parachute";
			private "_packHolder";
			_packHolder = createVehicle ["groundWeaponHolder", [0,0,0], [], 0, "can_collide"];
			_packHolder addBackpackCargoGlobal [_class, 1];
			waitUntil {animationState _unit == "HaloFreeFall_non"};
			_packHolder attachTo [_unit,[-0.12,-0.02,-.74],"pelvis"]; 
			_packHolder setVectorDirAndUp [[0,-1,-0.05],[0,0,-1]];
			waitUntil {(getPosATL _unit select 2) <= 100};
			[_unit,["OpenParachute",_unit]] remoteExec ["action", _unit];
			waitUntil {animationState _unit == "para_pilot"};
			_packHolder attachTo [vehicle _unit,[-0.07,0.67,-0.13],"pelvis"]; 
			_packHolder setVectorDirAndUp [[0,-0.2,-1],[0,1,0]];
			waitUntil {(getPos _unit select 2) < 1 || isTouchingGround _unit};		
			detach _packHolder;
			deleteVehicle _packHolder;
			_unit addBackpack _class;
			clearAllItemsFromBackpack _unit;

			for "_i" from 0 to (count (_magazines select 0) - 1) do {
				(unitBackpack _unit) addMagazineCargoGlobal [(_magazines select 0) select _i,(_magazines select 1) select _i]; //return the magazines
			};
			for "_i" from 0 to (count (_weapons select 0) - 1) do {
				(unitBackpack _unit) addWeaponCargoGlobal [(_weapons select 0) select _i,(_weapons select 1) select _i]; //return the weapons
			};
			for "_i" from 0 to (count (_items select 0) - 1) do {
				(unitBackpack _unit) addItemCargoGlobal [(_items select 0) select _i,(_items select 1) select _i]; //return the items
			};
			[_unit] call ace_hearing_fnc_removeEarplugs;
			_unit removeItem "ACE_earplugs";
		} else {
			_unit addBackpack "b_parachute";
			waitUntil {(getPosATL _unit select 2) <= 100};
			[_unit,["OpenParachute",_unit]] remoteExec ["action", _unit];
			waitUntil {animationState _unit == "para_pilot"};
			waitUntil {(getPos _unit select 2) < 1 || isTouchingGround _unit};
			[_unit] call ace_hearing_fnc_removeEarplugs;
			_unit removeItem "ACE_earplugs";
		};
		
	};
	
	waitUntil {_heli distance2D _helipad < 50+(random 250)};
	
	if (_scenario isEqualTo "Explode") then {
		_heli setDamage 0.97;
		_heli allowDamage true;
		_pilot setDamage 1;
	};
	
	sleep 4;
	
	if (_scenario isEqualTo "Parachute") then {
		waitUntil {(speed _heli) < 3};
		sleep 2;
	};
	
	{
		if (isPlayer _x) then {
			[_x] spawn _saveMe;
			_x action ["Eject", _heli];
		};
	} forEach crew _heli;
	
	if (_scenario isEqualTo "Parachute") then {
		waitUntil {(count crew _heli) isEqualTo 1};	
	};
};

//-----------------------------------
//-GET POS TO SEND HELI

deleteVehicle _helipad;

if (_scenario isEqualTo "Land" || _scenario isEqualTo "Parachute" || _scenario isEqualTo "FastRope") then {

	_posFound = false;
	while {!_posFound} do {
		_heliEndPos = [HVP_phase_pos,(HVPZoneSizeMax * 3),(HVPZoneSizeMax * 5),0,1,0,0] call BIS_fnc_findSafePos;
		_posCheck = [_heliEndPos] call SIN_fnc_checkPos;
		if (_posCheck) then {
			_posFound = true;
			_pilot doMove _heliEndPos;		
		};
	};

	waitUntil {_heli distance2D _heliLandPos > (HVPZoneSizeMax * 3)};

	deleteVehicle _heli;
	deleteVehicle _pilot;
};

//-----------------------------------