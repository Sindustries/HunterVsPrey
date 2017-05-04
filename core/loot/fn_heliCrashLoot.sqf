

	private ["_drop","_dropRate","_specItems","_weapon","_mag1","_pistol","_magPistol","_mag2","_item","_clothes","_backpack","_nvRoll","_spRoll","_spClothes","_nvg","_sns","_ti"];
	_drop = _this select 0;

	if (HVPGameType isEqualTo 1) then { _dropRate = 3; };
	if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then { _dropRate = 4; };

	clearWeaponCargoGlobal _drop;
	clearMagazineCargoGlobal _drop;
	clearItemCargoGlobal _drop;
	clearBackpackCargoGlobal _drop;

	for "_i" from 0 to _dropRate do {
		if ((count (Sinspawn_lootList select 0)) > 0) then {
			_weapon = selectRandom (Sinspawn_lootList select 0);
			_mag1 = selectRandom (getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines"));
		};
		if ((count (Sinspawn_lootList select 1)) > 0) then {
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
		_ti = selectRandom (Sinspawn_lootList select 11);

		if (HVP_lootSpawnChance > (random 100) && count (Sinspawn_lootList select 0) > 0) then {
			_drop addWeaponCargoGlobal [_weapon, floor (random 2)];
			_drop addMagazineCargoGlobal [_mag1, floor (random 2)];
		};
		if (HVP_lootSpawnChance > (random 100) && count (Sinspawn_lootList select 1) > 0) then {
			_drop addMagazineCargoGlobal [_mag2, floor (random 2)];
			_drop addItemCargoGlobal [_item, floor (random 2)];
		};
		_drop addItemCargoGlobal [_med, floor (random 2)];
		_drop addItemCargoGlobal [_clothes, floor (random 2)];
		_drop addItemCargoGlobal [_vest, floor (random 2)];
		_drop addBackpackCargoGlobal [_backpack, floor (random 2)];

		if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
			if ((random 100) < ((Sinspawn_lootChance select 7)*2)) then {
				_drop addItemCargoGlobal [_spClothes, floor (random 2)];
			};
			if ((random 100) < ((Sinspawn_lootChance select 8)*2)) then {
				_drop addItemCargoGlobal [_nvg, floor (random 2)];
			};
			if ((random 100) < ((Sinspawn_lootChance select 9)*2)) then {
				_drop addItemCargoGlobal [_sns, floor (random 2)];
			};
			if ((random 100) <= 2.5) then {
				_drop addItemCargoGlobal [_ti, floor (random 2)];
			};
		};
	};