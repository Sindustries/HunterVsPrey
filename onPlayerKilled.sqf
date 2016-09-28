/*
	HVP2 onDeath Script
	By Sinbane
	Removes all player gear and sets as spectator on death
*/
//-----------------------------------

if (lifeState player isEqualTo "INCAPACITATED" || lifeState player isEqualTo "INJURED" || lifeState player isEqualTo "HEALTHY") exitWith {};

("HUDAbilLayer" call BIS_fnc_rscLayer) cutText ["","PLAIN"];
("HUDBLOODLayer" call BIS_fnc_rscLayer) cutText ["","PLAIN"];

//-----------------------------------
//-REMOVE PLAYER GEAR
if (HVPGameType isEqualTo 1) then {
	private ["_weapon"];
	_weapon = currentWeapon player;
	player removeWeapon _weapon;
};

//-----------------------------------
//-SPAWN ZOMBEES

if (HVPZombieMode isEqualTo 1) then {
	[(getPos player)] remoteExec ["Z_fnc_setSpawn", 2];
	[(getPos player)] remoteExec ["Z_fnc_setSpawn", 2];
	[(getPos player)] remoteExec ["Z_fnc_setSpawn", 2];
};

//-----------------------------------

[
	[
		["YOU HAVE BEEN KILLED","<t align = 'center' shadow = '1' size = '1.0' font='PuristaBold'>%1</t><br/>", 25]
	]
] spawn BIS_fnc_typeText;
	
sleep 16;

if (HVPGameType isEqualTo 2) then {
	maintask setTaskState "Failed";
	["TaskFailed",["","Win The Games"]] call bis_fnc_showNotification;
};

//-----------------------------------
//-LAUNCH SPECTATOR MODE
/*
_this select 0 : The target player object
_this select 1 : Whitelisted sides, empty means all
_this select 2 : Whether AI can be viewed by the spectator
_this select 3 : Whether Free camera mode is available
_this select 4 : Whether 3th Person Perspective camera mode is available
_this select 5 : Whether to show Focus Info stats widget
_this select 6 : Whether or not to show camera buttons widget
_this select 7 : Whether to show controls helper widget
_this select 8 : Whether to show header widget
_this select 9 : Whether to show entities / locations lists
*/

if (HVPGameType isEqualTo 1) then {
	if (playerSide isEqualTo WEST || playerSide isEqualTo EAST) then {
		["Initialize", [player, [playerSide], false, true, true, true, true, true, false, false]] call BIS_fnc_EGSpectator;
	};
	if (playerSide isEqualTo RESISTANCE) then {
		["Initialize", [player, [WEST, EAST], false, true, true, true, true, true, false, false]] call BIS_fnc_EGSpectator;
	};
};
if (HVPGameType isEqualTo 2) then {
	["Initialize", [player, [WEST, EAST, RESISTANCE], false, true, true, true, true, true, false, false]] call BIS_fnc_EGSpectator;
};
if (HVPGameType isEqualTo 3) then {
	["Initialize", [player, [WEST, EAST], false, true, true, true, true, true, false, false]] call BIS_fnc_EGSpectator;
};

"dynamicBlur" ppEffectEnable false;

//-----------------------------------