/*
	Turns a handgun into a non-lethal weapon that sets the target unconscious
*/
//-----------------------------------

if (playerSide isEqualTo EAST) then {

	HVP_redGun = {
		private "_currentPhase";
		if (HVPPhaseType == 1) then {
			_currentPhase = HVP_phase_num;
			waitUntil {sleep 1; HVP_phase_num == (_currentPhase + 1)};
		};
		if (HVPPhaseType == 2) then {
			if (HVP_phase_active == "false") then {
				sleep (HVPPhaseTime * 0.5);
			} else {
				sleep HVPPhaseTime;
			};
		};
		player addMagazine ["16Rnd_9x21_red_Mag", 1];
	};

	player addEventHandler
	[
		"Fired",
		{
			_unit = _this select 0;
			_weapon = _this select 1;
			if (_weapon in HVP_redGuns) then {
				[] spawn HVP_redGun;
			};
		}
	];
};

//-----------------------------------