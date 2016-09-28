
	private ["_pos","_posArray","_minDist","_distanceArray","_index","_numFails"];
	
	_pos = _this select 0;
	_posArray = _this select 1;
	_minDist = _this select 2;
	_distanceArray = [];
	
	if ((count _posArray) < 1) exitWith {
		true;
	};	
	if ((count _posArray) > 0) then {
		for "_index" from 0 to (count _posArray) do {
			_distanceArray pushBack ((_posArray select _index) distance2D (_pos));
		};
		sleep 0.01;
		_numFails = {_x < _minDist} count _distanceArray;
		if (_numFails isEqualTo 0) exitWith {
			true;
		};
		if (_numFails > 0) exitWith {
			false;
		};
	};