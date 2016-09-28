/*
	fn_setBleedout
	Author: Sinbane
	Set's a unit unconcious until dead
*/
//-----------------------------------

	private ["_unit"];

	_unit = _this select 0;
	
	if ((_unit getVariable "SMS_isUnconscious") isEqualTo true) exitWith {};
	_unit setVariable ["SMS_isUnconscious", true, true];
	_unit setVariable ["SMS_inBleedout", true, true];
	
	_unit setUnconscious true;
	
	waitUntil {(_unit getVariable "SMS_bloodLevel") <= 0 || (_unit getVariable "SMS_bloodLevel") > (SMS_maxBlood * SMS_bleedOutNum) || !alive _unit};
	if ((_unit getVariable "SMS_bloodLevel") <= 0) exitWith {
		_unit setDamage 1;
	};
	if ((_unit getVariable "SMS_bloodLevel") > (SMS_maxBlood * SMS_bleedOutNum)) exitWith {
		_unit setVariable ["SMS_isUnconscious", false, true];
		_unit setVariable ["SMS_inBleedout", false, true];
		_unit setUnconscious false;
		if (primaryWeapon _unit isEqualTo "" && secondaryWeapon _unit isEqualTo "" && handgunWeapon _unit isEqualTo "") exitWith {
			_unit addWeapon "hgun_P07_F";
			sleep 0.1;
			_unit removeWeapon "hgun_P07_F";
		};
	};
	if (!alive _unit) exitWith {};