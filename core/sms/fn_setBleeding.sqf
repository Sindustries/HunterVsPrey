/*
	fn_setBleeding
	Author: Sinbane
	When a unit takes damage, bleeding is applied by this
	BLEEDING CAN AND WILL STACK UNTIL HEALED
*/
//-----------------------------------

	private ["_unit","_amount","_smallSplash","_largeSplash","_math"];

	_unit = _this select 0;
	_amount = _this select 1;

	if (_unit != player) exitWith {};

	_unit setVariable ["SMS_bleedingRate", ((_unit getVariable "SMS_bleedingRate") + _amount)];
	if ((_unit getVariable "SMS_bleedingRate") > SMS_bleedRateMax) then {
		_unit setVariable ["SMS_bleedingRate", SMS_bleedRateMax];
	};

	if ((_unit getVariable "SMS_bleeding") isEqualTo false) then {
		("HUDBLOODLayer" call BIS_fnc_rscLayer) cutRsc ["HVPHUD_blood","PLAIN",-1,false];
		_unit setVariable ["SMS_bleeding", true];

		while {alive _unit && (_unit getVariable "SMS_bleedingRate") > 0} do {

			_unit setVariable ["SMS_bloodLevel", (_unit getVariable "SMS_bloodLevel")-(_unit getVariable "SMS_bleedingRate")];

			_unit setBleedingRemaining 120;

			/*if ((damage _unit) > 0 && (damage _unit) < 0.6 && (random 100) < 33) then {
				_smallSplash = createSimpleObject ["a3\characters_f\data\slop_00.p3d", getPosWorld _unit];
				_smallSplash setDir random 360;
				_smallSplash setVectorUp surfaceNormal getPosWorld _smallSplash;
			};
			if ((damage _unit) >= 0.6 && (random 100) < 33) then {
				_largeSplash = createSimpleObject ["a3\characters_f\blood_splash.p3d", getPosWorld _unit];
				_largeSplash setDir random 360;
			};*/

			if (damage _unit < 0.2) then {
				_unit setDamage (damage _unit)+0.01;
			};

			if ((_unit getVariable "SMS_bloodLevel") < (SMS_maxBlood * SMS_passOutNum) && (_unit getVariable "SMS_isUnconscious") isEqualTo false) then {
				if ((random 100) < SMS_passOutChance) then {
					[_unit,8] call SMS_fnc_setUnconscious;
				};
			};
			if ((_unit getVariable "SMS_bloodLevel") < (SMS_maxBlood * SMS_bleedOutNum) && (_unit getVariable "SMS_isUnconscious") isEqualTo false) then {
				if ((random 100) < SMS_bleedoutChance) then {
					[_unit] call SMS_fnc_setBleedout;
				};
			};

			_math = ((SMS_maxBlood - (_unit getVariable "SMS_bloodLevel")) / SMS_maxBlood * 100);
			uiNameSpace getVariable "HVPHUDBloodcount" ctrlSetText format["%1%2",round(100 - _math),"%"];
			uiNameSpace getVariable "HVPHUDBloodcount" ctrlSetTextColor [1, 0, 0, 1];
			sleep SMS_bleedRate;
		};
	};

//-----------------------------------