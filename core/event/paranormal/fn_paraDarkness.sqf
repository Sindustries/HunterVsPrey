/*
	HVP2 Darkness Spook
	Teleports player to a nearby location and removes NVG's temporarily
	By Sinbane
*/
private ["_pos"];
//-----------------------------------
//-TELEPORT PLAYER

_Pos = [(getpos Player),0,100,0,0,1,0] call BIS_fnc_findSafePos;
sleep 1+(random 6);
player setPos [_Pos select 0,_Pos select 1,0];
player setDir (random 360);

//-----------------------------------
//-MESS WITH PLAY NVG

for [{_i=0}, {_i<60}, {_i=_i+1}] do {
	
	_roll = (random 100);
	if (_roll >= 90) then {
		player action ["nvGogglesOff", player];
	};
	sleep 1;
};

//-----------------------------------