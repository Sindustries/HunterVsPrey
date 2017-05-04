/*
	fn_zCamo
	Author: Sinbane
	Allows player to camo themselves with dead zombie remains to become "invisible" to other zombies
*/
//-----------------------------------

private ["_time","_display"];

_time = 300+floor(random 300);

//-----------------------------------

player playMove "ainvpknlmstpslaywnondnon_medic";

sleep 6;

if ((player getVariable ["z_CamoApplied",false]) isEqualTo false) then {
	player setVariable ["Z_CamoApplied",true];
	z_Camo_time = _time;

	("HUDzCamoLayer" call BIS_fnc_rscLayer) cutRsc ["HVPHUDcamoTimer","PLAIN",-1,false];

	while {z_Camo_time > 0} do {
		z_Camo_time = z_Camo_time - 1;
		player setCaptive true;
		_display = format["%1", [((z_Camo_time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring];
		uiNameSpace getVariable "HVPHUD_camoTimer" ctrlSetText format["%1",_display];

		if (z_Camo_time > 60) then {
			uiNameSpace getVariable "HVPHUD_camoTimer" ctrlSetTextColor [0, 1, 0, 1];
		} else {
			uiNameSpace getVariable "HVPHUD_camoTimer" ctrlSetTextColor [1, 0, 0, 1];
		};

		sleep 1;
	};

	player setCaptive false;
	player setVariable ["Z_CamoApplied",false];
	("HUDzCamoLayer" call BIS_fnc_rscLayer) cutText ["","PLAIN"];
} else {
	if (_time > z_Camo_time) then {
		z_Camo_time = _time;
	};
};

//-----------------------------------