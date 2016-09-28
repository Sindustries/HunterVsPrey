/*
	fn_healthRegen
	Author: Sinbane
	Slowly heals the unit over time
*/
	
	private ["_regenHP","_regenRate","_abilTime"];

	_regenHP = _this select 0;
	_regenRate = _this select 1;
	_abilTime = _this select 2;
	
	while {_abilTime > 0} do {
		if (HVP_phase_active == "true" && (player distance HVP_phase_pos) <= HVP_phase_radius || HVP_phase_active == "false") then {
			if ((damage player) > 0) then {
				player setDamage ((damage player)-_regenHP);
			};
			if ((player getVariable "SMS_bleedingRate") > 0 && (damage player) isEqualTo 0) then {
				player setVariable ["SMS_bleedingRate", 0];
			};
		};
		_abilTime = (_abilTime - _regenRate);
		sleep _regenRate;
	};