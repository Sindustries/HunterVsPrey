/*
	HVP Supply Drop Event
	Author: Sinbane
	Spawns a random helicopter that flys into the zone and delivers a loot crate
*/
private ["_type","_dropPos","_heliSpawnPos","_heliSelection","_cfg","_i","_cfgName","_eventHeli","_pilot","_eventheligroup","_drop","_light","_smoke","_posFound","_heliEndPos","_posCheck","_parachute","_markerName","_markerStr"];
//-----------------------------------
//-PARAMS

_type = _this select 0;
_dropPos = _this select 1;
_heliSpawnPos = _this select 2;
_heliSelection = [];

//-----------------------------------
//-GET HELI TYPE

if (_type isEqualTo "event") then {
	_cfg = (configFile >> "CfgVehicles");
	for "_i" from 0 to ((count _cfg)-1) do {
		if (isClass (_cfg select _i)) then {
			_cfgName = configName (_cfg select _i);			
			if (_cfgName isKindOf "Helicopter" && (getNumber ((_cfg select _i) >> "scope") == 2) && (getNumber ((_cfg select _i) >> "isUav")) == 0 && (getNumber ((_cfg select _i) >> "slingLoadMaxCargoMass") >= 500)) then {
				_heliSelection pushBackUnique _cfgName;
			};
		};
	};
};
if (_type isEqualTo "ability") then {
	_cfg = (configFile >> "CfgVehicles");
	for "_i" from 0 to ((count _cfg)-1) do {
		if (isClass (_cfg select _i)) then {
			_cfgName = configName (_cfg select _i);			
			if (_cfgName isKindOf "VTOL_Base_F" && (getNumber ((_cfg select _i) >> "scope") == 2) && (getNumber ((_cfg select _i) >> "isUav")) == 0) then {
				_heliSelection pushBackUnique _cfgName;
			};
		};
	};
};

//-----------------------------------
//-CREATE HELI

_eventHeli = createVehicle [(selectRandom _heliSelection), [(_heliSpawnPos select 0),(_heliSpawnPos select 1),200],[], 0, "FLY"];
clearItemCargoGlobal _eventHeli;
clearMagazineCargoGlobal _eventHeli;
clearBackpackCargoGlobal _eventHeli;
clearWeaponCargoGlobal _eventHeli;
_eventHeli flyInHeight 100+(random 50);
_eventHeli setDir ((getPos _eventHeli) getDir _dropPos);
	
_eventheligroup = createGroup west; 
_pilot = _eventheligroup createUnit ["B_Helipilot_F", [5,5,5], [], 0, "NONE"];
_pilot setcaptive true;
_pilot setskill 0;
_pilot disableAI "TARGET";
_pilot disableAI "AUTOTARGET";
_eventheligroup setBehaviour "CARELESS"; 
_eventheligroup setCombatMode "BLUE"; 	
_eventheligroup allowfleeing 0;
_eventHeli lock true;
_eventHeli allowDamage false;
_pilot allowDamage false;
_pilot assignAsDriver _eventHeli;
 
_pilot moveindriver _eventHeli;	
_pilot doMove _dropPos;
_eventheligroup setSpeedMode "FULL";

if (_type isEqualTo "event") then {
	_drop = createVehicle ["B_supplyCrate_F", _heliSpawnPos,[], 0, "CAN COLLIDE"];
	_eventHeli setSlingLoad _drop;
	_drop allowDamage false;
	clearItemCargoGlobal _drop;
	clearMagazineCargoGlobal _drop;
	clearBackpackCargoGlobal _drop;
	clearWeaponCargoGlobal _drop;
};

//-----------------------------------
//-WAIT UNTIL NEAR DROP POS

if (_type isEqualTo "event") then {
	waitUntil {(_eventHeli distance2D _dropPos) < 250 || !alive _eventHeli};
};
if (_type isEqualTo "ability") then {
	_smoke = createVehicle ["SmokeShellGreen", _dropPos, [], 0, "NONE"];
};

