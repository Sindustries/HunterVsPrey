/*
	HVP2 Phase Manager V2
	By Sinbane
	Controls the game location and the decreasing play area
*/
private ["_sizeDrop","_shiftPos"];
//-----------------------------------
//-DEFINE STARTING VARIABLES - DO NOT EDIT

_sizeDrop = ["singlePhaseReduceSize"] call HVP_fnc_getSetting;
_shiftPos = ["singlePhaseShiftSize"] call HVP_fnc_getSetting;

HVP_phase_num = 0;
publicVariable "HVP_phase_num";
HVP_phase_pos = HVP_Pos;
publicVariable "HVP_phase_pos";
HVP_phase_active = "false";
publicVariable "HVP_phase_active";
HVP_phase_radius = HVPZoneSizeMax;
publicVariable "HVP_phase_radius";
HVP_phase_clock = HVPPhaseTime;
publicVariable "HVP_phase_clock";

HVP_timerMsg = {
	_time = _this select 0;
	if (_time > 1) then {
		_msg = format["PHASE %1 WILL BE IN EFFECT IN %2 MINUTES",HVP_phase_num,_time];
		titleText [_msg,"PLAIN DOWN",0.5];
	} else {
		_msg = format["PHASE %1 WILL BE IN EFFECT IN %2 MINUTE",HVP_phase_num,_time];
		titleText [_msg,"PLAIN DOWN",0.8];
	};
};

HVP_announcer = {
	_numAlive = {alive _x} count PlayableUnits;
	_bluAlive = {alive _x && side _x == WEST} count PlayableUnits;
	_redAlive = {alive _x && side _x == EAST} count PlayableUnits;
	_mercAlive = {alive _x && side _x == RESISTANCE} count PlayableUnits;

	_msg = format ["At the end of Phase %1, there are %2 players still alive.",HVP_phase_num,_numAlive];
	_msg remoteExec ["systemChat", 0];
};

sleep 30;

[_sizeDrop,_shiftPos] spawn HVP_fnc_phaseManager;
remoteExec ["HVP_fnc_deathLoop", 0];
remoteExec ["HVP_fnc_phaseWarning", 0];
//-----------------------------------