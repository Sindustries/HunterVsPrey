/*
	HVP Drop Pod Event
	Author: Sinbane
	Spawns a Taru Pod that plummets to the ground, killing it's occupants
*/
private ["_pos","_posFound","_posCheck","_pod","_light","_ai","_man","_index","_crater","_fire","_alarm","_sparks1","_sparks2"];
//-----------------------------------
//-POS

_pos = _this select 0;

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
_fire = createVehicle ["test_EmptyObjectForFireBig", (getPos _pod),[], 0, "NONE"];
_fire attachTo [_pod, [0,0,0.7]];

[_pod] spawn HVP_fnc_heliCrashLoot;

//-----------------------------------
//-CREATE OCCUPANTS

for "_ai" from 0 to floor(random 11) do {
	_man = (createGroup civilian) createUnit ["C_Soldier_VR_F", [5,5,5], [], 0, "NONE"];
	_man setcaptive true;
	_man setskill 0;
	_man disableAI "TARGET";
	_man disableAI "AUTOTARGET";
	_man moveInCargo _pod;
	if ((random 100) < 50) then {
		_man allowDamage false;
	};
	[_man] spawn {
		private "_man";
		_man = _this select 0;
		waitUntil {vehicle _man isEqualTo _man || !alive _man};
		sleep (random 3);
		_man setDamage 1;
	};
};

//-----------------------------------
//- WAIT UNTIL CRASH 

waitUntil {isTouchingGround _pod};
//[_pod,["vehicle_collision",150]] remoteExec ["say", 0];
[_pod,"vehicle_collision"] remoteExec ["say", 0];
_pod setDamage 0.97; // test_EmptyObjectForSmoke // test_EmptyObjectForFireBig
{deleteVehicle _x;} forEach (_fire getVariable ["effects", []]);
deleteVehicle _fire;

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
	sleep 180+(random 300);
	deleteVehicle _alarm;
	_pod allowDamage true;
	_pod setDamage 1;
	sleep (random 300);
	{deleteVehicle _x;} forEach (_fire getVariable ["effects", []]);
	deleteVehicle _fire;
};

if (HVPZombieMode isEqualTo 1) then {
	[(getPos _pod)] spawn Z_fnc_setSpawn;
	[(getPos _pod)] spawn Z_fnc_setSpawn;
};

sleep 6;
{
	_x allowDamage true;
	_x action ["Eject", _pod];
} forEach crew _pod;

//-----------------------------------