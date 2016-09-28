
	private ["_unit","_math","_bloodDisplay"];

	_unit = _this select 0;
	
	if (_unit != player) exitWith {};
	
	while {alive _unit} do {
	
		if ((_unit getVariable "SMS_bloodLevel") isEqualTo SMS_maxBlood) then {
			("HUDBLOODLayer" call BIS_fnc_rscLayer) cutText ["","PLAIN"];
		};
		waitUntil {sleep 3; (_unit getVariable "SMS_bleedingRate") isEqualTo 0 && (_unit getVariable "SMS_bloodLevel") < SMS_maxBlood};
		if ((_unit getVariable "SMS_bloodLevel") < SMS_maxBlood) then {
			_unit setVariable ["SMS_bloodLevel", ((_unit getVariable "SMS_bloodLevel")+ SMS_bloodRegen)];
			if ((_unit getVariable "SMS_bloodLevel") > SMS_maxBlood) then {
				_unit setVariable ["SMS_bloodLevel", SMS_maxBlood];
			};
		};
		_math = ((SMS_maxBlood - (_unit getVariable "SMS_bloodLevel")) / SMS_maxBlood * 100);
		_bloodDisplay = round(100 - _math);
		uiNameSpace getVariable "HVPHUDBloodcount" ctrlSetText format["%1%2",_bloodDisplay,"%"];
		uiNameSpace getVariable "HVPHUDBloodcount" ctrlSetTextColor [0, 1, 0, 1];
		sleep SMS_bloodRegenRate;
	};