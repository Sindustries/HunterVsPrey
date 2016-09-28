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
			if ((random 100) < 50) then {
				_damage = 0.05+(random 0.05);
				player setDamage ((damage player)+_damage);
				[player, _damage] spawn SMS_fnc_setBleeding;
			};
			if ((random 100) < 5) then {
				[player, 12] call SMS_fnc_setUnconscious;
			};
		};		
	};

	sleep 5 + (random 5);

//-----------------------------------
};