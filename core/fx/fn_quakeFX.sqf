/*
	Quake FX
	Author: Sinbane
	Makes the screen shake simulating an earthquake
*/
//-----------------------------------

private ["_pos","_radius"];
_pos = _this select 0;
_radius = _this select 1;
if (player distance _pos <= _radius) then {
	enableCamShake true;
	addCamShake [8, 16, 25];
	playsound "Earthquake_01";
	player forceWalk true;
	sleep 7;
	player forceWalk false;
} else {
	enableCamShake true;
	addCamShake [10, 16, 4];
	playsound "Earthquake_01";
};
	
//-----------------------------------