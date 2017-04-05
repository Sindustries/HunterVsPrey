/*
	fn_zCamo
	Author: Sinbane
	Allows player to camo themselves with dead zombie remains to become "invisible" to other zombies
*/
//-----------------------------------

private ["_time","_display"];

_time = 300+floor(random 300);

//-----------------------------------

player playMove "ainvpknlmstpslaywrfldnon_medic";

sleep 6;

HVP_zCamoApplied = true;

("HUDzCamoLayer" call BIS_fnc_rscLayer) cutRsc ["HVPHUDcamoTimer","PLAIN",-1,false];

while {_time > 0} do {
	_time = _time - 1;
	player setCaptive true;
	_display = format["%1", [((_time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring];
	uiNameSpace getVariable "HVPHUD_camoTimer" ctrlSetText format["%1",_display];

	if (_time > 60) then {
		uiNameSpace getVariable "HVPHUD_camoTimer" ctrlSetTextColor [0, 1, 0, 1];
	} else {
		uiNameSpace getVariable "HVPHUD_camoTimer" ctrlSetTextColor [1, 0, 0, 1];
	};

	sleep 1;
};

player setCaptive false;
HVP_zCamoApplied = false;
("HUDzCamoLayer" call BIS_fnc_rscLayer) cutText ["","PLAIN"];

//-----------------------------------