/*
	fn_showEventIcon
	Author: Sinbane
	Shows the event GUI icon for the event
*/
private ["_layer","_GUI"];
//-----------------------------------

_layer = _this select 0;
_GUI = _this select 1;

(_layer call BIS_fnc_rscLayer) cutRsc [_GUI,"PLAIN",-1,false];

//-----------------------------------