if (_type isEqualTo "event") then {
	waitUntil {(_eventHeli distance2D _dropPos) < 100 && unitReady _pilot || !alive _eventHeli};
	if (!alive _eventHeli) exitWith {};
	{ropeCut [_x, 0.5]} forEach (ropes _eventHeli);
};
if (_type isEqualTo "ability") then {
	waitUntil {(getPos _eventHeli) distance2D _dropPos < 25 && unitReady _pilot};
	if (!alive _eventHeli) exitWith {};
	_drop = createVehicle ["B_supplyCrate_F", [(getPosATL _eventHeli select 0),(getPosATL _eventHeli select 1),(getPosATL _eventHeli select 2)-10],[], 0, "CAN COLLIDE"];
	_light = createVehicle ["Land_Flush_Light_green_F", (getPos _drop),[], 0, "NONE"];
	_light attachTo [_drop, [0,0,0.45]];
	_drop allowDamage false;
	clearItemCargoGlobal _drop;
	clearMagazineCargoGlobal _drop;
	clearBackpackCargoGlobal _drop;
	clearWeaponCargoGlobal _drop;
};

[_drop] spawn HVP_fnc_airdropLoot;

//-----------------------------------
//-DROP THE CRATE

if ((getPosATL _drop select 2) > 10) then {	//B_Parachute_02_F
	_light = createVehicle ["Land_Flush_Light_green_F", (getPos _drop),[], 0, "NONE"];
	_light attachTo [_drop, [0,0,0.45]];
	_parachute = createVehicle ["NonSteerable_Parachute_F",[0,0,50], [], 0, "FLY"];
	sleep 0.5;
	_parachute setPosATL [(getPosATL _drop select 0), (getPosATL _drop select 1), (getPosATL _drop select 2)];
	_drop attachTo [_parachute,[0,0,0.5]];
};

if (daytime < 7 || daytime > 17) then {
	_smoke = "F_20mm_Red" createvehicle ((_drop) ModelToWorld [0,0,200]); 
	_smoke setVelocity [0,0,-10];
} else {
	_smoke = createVehicle ["SmokeShellGreen", (getPosATL _drop), [], 0, "NONE"];
	_smoke attachTo [_drop, [0,0,0.15]];
};

//-----------------------------------
//-FIND END LOCATION FOR HELI
	
_posFound = false;
while {!_posFound} do {
	_heliEndPos = [HVP_phase_pos,(HVP_phase_radius * 2),(HVP_phase_radius * 4),0,1,0,0] call BIS_fnc_findSafePos;
	_posCheck = [_heliEndPos] call SIN_fnc_checkPos;
	if (_posCheck) then {
		_posFound = true;
		_pilot doMove _heliEndPos;		
	};
};
	
[_pilot,_eventHeli,_dropPos] spawn {
	_pilot = _this select 0;
	_eventHeli = _this select 1;
	_dropPos = _this select 2;
	waitUntil {_eventHeli distance _dropPos > (HVP_phase_radius * 1.9) || !alive _eventHeli};
	deleteVehicle _eventHeli;
	deleteVehicle _pilot;
};

//-----------------------------------
//-CREATE MARKER

[_drop] spawn {
	private ["_drop","_markerName","_markerStr"];
	_drop = _this select 0;
	waitUntil {(getPos _drop select 2) < 10};
	_markername = format["AirDropElip%1",(getPos _drop)];
	_markerstr = createMarker [str(_markername), getPos _drop];
	str(_markername) setMarkerShape "ELLIPSE";
	//str(_markername) setMarkerText "AIRDROP";
	str(_markername) setMarkerSize [40, 40];
	str(_markername) setMarkerColor "ColorIndependent";
	str(_markername) setMarkerAlpha 0.7;

	_markername = format["AirDropIco%1",(getPos _drop)];
	_markerstr = createMarker [str(_markername), getPos _drop];
	str(_markername) setMarkerShape "ICON";
	str(_markername) setMarkerType "respawn_para";
	str(_markername) setMarkerSize [0.75, 0.75];
	str(_markername) setMarkerColor "ColorIndependent";
	str(_markername) setMarkerAlpha 0.8;
};

[_drop] spawn {
	private ["_drop"];
	_drop = _this select 0;
	
	waitUntil {(velocityModelSpace _drop select 2) >= 0 && (getPos _drop select 2) < 1};	
	_drop allowDamage true;
};

//-----------------------------------