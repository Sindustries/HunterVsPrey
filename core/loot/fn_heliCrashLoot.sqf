	
	private ["_drop","_weapon","_mag1","_mag2","_item","_clothes","_backpack","_nvRoll","_spRoll","_spClothes","_nvg","_specHelmets","_mine","_roll"];
	
	_drop = _this select 0;
	
	clearMagazineCargoGlobal _drop;
	clearWeaponCargoGlobal _drop;
	clearItemCargoGlobal _drop;
	clearBackpackCargoGlobal _drop;
	
	if (HVPGameType isEqualTo 1) then {
	
		for [{_i=0}, {_i<4}, {_i=_i+1}] do {

			_weapon = selectRandom (Sinspawn_lootList select 0);
			_magazines = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
			_mag1 = selectRandom _magazines; 
			_mag2 = selectRandom (Sinspawn_lootList select 1);
			_item = selectRandom (Sinspawn_lootList select 2);
			_med = selectRandom (Sinspawn_lootList select 3);
			_clothes = selectRandom (Sinspawn_lootList select 4);
			_backpack = selectRandom (Sinspawn_lootList select 5);
			_spClothes = selectRandom (Sinspawn_lootList select 6);
			_nvg = selectRandom (Sinspawn_lootList select 7);
			_mine = selectRandom (Sinspawn_lootList select 8);
			
			_drop addWeaponCargoGlobal [_weapon, floor (random 2)];
			_drop addMagazineCargoGlobal [_mag1, 1 + floor (random 3)];
			_drop addMagazineCargoGlobal [_mag2, 1 + floor (random 2)];
			_drop addItemCargoGlobal [_item, 1 + floor (random 2)];
			_drop addItemCargoGlobal [_med, 1 + floor (random 2)];
			_drop addItemCargoGlobal [_clothes, 1 + floor (random 2)];
			_drop addBackpackCargoGlobal [_backpack, floor (random 2)];
		};
	
	};	
	
	if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {	
	
		_specItems = ["H_HelmetO_ViperSP_hex_F","H_HelmetO_ViperSP_ghex_F","optic_Nightstalker","optic_tws","optic_tws_mg","NVGoggles_blk_F"];
		
		for [{_i=0}, {_i<4}, {_i=_i+1}] do {

			_weapon = selectRandom (Sinspawn_lootList select 0);
			_magazines = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
			_mag1 = selectRandom _magazines; 
			_mag2 = selectRandom (Sinspawn_lootList select 1);
			_item = selectRandom (Sinspawn_lootList select 2);
			_med = selectRandom (Sinspawn_lootList select 3);
			_clothes = selectRandom (Sinspawn_lootList select 4);
			_backpack = selectRandom (Sinspawn_lootList select 5);
			_spClothes = selectRandom (Sinspawn_lootList select 6);
			_nvg = selectRandom (Sinspawn_lootList select 7);
			_mine = selectRandom (Sinspawn_lootList select 8);
			
			_drop addWeaponCargoGlobal [_weapon, floor (random 2)];
			_drop addMagazineCargoGlobal [_mag1, 1 + floor (random 3)];
			_drop addMagazineCargoGlobal [_mag2, 1 + floor (random 2)];
			_drop addItemCargoGlobal [_item, 1 + floor (random 2)];
			_drop addItemCargoGlobal [_med, 1 + floor (random 2)];
			_drop addItemCargoGlobal [_clothes, 1 + floor (random 2)];
			_drop addBackpackCargoGlobal [_backpack, floor (random 2)];
			_drop addItemCargoGlobal [_spClothes, floor (random 2)];
			_drop addItemCargoGlobal [_nvg, floor (random 2)];
			_drop addMagazineCargoGlobal [_mine, floor (random 2)];
			
			_roll = (random 100);
			if (_roll <= 2.5) then {
				_drop addItemCargoGlobal [(selectRandom _specItems), 1];
			};
		};
	};