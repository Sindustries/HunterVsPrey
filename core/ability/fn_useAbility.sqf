/*
	fn_useAbility.sqf
	Author: Sinbane
	Executes the players ability
*/
private "_exec";
//-----------------------------------

_exec = player getVariable "AbilExec";
(findDisplay 46) displayRemoveEventHandler ["KeyDown", SIN_abilityDEH];
uiNameSpace getVariable "HVP_HUD_AbilTitle" ctrlSetTextColor [1, 0, 0, 1];
call _exec;
if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
	uiNameSpace getVariable "HVP_HUD_AbilTitle" ctrlSetText "WAITING";
	uiNameSpace getVariable "HVP_HUD_AbilTitle" ctrlSetTextColor [0, 0, 1, 1];
};

//-----------------------------------