
	
	private ["_drop","_dropRate","_specItems","_weapon","_mag1","_mag2","_item","_clothes","_backpack","_nvRoll","_spRoll","_spClothes","_nvg","_sns"];
	_drop = _this select 0;
	
	if (HVPGameType isEqualTo 1) then { _dropRate = 3; };
	if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then { _dropRate = 4; };
	
	clearWeaponCargoGlobal _drop;
	clearMagazineCargoGlobal _drop;
	clearItemCargoGlobal _drop;
	clearBackpackCargoGlobal _drop;
	
	_specItems = ["H_HelmetO_ViperSP_hex_F","H_HelmetO_ViperSP_ghex_F","optic_Nightstalker","optic_tws","optic_tws_mg","NVGoggles_blk_F"];
	
	for "_i" from 0 to _dropRate do {
		_weapon = selectRandom (Sinspawn_lootList select 0);
		_mag1 = selectRandom (getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines")); 
		_mag2 = selectRandom (Sinspawn_lootList select 1);
		_item = selectRandom (Sinspawn_lootList select 2);
		_med = selectRandom (Sinspawn_lootList select 3);
		_clothes = selectRandom (Sinspawn_lootList select 4);
		_vest = selectRandom (Sinspawn_lootList select 5);
		_backpack = selectRandom (Sinspawn_lootList select 6);
		_spClothes = selectRandom (Sinspawn_lootList select 7);
		_nvg = selectRandom (Sinspawn_lootList select 8);
		_sns = selectRandom (Sinspawn_lootList select 9);
		
		_drop addWeaponCargoGlobal [_weapon, floor (random 2)];
		_drop addMagazineCargoGlobal [_mag1, floor (random 2)];
		_drop addMagazineCargoGlobal [_mag2, floor (random 2)];
		_drop addItemCargoGlobal [_item, floor (random 2)];
		_drop addItemCargoGlobal [_med, floor (random 2)];
		_drop addItemCargoGlobal [_clothes, floor (random 2)];
		_drop addItemCargoGlobal [_vest, floor (random 2)];
		_drop addBackpackCargoGlobal [_backpack, floor (random 2)];
		
		if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
			_drop addItemCargoGlobal [_spClothes, floor (random 2)];
			_drop addItemCargoGlobal [_nvg, floor (random 2)];
			_drop addItemCargoGlobal [_sns, floor (random 2)];
			if ((random 100) <= 2.5) then {
				_drop addItemCargoGlobal [(selectRandom _specItems), 1];
			};
		};		
	};