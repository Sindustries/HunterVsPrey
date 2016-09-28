
	player addEventHandler ["HandleHeal", {
		[(_this select 0),(_this select 1)] spawn {
			private ["_unit","_healer","_damage"];
			_unit = _this select 0;
			_healer = _this select 1;
			_damage = (damage _unit);
			
			if (_unit != player) exitWith {};

			waitUntil {(damage _unit) < _damage};
			_unit setDamage 0;
			SMS_bleedingParts = [];
			if ((_unit getVariable "SMS_bleedingRate") isEqualTo 0) exitWith {};
			_unit setVariable ["SMS_bleedingRate", 0];
		};
	}];