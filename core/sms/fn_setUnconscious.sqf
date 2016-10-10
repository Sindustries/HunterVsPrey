/*
	fn_setUnconscious
	Author: Sinbane
	Set's a unit unconcious for a max duration
*/
if (vehicle player != player) exitWith {};
//-----------------------------------

	private ["_unit","_duration"];

	_unit = _this select 0;
	_duration = _this select 1;
	if (_unit != player) exitWith {};
	if (vehicle _unit != _unit) exitWith {};
	if ((_unit getVariable "SMS_isUnconscious") isEqualTo true) exitWith {};
	
	_unit setVariable ["SMS_isUnconscious", true, true];	
	_unit setUnconscious true;
	_unit setCaptive true;
	//cutText ["", "BLACK OUT", 0.1, true];
	enableEnvironment false;	
	sleep (10 + (random _duration));	
	enableEnvironment true;
	//cutText ["", "BLACK IN", 3, true];
	_unit setCaptive false;
	_unit setUnconscious false;
	_unit setVariable ["SMS_isUnconscious", false, true];

	if (primaryWeapon _unit isEqualTo "" && secondaryWeapon _unit isEqualTo "" && handgunWeapon _unit isEqualTo "") then {
		_unit addWeapon "hgun_P07_F";
		sleep 0.1;
		_unit removeWeapon "hgun_P07_F";
	};
	
//-----------------------------------