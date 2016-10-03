
	private ["_drop","_weapon","_mag1","_mag2","_item","_clothes","_backpack","_nvRoll","_spRoll","_spClothes","_nvg","_sns"];
	_drop = _this select 0;
	
	clearMagazineCargoGlobal _drop;
	clearWeaponCargoGlobal _drop;
	clearItemCargoGlobal _drop;
	clearBackpackCargoGlobal _drop;
	
	_spRoll = (random 100);
	_nvRoll = (random 100);
	
	if (HVPGameType isEqualTo 1) then {
		for [{_i=0}, {_i<3}, {_i=_i+1}] do {
			_weapon = selectRandom (Sinspawn_lootList select 0);
			_magazines = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
			_mag1 = selectRandom _magazines; 
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
		};
	};
	if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {	
		for [{_i=0}, {_i<6}, {_i=_i+1}] do {
			_weapon = selectRandom (Sinspawn_lootList select 0);
			_magazines = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
			_mag1 = selectRandom _magazines; 
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
			_drop addMagazineCargoGlobal [_mag1, floor (random 3)];
			_drop addMagazineCargoGlobal [_mag2, floor (random 2)];
			_drop addItemCargoGlobal [_item, floor (random 2)];
			_drop addItemCargoGlobal [_med, floor (random 2)];
			_drop addItemCargoGlobal [_clothes, floor (random 2)];
			_drop addItemCargoGlobal [_vest, floor (random 2)];
			_drop addBackpackCargoGlobal [_backpack, floor (random 2)];
			if (((Sinspawn_lootChance select 6)*2) > _spRoll) then {
				_drop addItemCargoGlobal [_spClothes, floor (random 2)];
			};
			if (((Sinspawn_lootChance select 7)*2) > _nvRoll) then {
				_drop addItemCargoGlobal [_nvg, floor (random 2)];
			};
			if ((Sinspawn_lootChance select 8) > (random 100)) then {
				_drop addItemCargoGlobal [_sns, floor (random 2)];
			};
		};
	};