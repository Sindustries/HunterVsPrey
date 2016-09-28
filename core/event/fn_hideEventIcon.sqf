/*
	fn_showEventIcon
	Author: Sinbane
	Shows the event GUI icon for the event
*/
private ["_layer"];
//-----------------------------------

_layer = _this select 0;

(_layer call BIS_fnc_rscLayer) cutText ["","PLAIN"];

//-----------------------------------