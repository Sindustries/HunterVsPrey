/* 
	Red Team health regen
	Author: Sinbane
	Slowly heals the red team over time
*/
private ["_regenHP","_regenRate"];
//-----------------------------------
//-VARIABLES

_regenHP = 0.05;
_regenRate = 30;

//-----------------------------------
//-REGEN 

while {alive player} do {

	if (HVP_phase_active == "true" && (player distance2D HVP_phase_pos) <= HVP_phase_radius || HVP_phase_active == "false") then {
		if ((damage player) > 0) then {
			player setDamage ((damage player)-_regenHP);
		};
		if ((damage player) isEqualTo 0 && (player getVariable "SMS_bleedingRate") > 0) then {
			player setVariable ["SMS_bleedingRate", 0];
		};
	};
	sleep _regenRate;
};
	
//-----------------------------------