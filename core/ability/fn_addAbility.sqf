/*
	fn_progressBar.sqf
	Author: Sinbane
	Makes the progress visible and shows ability duration
*/
private ["_currentPhase","_abilRoll","_abilFound"];
//-----------------------------------
params [
	["_setAbil",""]
];
//-----------------------------------
//-WAIT TO ADD
switch (HVPPhaseType) do {
	case 1: {
		_currentPhase = HVP_phase_num;
		waitUntil {sleep 1; HVP_phase_num isEqualTo (_currentPhase + 1)};		
	};
	case 2: {
		if (HVP_phase_active isEqualTo "false") then {
			sleep (HVPPhaseTime * 0.5);
		} else {
			[HVPPhaseTime] spawn HVP_fnc_phaseClock;
			HVP_phaseClockActive = 1;
			waitUntil {HVP_phaseClockActive isEqualTo 0};
		};
	};
};
//-----------------------------------
if (HVPGameType isEqualTo 1) then {	
	{	
		if (_setAbil isEqualTo (_x select 0)) then {
			HVP_abilName = (_x select 1);
			systemChat format["%1",HVP_abilName];
			systemChat format["%1",(_x select 2)];
			if ((_x select 4) isEqualTo "true") then {
				HVP_Ability = [player,(_x select 0)] call BIS_fnc_addCommMenuItem;
			} else {
				uiNameSpace getVariable "HVP_HUD_AbilTitle" ctrlSetText format["%1",HVP_abilName];
				uiNameSpace getVariable "HVP_HUD_AbilTitle" ctrlSetTextColor [0, 1, 0, 1];
				//HVP_abilExec = (_x select 3);
				player setVariable ["AbilExec",(_x select 3),false];
				[] spawn HVP_fnc_useAbilityKey;
			};
		};
	} forEach HVP_AbilityList;
};
//-----------------------------------
if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {	
	_abilFound = false;
	while {!_abilFound} do {
		_abilRoll = selectRandom HVP_AbilityList;
		if ((_abilRoll select 5) isEqualTo "true") then {
			_abilFound = true;
			systemChat format["%1",(_abilRoll select 1)];
			systemChat format["%1",(_abilRoll select 2)];
			uiNameSpace getVariable "HVP_HUD_AbilTitle" ctrlSetText format["%1",(_abilRoll select 1)];
			uiNameSpace getVariable "HVP_HUD_AbilTitle" ctrlSetTextColor [0, 1, 0, 1];
			//HVP_abilExec = (_abilRoll select 3);
			player setVariable ["AbilExec",(_abilRoll select 3),false];
			[] spawn HVP_fnc_useAbilityKey;
		};
	};
};
//-----------------------------------