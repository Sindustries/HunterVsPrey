/*
	fn_updateHP
	Author: Sinbane
	Updates the HP bar
*/
//-----------------------------------
while {alive player} do {
	uiNameSpace getVariable "HPBarProgress" progressSetPosition (1 - (damage player));
	sleep 0.5;
};
//-----------------------------------