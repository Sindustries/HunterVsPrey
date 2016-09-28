/*
	HVP2 Teleport Spook
	By Sinbane
	Teleports player to a random nearby location & acts like game has restarted
*/
private ["_pos"];
//-----------------------------------
//-TELEPORT PLAYER

while {!_posFound} do {
	_pos = [(getpos Player),25,60,0,0,0,0] call BIS_fnc_findSafePos;
	_posCheck = [_pos] call SIN_fnc_checkPos;
	if (_posCheck) then {
		_posFound = true;
	};
};

cutText ["", "BLACK FADED", 999];
player enableSimulation false;
player setPos [_Pos select 0,_Pos select 1,0];
player setDir (random 360);
[player,true] remoteExec ["hideObject", 0];

systemChat format["Welcome to Dolphin's Quest, %1.",profileName];
systemChat "Please wait while the mission prepares.";

sleep 2;

[
	[
		["Welcome to Prey vs Hunter vs Dolphins","<t align = 'center' color='#F79727' shadow = '1' size = '1.0' font='PuristaBold'>%1</t><br/>", 10],
		["by Veltenbane","<t align = 'center' shadow = '1' size = '0.6'>%1</t>", 5]
	]
] spawn BIS_fnc_typeText;
	
sleep 10;
cutText ["", "BLACK IN", 5];
[player,false] remoteExec ["hideObject", 0];
player enableSimulation true;

//-----------------------------------