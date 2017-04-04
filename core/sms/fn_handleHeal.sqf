
	player addEventHandler ["HandleHeal", {
		[(_this select 0),(_this select 1)] spawn {
			private ["_unit","_healer","_damage"];
			_unit = _this select 0;
			_healer = _this select 1;
			_damage = (damage _unit);

			player setDamage 0;
			player setVariable ["SMS_bleedingRate", 0];
			player setBleedingRemaining 0;
		};
	}];