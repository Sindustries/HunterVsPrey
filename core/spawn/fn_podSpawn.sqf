/*
	HVP Drop Pod Spawn
	Author: Sinbane
	Spawns the player(s) in a Taru Pod that plummets to the ground
*/
private ["_pos","_posFound","_posCheck","_side","_pod","_light","_index","_crater","_fire","_alarm","_sparks1","_sparks2"];
//-----------------------------------
//-POS

_posFound = false;
while {!_posFound} do {
	_pos = [HVP_phase_pos,0,HVP_phase_radius,1,0,0.4,0] call BIS_fnc_findSafePos;
	_posCheck = [_pos] call SIN_fnc_checkPos;
	if (_posCheck) then {
		_posFound = true;
	};
};

//-----------------------------------
//-CREATE POD

_pod = createVehicle ["Land_Pod_Heli_Transport_04_covered_F", [(_pos select 0),(_pos select 1),(1500 + (random 1000))],[], 0, "NONE"];
_pod allowDamage false;
_pod lock true;
_pod setDir (random 360);
clearItemCargoGlobal _pod;
clearMagazineCargoGlobal _pod;
clearBackpackCargoGlobal _pod;
clearWeaponCargoGlobal _pod;
_light = createVehicle ["Land_Flush_Light_red_F", (getPos _pod),[], 0, "NONE"];
_light attachTo [_pod, [0,0,0.7]];

//-----------------------------------
//-MOVE PLAYERS INTO POD

_index = 2;

if (HVPGameType isEqualTo 1) then {
	_side = _this select 0;
	{
		if (isPlayer _x && side _x isEqualTo _side) then {
			sleep 1;
			_x moveInCargo [_pod, _index];
			_x allowDamage false;
			_x setVariable ["HVP_spawned", true, true];
			_index = _index + 1;
		};
	} forEach allUnits;
};

if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
	sleep 1;
	player moveInCargo [_pod, _index];
	player allowDamage false;
	player setVariable ["HVP_spawned", true, true];
};

//-----------------------------------
//- WAIT UNTIL CRASH 

waitUntil {isTouchingGround _pod};
[_pod,["vehicle_collision",350]] remoteExec ["say", 0];
_pod setDamage 0.97; // test_EmptyObjectForSmoke // test_EmptyObjectForFireBig
_crater = createVehicle ["CraterLong_small", (getPos _pod),[], 0, "NONE"];
_fire = createVehicle ["test_EmptyObjectForSmoke", (getPos _pod),[], 0, "NONE"];
_alarm = createSoundSource ["Sound_Alarm", (getPos _pod), [], 0];
_sparks1 = createSoundSource ["Sound_SparklesWreck1", (getPos _pod), [], 0];
_sparks2 = createSoundSource ["Sound_SparklesWreck2", (getPos _pod), [], 0];

_fire attachTo [_pod, [0,0,0.7]];
_alarm attachTo [_pod];
_sparks2 attachTo [_pod];
_sparks1 attachTo [_pod];

[_pod,_alarm,_sparks1,_sparks2,_fire] spawn {
	private ["_alarm","_sparks1","_sparks2","_fire"];
	_pod = _this select 0;
	_alarm = _this select 1;
	_sparks1 = _this select 2;
	_sparks2 = _this select 3;
	_fire = _this select 4;
	sleep 60+(random 60);
	deleteVehicle _alarm;
	_pod allowDamage true;
	_pod setDamage 1;
	sleep (random 120);
	{deleteVehicle _x;} forEach (_fire getVariable ["effects", []]);
	deleteVehicle _fire;
};	
sleep 6;
{
	_x allowDamage true;
	_x action ["Eject", _pod];
} forEach crew _pod;

//-----------------------------------