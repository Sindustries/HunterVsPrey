
	HVP_phaseClockUpdate = {
		if (HVPPhaseType isEqualTo 1) then {
			uiNameSpace getVariable "HVP_HUD_PhaseTitle" ctrlSetText format["#%1 - %2",HVP_phase_num,HVP_clockDisplay];
		} else {
			uiNameSpace getVariable "HVP_HUD_PhaseTitle" ctrlSetText format["%1",HVP_clockDisplay];
		};	
	};

	private ["_time","_display"];
	_time = _this select 0;
	
	if (HVP_phase_active isEqualTo "true") then {
		uiNameSpace getVariable "HVP_HUD_PhaseTitle" ctrlSetTextColor [1, 0, 0, 1];
	};
	if (HVP_phase_active isEqualTo "false") then {
		uiNameSpace getVariable "HVP_HUD_PhaseTitle" ctrlSetTextColor [0, 1, 0, 1];
	};	
	while {_time >= 0} do {
		if (HVPPhaseType isEqualTo 1) then {
			if (isServer) then {
				_time = _time - 1;
				HVP_clockDisplay = format["%1", [((_time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring];
				publicVariable "HVP_clockDisplay";
				[] remoteExec ["HVP_phaseClockUpdate", 0];
			};
		} else {
			if (HVP_phase_active isEqualTo "false") then {
				if (isServer) then {
					_time = _time - 1;
					HVP_clockDisplay = format["%1", [((_time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring];
					publicVariable "HVP_clockDisplay";
					[] remoteExec ["HVP_phaseClockUpdate", 0];
				};
			} else {
				_time = _time - 1;
				_display = format["%1", [((_time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring];
				uiNameSpace getVariable "HVP_HUD_PhaseTitle" ctrlSetText format["%1",_display];
			};
		};
		sleep 1;
	};
	if (HVPPhaseType isEqualTo 2) then {
		uiNameSpace getVariable "HVP_HUD_PhaseTitle" ctrlSetTextColor [1, 0, 0, 1];
	};
	HVP_phaseClockActive = 0;