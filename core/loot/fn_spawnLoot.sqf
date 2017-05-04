
	private ["_weapon","_magazineClass","_item","_clothing","_backpack","_holder","_lootType","_id","_debug"];
	_pos =	(_this select 0);
	_pos0 =	(_pos select 0);
	_pos1 =	(_pos select 1);
	_pos2 = (_pos select 2);
	_zAdjust = (_this select 1);
	_gunsWithMag = (_this select 2);
	_safePlace = (_this select 3);

	_holder = createVehicle ["GroundWeaponHolder", _safePlace, [], 0, "CAN_COLLIDE"];

	for "_lootType" from 0 to ((count Sinspawn_lootList)-1) do {
		if ((Sinspawn_lootChance select _lootType) > (random 100)) then {
			_spawned = true;

			//WEAPONS - RIFLES, LAUNCHERS
			if (_lootType isEqualTo 0 && (count (Sinspawn_lootList select 0)) > 0) then {

				_weapon = selectRandom (Sinspawn_lootList select 0);
				_holder addWeaponCargoGlobal [_weapon, 1];

				if (_gunsWithMag isEqualTo 1) then {
					_magazineClass = selectRandom (getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines"));
					_holder addMagazineCargoGlobal [_magazineClass, floor(random 3)];
				};
				if (HVPDebugMode isEqualTo 1) then {
					_id = format ["%1",_pos];
					_debug = createMarker [_id,_pos];
					_debug setMarkerShape "ICON";
					_debug setMarkerType "hd_dot";
					_debug setMarkerSize [0.5,0.5];
					_debug setMarkerAlpha 0.5;
					_debug setMarkerColor "ColorBlack";
				};
			};

			//WEAPONS - PISTOLS
			if (_lootType isEqualTo 1 && (count (Sinspawn_lootList select 1)) > 0) then {

				_weapon = selectRandom (Sinspawn_lootList select 1);
				_holder addWeaponCargoGlobal [_weapon, 1];

				if (_gunsWithMag isEqualTo 1) then {
					_magazineClass = selectRandom (getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines"));
					_holder addMagazineCargoGlobal [_magazineClass, floor(random 3)];
				};
				if (HVPDebugMode isEqualTo 1) then {
					_id = format ["%1",_pos];
					_debug = createMarker [_id,_pos];
					_debug setMarkerShape "ICON";
					_debug setMarkerType "hd_dot";
					_debug setMarkerSize [0.5,0.5];
					_debug setMarkerAlpha 0.5;
					_debug setMarkerColor "ColorBlack";
				};
			};

			//MAGAZINES
			if (_lootType isEqualTo 2 && (count (Sinspawn_lootList select 2)) > 0) then {
				_magazineClass = selectRandom (Sinspawn_lootList select 2);
				_holder addMagazineCargoGlobal [_magazineClass, floor(random 2)];
				if ((random 100) < 10 ) then {
					if ((count (Sinspawn_lootList select 0)) > 0 && (count (Sinspawn_lootList select 1)) > 0) then {
						_magazineClass = selectRandom ((getArray (configFile >> "CfgWeapons" >> (selectRandom (Sinspawn_lootList select 0)) >> "magazines"))+(getArray (configFile >> "CfgWeapons" >> (selectRandom (Sinspawn_lootList select 1)) >> "magazines")));
						_holder addMagazineCargoGlobal [_magazineClass, floor(random 2)];
					};
				};
				if (HVPDebugMode isEqualTo 1) then {
					_id = format ["%1",_pos];
					_debug = createMarker [_id,_pos];
					_debug setMarkerShape "ICON";
					_debug setMarkerType "hd_dot";
					_debug setMarkerSize [0.5,0.5];
					_debug setMarkerAlpha 0.5;
					_debug setMarkerColor "ColorRed";
				};
			};

			//ITEMS
			if (_lootType isEqualTo 3) then {
				_item = selectRandom (Sinspawn_lootList select 3);
				_holder addItemCargoGlobal [_item, 1];
				for "_count" from 0 to 5 do {
					_chance = (random 100);
					if (_chance <= 10) then {
						_item = selectRandom (Sinspawn_lootList select 3);
						_holder addItemCargoGlobal [_item, 1];
					};
				};
				if (HVPDebugMode isEqualTo 1) then {
					_id = format ["%1",_pos];
					_debug = createMarker [_id,_pos];
					_debug setMarkerShape "ICON";
					_debug setMarkerType "hd_dot";
					_debug setMarkerSize [0.5,0.5];
					_debug setMarkerAlpha 0.5;
					_debug setMarkerColor "ColorOrange";
				};
			};

			//MEDICAL
			if (_lootType isEqualTo 4) then {
				_med = selectRandom (Sinspawn_lootList select 4);
				_holder addItemCargoGlobal [_med, 1];
				if (HVPDebugMode isEqualTo 1) then {
					_id = format ["%1",_pos];
					_debug = createMarker [_id,_pos];
					_debug setMarkerShape "ICON";
					_debug setMarkerType "hd_dot";
					_debug setMarkerSize [0.5,0.5];
					_debug setMarkerAlpha 0.5;
					_debug setMarkerColor "ColorBlue";
				};
			};

			//CLOTHING
			if (_lootType isEqualTo 5) then {
				_clothing = selectRandom (Sinspawn_lootList select 5);
				_holder addItemCargoGlobal [_clothing, 1];
				if (HVPDebugMode isEqualTo 1) then {
					_id = format ["%1",_pos];
					_debug = createMarker [_id,_pos];
					_debug setMarkerShape "ICON";
					_debug setMarkerType "hd_dot";
					_debug setMarkerSize [0.5,0.5];
					_debug setMarkerAlpha 0.5;
					_debug setMarkerColor "ColorGreen";
				};
			};

			//VEST
			if (_lootType isEqualTo 6) then {
				_clothing = selectRandom (Sinspawn_lootList select 6);
				_holder addItemCargoGlobal [_clothing, 1];
				if (HVPDebugMode isEqualTo 1) then {
					_id = format ["%1",_pos];
					_debug = createMarker [_id,_pos];
					_debug setMarkerShape "ICON";
					_debug setMarkerType "hd_dot";
					_debug setMarkerSize [0.5,0.5];
					_debug setMarkerAlpha 0.5;
					_debug setMarkerColor "ColorGreen";
				};
			};

			//BACKPACKS
			if (_lootType isEqualTo 7) then {
				_backpack = selectRandom (Sinspawn_lootList select 7);
				_holder addBackpackCargoGlobal [_backpack, 1];
				if (HVPDebugMode isEqualTo 1) then {
					_id = format ["%1",_pos];
					_debug = createMarker [_id,_pos];
					_debug setMarkerShape "ICON";
					_debug setMarkerType "hd_dot";
					_debug setMarkerSize [0.5,0.5];
					_debug setMarkerAlpha 0.5;
					_debug setMarkerColor "ColorYellow";
				};
			};

			//SPECIAL CLOTHING -DISABLED
			/*
			if (_lootType isEqualTo 8) then {
				_clothing = selectRandom (Sinspawn_lootList select 8);
				_holder addItemCargoGlobal [_clothing, 1];
				if (HVPDebugMode isEqualTo 1) then {
					_id = format ["%1",_pos];
					_debug = createMarker [_id,_pos];
					_debug setMarkerShape "ICON";
					_debug setMarkerType "hd_dot";
					_debug setMarkerSize [0.5,0.5];
					_debug setMarkerAlpha 0.5;
					_debug setMarkerColor "ColorBlue";
				};
			};
			*/

			//NIGHT VISION
			if (_lootType isEqualTo 9) then {
				_clothing = selectRandom (Sinspawn_lootList select 9);
				_holder addItemCargoGlobal [_clothing, 1];
				if (HVPDebugMode isEqualTo 1) then {
					_id = format ["%1",_pos];
					_debug = createMarker [_id,_pos];
					_debug setMarkerShape "ICON";
					_debug setMarkerType "hd_dot";
					_debug setMarkerSize [0.5,0.5];
					_debug setMarkerAlpha 0.5;
					_debug setMarkerColor "ColorBrown";
				};
			};

			//SUPPRESSORS
			if (_lootType isEqualTo 10) then {
				_magazineClass = selectRandom (Sinspawn_lootList select 10);
				_holder addItemCargoGlobal [_magazineClass, 1];
				if (HVPDebugMode isEqualTo 1) then {
					_id = format ["%1",_pos];
					_debug = createMarker [_id,_pos];
					_debug setMarkerShape "ICON";
					_debug setMarkerType "hd_dot";
					_debug setMarkerSize [0.5,0.5];
					_debug setMarkerAlpha 0.5;
					_debug setMarkerColor "ColorRed";
				};
			};

			if (_spawned) exitWith {};
		};
	};

	_holder setPos [_pos0,_pos1,(_pos2+_zAdjust)];
	Sinspawn_holders pushBack _holder;
	//deletevehicle _BARREL;