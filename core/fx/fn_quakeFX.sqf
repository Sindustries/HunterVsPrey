/*
	Quake FX
	Author: Sinbane
	Makes the screen shake simulating an earthquake
*/
//-----------------------------------

private ["_pos"];
_pos = _this select 0;
if (player distance _pos <= 500) then {
	enableCamShake true;
	addCamShake [8, 16, 25];
	playsound "Earthquake_01";
	player forceWalk true;
	sleep 7;
	player forceWalk false;
};
if (player distance _pos > 500) then {
	enableCamShake true;
	addCamShake [10, 16, 4];
	playsound "Earthquake_01";
};
	
//-----------------------------------