/*
	HVP Heli Crash Event
	Author: Sinbane
	Spawns a random helicopter that flys into the zone and crashes, spawning loot crates around it
*/
private ["_helicrash_pos","_heliSelection","_cfg","_cfgName","_spawnPos","_eventHeli","_eventheligroup","_pilot","_wp","_counter","_posFound","_lootPos","_loot"];
//-----------------------------------
//-GET HELI TYPES

_heliSelection = _this select 0;
_helicrash_pos = _this select 1;

//-----------------------------------
//-GET POS

_spawnPos = [HVP_phase_pos,(HVP_phase_radius + 1500),(HVP_phase_radius + 3000),0,1,0,0] call SIN_fnc_findPos;

//-----------------------------------
//-CREATE HELI

_eventHeli = createVehicle [(selectRandom _heliSelection), [(_spawnPos select 0),(_spawnPos select 1),30+(random 100)],[], 0, "FLY"];
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
	[(getPos _eventHeli)] spawn Z_fnc_setSpawn;
};
if ((random 100) < 90) then {
	HVPRadioActiveObjects pushBackUnique [(getPos _eventHeli),30];
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