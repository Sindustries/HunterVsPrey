/* 
	HVP2 Ghost Spook
	Spawns a ghost that says something creepy. Chance of red glow and red smoke.
	By Sinbane
*/
private ["_ghostPos","_ghostgroup","_bombRoll","_smoke","_glowRoll","_selection","_sfx"];
//-----------------------------------
//-SPAWN GHOST

_posFound = false;
while {!_posFound} do {
	_ghostPos = [(getpos Player),20,80,0,0,0,0] call BIS_fnc_findSafePos;
	_posCheck = [_ghostPos] call SIN_fnc_checkPos;
	if (_posCheck) then {
		_posFound = true;
	};
};

_ghostgroup = createGroup east; 
_ghost = _ghostgroup createUnit ["B_Helipilot_F", [5,5,5], [], 0, "NONE"];
_ghost allowDamage false;
_ghost setcaptive true;
_ghost allowfleeing 0;
_ghost disableAI "Target";
_ghost enableSimulation false;
removeUniform _ghost;
removeVest _ghost;
removeHeadgear _ghost;
removeBackpack _ghost;
removeAllWeapons _ghost;
removeAllAssignedItems _ghost;
_ghost addUniform "U_VirtualMan_F";
_ghost addVest "V_RebreatherIA";
_ghost additem "ACE_NVG_Wide";
_ghost assignitem "ACE_NVG_Wide";
[_ghost,true] remoteExec ["hideObject", 0];
_ghost setPos [_ghostPos select 0,_ghostPos select 1,0];

//-----------------------------------
//-ROLL FOR EFFECTS

_bombRoll = (random 100);
if (_bombRoll >= 50) then {
	_smoke = createVehicle ["SmokeShellRed", _ghostPos, [], 0, "NONE"];
	sleep 3;
};
	
_glowRoll = (random 100);
if (_glowRoll <= 33) then {
	[_ghost,_ghostpos] spawn {
		private ["_ghost","_ghostpos","_glow"];
		_ghost = _this select 0;
		_ghostpos = _this select 1;

		_glow = "#lightpoint" createVehicle _ghostpos;
		_glow setLightBrightness 0.2;
		_glow setLightAmbient [0.75, 0, 0];
		_glow setLightColor [0.75, 0, 0];
		_glow lightAttachObject [_ghost, [0,0,0]];

		sleep 30;

		deleteVehicle _glow;
	};
};

//-----------------------------------
//-LET THEM SPEAK
		
_selection = [
	"mockingbird",
	"demongirlsong",
	"spookambient",
	"evilLaugh",
	"apprehensive",
	"bats",
	"raptor1",
	"raptor2",
	"raptor3",
	"raptor4",
	"raptor5"
];
			
_sfx = selectRandom _selection;
_ghost say [_sfx, 160];

sleep 25 + (random 10);
_ghost enableSimulation true;
deleteVehicle _ghost;

//-----------------------------------