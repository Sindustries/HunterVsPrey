/*
	fn_hideLoot
	Author: Sinbane
	Hides loot greater than a radius around the player

*/
private ["_cacheCount"];
//-----------------------------------

_cacheCount = 0;

while {true} do {
	sleep 6;

	{
		if (isNil {_x getVariable "ltCached"}) then {
			_x setVariable ["ltCached", false];
		};
		if (player distance _x >= 200 && _x getVariable "ltCached" isEqualTo false) then {
			_x hideObject true;
			_x setVariable ["ltCached", true];
			_cacheCount = _cacheCount + 1;
		};
		if (player distance _x <= 60 && _x getVariable "ltCached" isEqualTo true) then {
			_x hideObject false;
			_x setVariable ["ltCached", false];
			_cacheCount = _cacheCount - 1;
		};
	} forEach Sinspawn_holders;
};

//-----------------------------------