
	player addEventHandler ["HandleDamage", {
		[(_this select 0),(_this select 1),(_this select 2),(_this select 3),(_this select 4)] spawn {
			private ["_unit","_selectionName","_damage","_source","_projectile"];
			_unit = _this select 0;
			_selectionName = _this select 1;
			_damage = _this select 2;
			_source = _this select 3;
			_projectile = _this select 4;

			if (_projectile in HVP_mines) then {
				_damage = 0;
				[_unit, 30] spawn SMS_fnc_setUnconscious;
			};
			if (_projectile isEqualTo "") then {
				_damage = (_damage * SMS_fallDamage);
			};

			if (HVPGameType isEqualTo 1) then {
				if (side _unit isEqualTo WEST && !(_projectile in HVP_redAmmo)) then {
					_unit setDamage ((damage _unit)+(_damage/4));
					_unit setHit [_selectionName, ((damage _unit)+(_damage/4))];
				};
				if (side _unit isEqualTo EAST && !(_projectile in HVP_redAmmo)) then {
					_unit setDamage ((damage _unit)+(_damage/10));
					_unit setHit [_selectionName, ((damage _unit)+(_damage/10))];
				};
				if  (_projectile in HVP_redAmmo) then {
					_unit setDamage (damage _unit);
					_unit setHit [_selectionName, (_unit getHit _selectionName)];
					if (vehicle _unit != _unit) then {
						_unit action ["Eject",vehicle _unit];
					};
					[_unit, 12] spawn SMS_fnc_setUnconscious;
				};
			};
			if (HVPGameType isEqualTo 2) then {
				_unit setDamage ((damage _unit)+(_damage/4));
				_unit setHit [_selectionName, ((damage _unit)+(_damage/4))];
			};
			if (HVPGameType isEqualTo 3) then {
				if (side _unit != RESISTANCE) then {
					_unit setDamage ((damage _unit)+(_damage/4));
					_unit setHit [_selectionName, ((damage _unit)+(_damage/4))];
				};
				if (side _unit isEqualTo RESISTANCE) then {
					_unit setDamage ((damage _unit)+(_damage/10));
					_unit setHit [_selectionName, ((damage _unit)+(_damage/10))];
				};
			};

			if (_damage >= 0.1) then {
				[_unit,(_damage * SMS_bloodLossCOEF)] spawn SMS_fnc_setBleeding;
			};
			if (_damage >= 0.75 && (_unit getVariable "SMS_isUnconscious") isEqualTo false) then {
				[_unit,30] spawn SMS_fnc_setUnconscious;
			};
		};
	}];