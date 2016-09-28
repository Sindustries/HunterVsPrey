/* 
	HVP2 Decoy Spook
	Spawns a decoy red team player
	By Sinbane
*/
private ["_posFound","_decoyPos","_posCheck","_decoy","_decoygroup","_wp"];
//-----------------------------------
//-SPAWN DECOY

_posFound = false;
while {!_posFound} do {
	_decoyPos = [(getpos Player),25,60,0,0,0,0] call BIS_fnc_findSafePos;
	_posCheck = [_decoyPos] call SIN_fnc_checkPos;
	if (_posCheck) then {
		_posFound = true;
	};
};

_decoygroup = createGroup east;
_decoygroup setBehaviour "CARELESS"; 
_decoy = _decoygroup createUnit ["O_spotter_F", [5,5,5], [], 0, "NONE"];
_decoy allowDamage false;
_decoy disableAI "Target";
removeUniform _decoy;
removeVest _decoy;
removeHeadgear _decoy;
removeBackpack _decoy;
removeAllWeapons _decoy;
removeAllAssignedItems _decoy;
_decoy addUniform "U_O_GhillieSuit";
sleep 0.1;
_decoy setPos [_decoyPos select 0,_decoyPos select 1,0];

//-----------------------------------
//-GIVE A RANDOM WAYPOINT
	
_posFound = false;
while {!_posFound} do {
	_decoyPos = [_decoyPos,80,250,0,0,0,0] call BIS_fnc_findSafePos;
	_posCheck = [_decoyPos] call SIN_fnc_checkPos;
	if (_posCheck) then {
		_posFound = true;
	};
};

_decoy doMove _decoyPos;

//-----------------------------------
//-MESS WITH PLAYER GUNLIGHT

[] spawn {
	private ["_roll"];
	for [{_i=0}, {_i<60}, {_i=_i+1}] do {
		_roll = (random 100);
		if (_roll >= 90) then {
			player action ["GunLightOff", player];
		};
		sleep 1;
	};
};
	
//-----------------------------------
//-DELETE DECOY
	
sleep 30 + (random 20);
deleteVehicle _decoy;

//-----------------------------------