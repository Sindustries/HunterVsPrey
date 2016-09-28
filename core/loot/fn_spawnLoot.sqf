
	private ["_weapon","_magazines","_magazineClass","_item","_clothing","_backpack","_holder","_chance","_roll","_lootType","_id","_debug"];
	_pos =	(_this select 0);
	_pos0 =	(_pos select 0);
	_pos1 =	(_pos select 1);
	_pos2 = (_pos select 2);
	_zAdjust = (_this select 1);
	_gunsWithMag = (_this select 2);
	_safePlace = (_this select 3);
	
	_holder = createVehicle ["GroundWeaponHolder", _safePlace, [], 0, "CAN_COLLIDE"];
				
	for "_lootType" from 0 to 8 do {
		_chance = floor(random 100);
		if ((Sinspawn_lootChance select _lootType) > _chance) then {
			_spawned = true;
			
			//WEAPONS
			if (_lootType isEqualTo 0) then {
			
				_weapon = selectRandom (Sinspawn_lootList select 0);
				_holder addWeaponCargoGlobal [_weapon, 1];
			
				if (_gunsWithMag isEqualTo 1) then {
					_magazines = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
					_magazineClass = selectRandom _magazines; 
					_holder addMagazineCargoGlobal [_magazineClass, floor(random 3)];
				};
				Sinspawn_weaponsSpawned = Sinspawn_weaponsSpawned + 1;
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
			if (_lootType isEqualTo 1) then {
				if (HVPGameType isEqualTo 1) then {
					_magazineClass = selectRandom (Sinspawn_lootList select 1);
					_holder addMagazineCargoGlobal [_magazineClass, 1];
				};
				if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
					_weapon = selectRandom (Sinspawn_lootList select 0);
					_magazines = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
					_magazineClass = selectRandom _magazines;
					_holder addMagazineCargoGlobal [_magazineClass, floor (random 2)];
					_roll = (random 100);
					if (_roll < 50) then {
						_magazineClass = selectRandom (Sinspawn_lootList select 1);
						_holder addMagazineCargoGlobal [_magazineClass, floor 1];
					};
				};
				Sinspawn_magsSpawned = Sinspawn_magsSpawned + 1;
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
			if (_lootType isEqualTo 2) then {
				_item = selectRandom (Sinspawn_lootList select 2);
				_holder addItemCargoGlobal [_item, 1];
				for "_count" from 0 to 5 do {
					_chance = (random 100);
					if (_chance <= 10) then {
						_item = selectRandom (Sinspawn_lootList select 2);
						_holder addItemCargoGlobal [_item, 1];
					};
				};
				Sinspawn_itemsSpawned = Sinspawn_itemsSpawned + 1;
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
			if (_lootType isEqualTo 3) then {
				_med = selectRandom (Sinspawn_lootList select 3);
				_holder addItemCargoGlobal [_med, 1];
				Sinspawn_medSpawned = Sinspawn_medSpawned + 1;
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
			if (_lootType isEqualTo 4) then {
				_clothing = selectRandom (Sinspawn_lootList select 4);
				_holder addItemCargoGlobal [_clothing, 1];
				Sinspawn_clothingSpawned = Sinspawn_clothingSpawned + 1;
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
			if (_lootType isEqualTo 5) then {
				_backpack = selectRandom (Sinspawn_lootList select 5);
				_holder addBackpackCargoGlobal [_backpack, 1];
				Sinspawn_backpacksSpawned = Sinspawn_backpacksSpawned + 1;
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
			
			//SPECIAL CLOTHING
			if (_lootType isEqualTo 6) then {
				_clothing = selectRandom (Sinspawn_lootList select 6);
				_holder addItemCargoGlobal [_clothing, 1];
				Sinspawn_specialClothingSpawned = Sinspawn_specialClothingSpawned + 1;
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
			
			//NIGHT VISION
			if (_lootType isEqualTo 7) then {
				_clothing = selectRandom (Sinspawn_lootList select 7);
				_holder addItemCargoGlobal [_clothing, 1];
				Sinspawn_nightVisionSpawned = Sinspawn_nightVisionSpawned + 1;
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
			
			//MINES
			if (_lootType isEqualTo 8) then {
				_magazineClass = selectRandom (Sinspawn_lootList select 8);
				_holder addMagazineCargoGlobal [_magazineClass, 1];
				Sinspawn_magsSpawned = Sinspawn_magsSpawned + 1;
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