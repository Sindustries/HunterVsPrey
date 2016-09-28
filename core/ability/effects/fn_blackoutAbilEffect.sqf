/*
	HVP2 Blackout Ability Effect
	By Sinbane
	Turns off all lights in a radius around player and removes flashlights from enemy guns temporarily
*/
private ["_pos"];
//-----------------------------------
//-EFFECT

_pos = _this select 0;

{ 
	_x setHit ["light_1_hitpoint", 0.97];
	_x setHit ["light_2_hitpoint", 0.97];
	_x setHit ["light_3_hitpoint", 0.97];
	_x setHit ["light_4_hitpoint", 0.97];
} forEach nearestObjects [_pos, [ "Lamps_base_F", "PowerLines_base_F", "PowerLines_Small_base_F" ], 250];

if ((player distance _pos) < 250) then {
	if (side player == WEST || side player == RESISTANCE) then {
		player removePrimaryWeaponItem "acc_flashlight";
		titleText ["YOU'VE BEEN HIT BY BLACKOUT!", "PLAIN DOWN", 0.6];
		sleep 10+(random 10);
		player addPrimaryWeaponItem "acc_flashlight";	
	};
};