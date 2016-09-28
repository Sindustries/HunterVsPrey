/*
	HVP Heli Crash Event
	Author: Sinbane
	Spawns a random helicopter that flys into the zone and crashes, spawning loot crates around it
*/
private ["_helicrash_pos","_heliSelection","_cfg","_cfgName","_eventHeli","_eventheligroup","_pilot","_wp","_counter","_posFound","_lootPos","_loot"];
//-----------------------------------
//-POS

_helicrash_pos = _this select 0;

//-----------------------------------
//-GET HELI TYPE

_heliSelection = [];

_cfg = (configFile >> "CfgVehicles");
for "_i" from 0 to ((count _cfg)-1) do {
	if (isClass (_cfg select _i)) then {
		_cfgName = configName (_cfg select _i);			
		if (_cfgName isKindOf "helicopter" && (getNumber ((_cfg select _i) >> "scope") == 2) && (getNumber ((_cfg select _i) >> "isUav")) == 0) then {
			_heliSelection pushBackUnique _cfgName;
		};
	};
};

//-----------------------------------
//-CREATE HELI

_eventHeli = createVehicle [(selectRandom _heliSelection), [(_helicrash_pos select 0)+1000+(random (HVPZoneSizeMax * 2))-(random (HVPZoneSizeMax * 2)), (_helicrash_pos select 1)+1000+(random (HVPZoneSizeMax * 2))-(random (HVPZoneSizeMax * 2)), 30+(random 100)],[], 0, "FLY"];
clearItemCargoGlobal _eventHeli;
clearMagazineCargoGlobal _eventHeli;
clearBackpackCargoGlobal _eventHeli;
clearWeaponCargoGlobal _eventHeli;
_eventHeli flyInHeight 50+(random 50);
_eventHeli setDir ((getPos _eventHeli) getDir _helicrash_pos);

_eventheligroup = createGroup west; 
_pilot = _eventheligroup createUnit ["B_Helipilot_F", [5,5,5], [], 0, "NONE"];
_eventheligroup setBehaviour "SAFE";
_pilot setcaptive true;
_pilot allowfleeing 0;
_pilot disableAI "Target"; 
_eventHeli lock true;
_eventHeli allowDamage false;
_pilot allowDamage false;
 
_pilot moveindriver _eventHeli;

//-----------------------------------
//-MOVE TO CRASH SITE

_pilot doMove _helicrash_pos;
_eventheligroup setSpeedMode "FULL";

//-----------------------------------
//-CRASH THE BUGGA

waitUntil {(_eventHeli distance2D _helicrash_pos < 200)};

_pilot setDamage 1;
_eventHeli setDamage 0.97;

//-----------------------------------
//-WAIT UNTIL CRASHED -> SPAWN CRATES

waitUntil {isTouchingGround _eventHeli};

if (HVPZombieMode isEqualTo 1) then {
	[(getPos _eventHeli)] spawn Z_fnc_setZSpawn;
};

for "_counter" from 1 to 2 do {
	_posFound = false;
	while {!_posFound} do {
		_lootPos = [(getPos _eventHeli),0.5,10,0,0,0,0] call BIS_fnc_findSafePos;
		_posCheck = [_lootPos] call SIN_fnc_checkPos;
		if (_posCheck) then {
			_posFound = true;
			_loot = "B_CargoNet_01_ammo_F" createVehicle [_lootPos select 0,_lootPos select 1,0];
			_loot setDir (random 360);
			_loot allowDamage false;
			[_loot] call HVP_fnc_helicrashLoot;
			_loot allowDamage true;
		};
	};
};

_eventHeli setDamage 1;

//-----------------------------------