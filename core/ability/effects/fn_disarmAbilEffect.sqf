/*
	fn_disarm
	By Sinbane
	Disarms nearby enemies of their current weapon
*/
private ["_pos","_safePlayer","_holder"];
//-----------------------------------
//-EFFECT

_pos = _this select 0;
_safePlayer = _this select 1;

if (HVPGameType isEqualTo 2) then {
	if (player distance _pos <= 120 && player != _safePlayer) then {	
		_holder = createVehicle ["GroundWeaponHolder", [0,0,0], [], 0, "CAN_COLLIDE"];
		_holder setPos (getPos player);
		player action ["DropWeapon", _holder, currentWeapon player];
		titleText ["YOU'VE BEEN DISARMED!", "PLAIN DOWN", 0.6];
	};
};
if (HVPGameType isEqualTo 3) then {
	if (side _safePlayer isEqualTo playerSide) exitWith {};
	if (side _safePlayer isEqualTo WEST && playerSide isEqualTo EAST) exitWith {};
	if (side _safePlayer isEqualTo EAST && playerSide isEqualTo WEST) exitWith {};
	if (player distance _pos <= 120) then {
		_holder = createVehicle ["GroundWeaponHolder", [0,0,0], [], 0, "CAN_COLLIDE"];
		_holder setPos (getPos player);
		player action ["DropWeapon", _holder, currentWeapon player];
		titleText ["YOU'VE BEEN DISARMED!", "PLAIN DOWN", 0.6];
	};
};

//-----------------------------------