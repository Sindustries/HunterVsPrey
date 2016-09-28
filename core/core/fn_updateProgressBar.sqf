	private ["_current","_target","_progress"];

	_current = _this select 0;
	_target = _this select 1;
	
	_progress = ((_target - _current) / _target);
	
	uiNameSpace getVariable "PBarProgress" progressSetPosition _progress;