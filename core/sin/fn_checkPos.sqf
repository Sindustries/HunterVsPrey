	
	_pos = _this select 0;
	
	if ((HVPErrorPos select 0) == _pos select 0 && (HVPErrorPos select 1) == _pos select 1) exitWith {
		false;
	};
	
	if ((HVPErrorPos select 0) != _pos select 0 && (HVPErrorPos select 1) != _pos select 1) exitWith {
		true;
	};