/*
	HVP2 Skydive Spook
	By Sinbane
	Teleports player into the air temporarily
*/
private ["_pos"];
//-----------------------------------
//-TELEPORT PLAYER

_pos = [(getpos Player),25,60,0,0,0,0] call SIN_fnc_findPos;

player setCaptive true;
player allowDamage false;
player setPos [(_pos select 0),(_pos select 1),200+(random 100)];
player setDir (random 360);

waitUntil {(getPos player select 2) < 25};

player setPos [(_pos select 0),(_pos select 1),0];
sleep 1;
player allowDamage true;

sleep 10;
player setCaptive false;

//-----------------------------------