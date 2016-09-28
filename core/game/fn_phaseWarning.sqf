/*
	HVP2 Phase Warnings
	By Sinbane
	Displays updates to phase status
*/
private ["_msg","_txt","_task1","_currentPhase"];
//-----------------------------------

waitUntil {sleep 1; HVP_phase_num isEqualTo 1};

[] spawn {
	waitUntil {HVP_phase_num >= 1};
	while {alive player} do {
		sleep 150;
		systemChat "Don't forget to check your map for the zone locations!";
	};
};

//-----------------------------------

if (HVPPhaseType isEqualTo 2) exitWith {
	[[["THE PHASE HAS BEEN MARKED ON THE MAP","<t align = 'center' shadow = '1' size = '0.6' font='PuristaBold'>%1</t><br/>", 25]]] spawn BIS_fnc_typeText;
	
	waitUntil {sleep 1; HVP_phase_active isEqualTo "true"};
	[[["THE PHASE IS NOW IN EFFECT","<t align = 'center' shadow = '1' size = '0.6' font='PuristaBold'>%1</t><br/>", 25]]] spawn BIS_fnc_typeText;
};

//-BEGIN LOOP
while {alive player} do {
//-----------------------------------

	if (HVPPhaseSpacing isEqualTo 1 || HVPPhaseSpacing isEqualTo 2 && HVP_phase_num isEqualTo 1) then {
		_msg = format ["PHASE %1 HAS BEEN MARKED ON THE MAP",HVP_phase_num];
		[[[_msg,"<t align = 'center' shadow = '1' size = '0.6' font='PuristaBold'>%1</t><br/>", 25]]] spawn BIS_fnc_typeText;
	};	
	
	sleep 10;
	
	_txt = format ["Survive Phase %1",HVP_Phase_Num];
	_task1 = player createSimpleTask ["SINtask1"];
	_task1 setSimpleTaskDescription ["Stay inside the red circle",_txt,""];
	_task1 setTaskState "Assigned";
	player setCurrentTask _task1;
	["TaskAssigned",["",_txt]] call bis_fnc_showNotification;

	waitUntil {sleep 1; HVP_phase_active isEqualTo "true" || !alive player};
	
	if (!alive player) exitWith {
		_task1 setTaskState "Failed";
		["TaskFailed",["",_txt]] call bis_fnc_showNotification;
	};

	_msg = format ["PHASE %1 IS NOW IN EFFECT",HVP_phase_num];
	[[[_msg,"<t align = 'center' shadow = '1' size = '0.6' font='PuristaBold'>%1</t><br/>", 25]]] spawn BIS_fnc_typeText;
		
	_currentPhase = HVP_phase_num;
	waitUntil {sleep 1; HVP_phase_num isEqualTo (_currentPhase + 1) || !alive player};

	if (!alive player) exitWith {
		_task1 setTaskState "Failed";
		["TaskFailed",["",_txt]] call bis_fnc_showNotification;
	};

	_task1 setTaskState "Succeeded";
	["TaskSucceeded",["",_txt]] call bis_fnc_showNotification;

//-----------------------------------
//-STOP LOOP
};