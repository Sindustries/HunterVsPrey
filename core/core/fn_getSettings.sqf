/*
	fn_getSettings
	Author: Sinbane
	Grabs setting from mission config and declares them as missionNamespace variables
*/
private ["_cfg","_settings","_i","_paramName","_return"];
//-----------------------------------

_cfg = _this select 0;
_settings = [];

for "_i" from 0 to (count (missionConfigFile >> _cfg) - 1) do {
	_paramName = configName ((missionConfigFile >> _cfg) select _i);
	if (isArray (missionconfigfile >> _cfg >> _paramName)) then {
		_return = getArray(missionConfigFile >> _cfg >> _paramName);
	};
	if (isNumber (missionconfigfile >> _cfg >> _paramName)) then {
		_return = getNumber(missionConfigFile >> _cfg >> _paramName);
	};
	if (isText (missionconfigfile >> _cfg >> _paramName)) then {
		_return = getText(missionConfigFile >> _cfg >> _paramName);
	};
	_settings pushBack [_paramName,_return];
};
{
	missionNamespace setVariable [(_x select 0), (_x select 1), true];
} forEach _settings;

//-----------------------------------