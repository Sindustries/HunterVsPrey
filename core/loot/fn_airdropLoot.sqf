
	private ["_drop","_dropRate","_weapon","_pistol","_magPistol","_mag1","_mag2","_item","_clothes","_backpack","_nvRoll","_spRoll","_spClothes","_nvg","_sns"];
	_drop = _this select 0;

	if (HVPGameType isEqualTo 1) then { _dropRate = 3; };
	if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then { _dropRate = 6; };

	clearWeaponCargoGlobal _drop;
	clearMagazineCargoGlobal _drop;
	clearItemCargoGlobal _drop;
	clearBackpackCargoGlobal _drop;

	for "_i" from 0 to _dropRate do {
		if (count (Sinspawn_lootList select 0) > 0) then {
			_weapon = selectRandom (Sinspawn_lootList select 0);
			_mag1 = selectRandom (getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines"));
		};
		if (count (Sinspawn_lootList select 1) > 0) then {
			_pistol = selectRandom (Sinspawn_lootList select 1);
			_magPistol = selectRandom (getArray (configFile >> "CfgWeapons" >> _pistol >> "magazines"));
		};
		_mag2 = selectRandom (Sinspawn_lootList select 2);
		_item = selectRandom (Sinspawn_lootList select 3);
		_med = selectRandom (Sinspawn_lootList select 4);
		_clothes = selectRandom (Sinspawn_lootList select 5);
		_vest = selectRandom (Sinspawn_lootList select 6);
		_backpack = selectRandom (Sinspawn_lootList select 7);
		_spClothes = selectRandom (Sinspawn_lootList select 8);
		_nvg = selectRandom (Sinspawn_lootList select 9);
		_sns = selectRandom (Sinspawn_lootList select 10);

		if (HVP_lootSpawnChance > (random 100) && count (Sinspawn_lootList select 0) > 0) then {
			_drop addWeaponCargoGlobal [_weapon, 1];
			_drop addMagazineCargoGlobal [_mag1, floor (random 3)];
		};
		if (HVP_lootSpawnChance > (random 100) && count (Sinspawn_lootList select 1) > 0) then {
			_drop addWeaponCargoGlobal [_pistol, 1];
			_drop addMagazineCargoGlobal [_magPistol, floor (random 3)];
		};
		if (HVP_lootSpawnChance > (random 100)) then {
			_drop addMagazineCargoGlobal [_mag2, floor (random 2)];
		};
		if (HVP_lootSpawnChance > (random 100)) then {
			_drop addItemCargoGlobal [_item, 1];
		};
		if (HVP_lootSpawnChance > (random 100)) then {
			_drop addItemCargoGlobal [_med, floor (random 2)];
		};
		if (HVP_lootSpawnChance > (random 100)) then {
			_drop addItemCargoGlobal [_clothes, 1];
		};
		if (HVP_lootSpawnChance > (random 100)) then {
			_drop addItemCargoGlobal [_vest, 1];
		};
		if (HVP_lootSpawnChance > (random 100)) then {
			_drop addBackpackCargoGlobal [_backpack, 1];
		};

		if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
			if ((Sinspawn_lootChance select 7) > (random 100)) then {
				_drop addItemCargoGlobal [_spClothes, floor (random 2)];
			};
			if ((Sinspawn_lootChance select 8) > (random 100)) then {
				_drop addItemCargoGlobal [_nvg, floor (random 2)];
			};
			if ((Sinspawn_lootChance select 9) > (random 100)) then {
				_drop addItemCargoGlobal [_sns, floor (random 2)];
			};
		};
	};