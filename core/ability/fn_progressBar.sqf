/*
	fn_progressBar.sqf
	Author: Sinbane
	Makes the progress visible and shows ability duration
*/
private ["_time","_counter"];
//-----------------------------------

("HUDProgressBar" call BIS_fnc_rscLayer) cutRsc ["HVPHUDProgressBar","PLAIN",-1,true];
uiNameSpace getVariable "PBarProgress" ctrlSetTextColor [0.2, 0.5, 0.9, 1];	
private ["_time","_counter","_timer"];
_time = _this select 0;
_counter = _time;
for "_timer" from 0 to _time do {
	[_counter,_time] call HVP_fnc_updateProgressBar;
	_counter = _counter - 1;
	sleep 1;
};
("HUDProgressBar" call BIS_fnc_rscLayer) cutText ["","PLAIN"];

//-----------------------------------