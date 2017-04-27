/*
	HVP2 Death Loop
	By Sinbane
	Punishes players outside of playable zone
*/
//-----------------------------------
//-OUTSIDE ZONE MESSAGE

[] spawn {
	waitUntil {HVP_phase_num >= 1};
	while {alive player} do {
		if (!alive player) exitWith {};
		waitUntil {sleep 2; (player distance2D HVP_phase_pos) > HVP_phase_radius && HVP_phase_active isEqualTo "true"};
		while {(player distance2D HVP_phase_pos) > HVP_phase_radius && alive player} do {
			titleText ["WARNING: YOU ARE OUTSIDE THE ZONE!", "PLAIN", 0.5];
			sleep 0.25;
		};
		titleText ["", "PLAIN", 0.01];
	};
};

//-----------------------------------
while {alive player} do {
//-----------------------------------

	waitUntil {sleep 1; HVP_phase_active isEqualTo "true"};

	if (side player != sideLogic && alive player) then {
		if ((player distance2D HVP_phase_pos) > HVP_phase_radius) then {
			if ((player getVariable ["SMS_bleeding",false]) isEqualTo false) then {
				[player,SMS_bleedRateMax] spawn SMS_fnc_setBleeding;
			};
			player setDamage ((damage player)+(HVP_phase_num/100));
		};
	};

	sleep 1;

//-----------------------------------
};