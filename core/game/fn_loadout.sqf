/*
	fn_loadOutSet
	By Sinbane
	Get player loadout for current class and spawns the correct gear defined in Config_Loadout
*/
private ["_settings","_cfg","_class","_i","_paramName","_type","_return"];
removeUniform player;
removeVest player;
removeHeadgear player;
removeBackpack player;
removeAllWeapons player;
removeAllAssignedItems player;
if ((goggles player) in HVP_gasMasks) then {removeGoggles player};
//-----------------------------------
//-FIND LOADOUT

switch (HVPGameType) do {
	case 1: {
		switch (playerSide) do {
			case WEST: {
				_cfg = (missionConfigFile >> "LOADOUT" >> "HVP" >> "BLUE");
				for "_i" from 0 to (count _cfg - 1) do {
					_paramName = configName (_cfg select _i);
					_type = getText(_cfg >> _paramName >> "loadoutType");
					if (player isKindOf _type) then {
						_class = (missionConfigFile >> "LOADOUT" >> "HVP" >> "BLUE" >> _paramName);
					};
				};
			};
			case EAST: {
				_cfg = (missionConfigFile >> "LOADOUT" >> "HVP" >> "RED");
				for "_i" from 0 to (count _cfg - 1) do {
					_paramName = configName (_cfg select _i);
					_type = getText(_cfg >> _paramName >> "loadoutType");
					if (player isKindOf _type) then {
						_class = (missionConfigFile >> "LOADOUT" >> "HVP" >> "RED" >> _paramName);
					};
				};
			};
			case RESISTANCE: {
				_cfg = (missionConfigFile >> "LOADOUT" >> "HVP" >> "MERC");
				for "_i" from 0 to (count _cfg - 1) do {
					_paramName = configName (_cfg select _i);
					_type = getText(_cfg >> _paramName >> "loadoutType");
					if (player isKindOf _type) then {
						_class = (missionConfigFile >> "LOADOUT" >> "HVP" >> "MERC" >> _paramName);
					};
				};
			};
		};
	};
	case 2: {
		_cfg = (missionConfigFile >> "LOADOUT" >> "CRU");
	};
	case 3: {
		switch (playerSide) do {
			case WEST: {
				_cfg = (missionConfigFile >> "LOADOUT" >> "PRED" >> "PREY");
			};
			case EAST: {
				_cfg = (missionConfigFile >> "LOADOUT" >> "PRED" >> "PREY");
			};
			case RESISTANCE: {
				_cfg = (missionConfigFile >> "LOADOUT" >> "PRED" >> "PREDATOR");
			};
		};
	};
};
_settings = [];
if (!(isNil "_class")) then {
	for "_i" from 0 to ((count _class) - 1) do {
		_paramName = configName ((_class) select _i);
		if (isArray (_class >> _paramName)) then {
			_return = getArray(_class >> _paramName);
		};
		if (isNumber (_class >> _paramName)) then {
			_return = getNumber(_class >> _paramName);
		};
		if (isText (_class >> _paramName)) then {
			_return = getText(_class >> _paramName);
		};
		_settings pushBack [_paramName,_return];
	};
} else {
	for "_i" from 0 to ((count _cfg) - 1) do {
		_paramName = configName ((_cfg) select _i);
		if (isArray (_cfg >> _paramName)) then {
			_return = getArray(_cfg >> _paramName);
		};
		if (isNumber (_cfg >> _paramName)) then {
			_return = getNumber(_cfg >> _paramName);
		};
		if (isText (_cfg >> _paramName)) then {
			_return = getText(_cfg >> _paramName);
		};
		_settings pushBack [_paramName,_return];
	};
};
{
	player setVariable [(_x select 0), (_x select 1), true];
} forEach _settings;

//-----------------------------------
private ["_mapChance","_ammoChance","_medChance","_headgear","_uniformSel","_ghillieSel","_ghillieSelMARKSMAN","_headgearAPEX","_uniformSelAPEX","_mercUniformSelAPEX"];

_mapChance = ["loadoutMapChance"] call HVP_fnc_getSetting;
_ammoChance = ["loadoutAmmoChance"] call HVP_fnc_getSetting;
_medChance = ["loadoutMedChance"] call HVP_fnc_getSetting;
_marksman = (332350 in (getDLCs 1));
_APEX = (395180 in (getDLCs 1));

_headgear = ["randomHeadgear"] call HVP_fnc_getSetting;
_uniformSel = ["randomUniforms"] call HVP_fnc_getSetting;
_ghillieSel = ["randomGhillies"] call HVP_fnc_getSetting;

if (_marksman) then {
	_ghillieSelMARKSMAN = ["randomGhilliesMARKSMAN"] call HVP_fnc_getSetting;
	{_ghillieSel pushback _x;} foreach _ghillieSelMARKSMAN;
};
if (_APEX) then {
	_headgearAPEX = ["randomHeadgearAPEX"] call HVP_fnc_getSetting;
	_uniformSelAPEX = ["randomUniformsAPEX"] call HVP_fnc_getSetting;
	
	{_uniformSel pushBack _x;} foreach _uniformSelAPEX;
	
	if (playerSide isEqualTo resistance && HVPGameType isEqualTo 1) then {
		_mercUniformSelAPEX = ["randomMercUniformAPEX"] call HVP_fnc_getSetting;
	};
};

switch (HVPGameType) do {
	case 1: {
		switch (playerSide) do {
			case WEST: {
				_uniformSel = _uniformSel;
			};
			case EAST: {
				_uniformSel = _ghillieSel;
			};
			case RESISTANCE: {
				if (_APEX) then {
					_uniformSel = _mercUniformSelAPEX;
					_headgear = _headgearAPEX;
				} else {
					_uniformSel = _uniformSel;
					_headgear = _headgear;
				};
			};
		};
	};
	case 2: {
		switch (playerSide) do {
			case WEST: {
				_uniformSel = _uniformSel;
			};
			case EAST: {
				_uniformSel = _uniformSel;
			};
			case RESISTANCE: {
				_uniformSel = _uniformSel;
			};
		};
	};
	case 3: {
		switch (playerSide) do {
			case WEST: {
				_uniformSel = _uniformSel;
			};
			case EAST: {
				_uniformSel = _uniformSel;
			};
			case RESISTANCE: {
				_uniformSel = _ghillieSel;
			};
		};
	};
};

private ["_mainWeapon","_mainWeaponAccessories","_mainWeaponAmmo","_sideWeapon","_sideWeaponAccessories","_sideWeaponAmmo","_uniform","_vest","_helmet","_backpack","_binoculars","_nightVision","_mask","_linkedItems","_inventoryItems","_inventoryMagazines"];

_mainWeapon = player getVariable "loadoutMainWeapon";
_mainWeaponAccessories = player getVariable "loadoutMainWeaponAccessories";
_mainWeaponAmmo = player getVariable "loadoutMainWeaponAmmo"; 
_sideWeapon = player getVariable "loadoutSideWeapon";
_sideWeaponAccessories = player getVariable "loadoutSideWeaponAccessories";
_sideWeaponAmmo = player getVariable "loadoutSideWeaponAmmo";
_uniform = player getVariable "loadoutUniform";
_vest = player getVariable "loadoutVest";
_helmet = player getVariable "loadoutHelmet";
_backpack = player getVariable "loadoutBackpack";
_binoculars = player getVariable "loadoutBinoculars";
_nightVision = player getVariable "loadoutNightVision";
_mask = player getVariable "loadoutMask";
_linkedItems = player getVariable "loadoutLinkedItems";
_inventoryItems = player getVariable "loadoutInventoryItems";
_inventoryMagazines = player getVariable "loadoutInventoryMagazines";

//-----------------------------------
//-EQUIP CLOTHING
//-----------------------------------
//-EQUIP UNIFORM, GOGGLES, NIGHT VISION, VEST, HELMET, BACKPACK, BINOCULARS
if (_uniform isEqualTo "") then {
	player addUniform (selectRandom _uniformSel);
} else {
	player addUniform _uniform;
};
if (_mask isEqualTo "") then {} else {
	player addGoggles _mask;
};
if (_nightVision isEqualTo "") then {} else {
	player linkItem _nightVision;
};
if (_vest isEqualTo "") then {} else {
	player addVest _vest;
};
if (_helmet isEqualTo "") then {
	player addHeadgear (selectRandom _headgear);
} else {
	player addHeadgear _helmet;
};
if (_backpack isEqualTo "") then {} else {
	player addBackpack _backpack;
};
if (_binoculars isEqualTo "") then {} else {
	player addWeapon _binoculars;
};
//-----------------------------------
//-LINKED ITEMS
if (count _linkedItems > 0) then {
	for "_i" from 0 to (count _linkedItems - 1) do {
		_item = (_linkedItems select _i);
		if (HVPGameType isEqualTo 1 && _item isEqualTo "itemMap" && (random 100) < _mapChance) then {
			player linkItem _item;
		} else {
			player linkItem _item;
		};
	};
};
//-----------------------------------
//-INVENTORY ITEMS
if (count _inventoryItems > 0) then {
	for "_i" from 0 to (count _inventoryItems - 1) do {
		_item = (_inventoryItems select _i);
		if (_item isEqualTo "FirstAitKit" && (random 100) < _medChance) then {
			player addItem _item;
		} else {
			player addItem _item;
		};
	};	
};
//-----------------------------------
//-INVENTORY MAGAZINES
if (count _inventoryMagazines > 0) then {
	for "_i" from 0 to (count _inventoryMagazines - 1) do {
		if ((random 100) < _ammoChance) then {
			player addMagazines [(_inventoryMagazines select _i), floor(random 3)+1];
		};
	};	
};
//-----------------------------------
//-WEAPON AMMO
switch (HVPGameType) do {
	case 1: {
		switch (playerSide) do {
			case WEST: {
				if (count _mainWeaponAmmo > 0 && (random 100) < _ammoChance) then {
					{
						player addMagazines [_x, 1];
					} foreach _mainWeaponAmmo;
				};
				if (count _sideWeaponAmmo > 0 && (random 100) >= _ammoChance) then {
					{
						player addMagazines [_x, 1];
					} foreach _sideWeaponAmmo;
				};
			};
			case EAST: {
				if (count _sideWeaponAmmo > 0) then {
					{
						player addMagazine [_x, 1];
					} foreach _sideWeaponAmmo;
				};
			};
			case RESISTANCE: {
				if (count _mainWeaponAmmo > 0 && (random 100) < _ammoChance) then {
					{
						player addMagazines [_x, 1];
					} foreach _mainWeaponAmmo;
				};
				if (count _sideWeaponAmmo > 0 && (random 100) >= _ammoChance) then {
					{
						player addMagazines [_x, 1];
					} foreach _sideWeaponAmmo;
				};
			};
		};
	};
};
//-----------------------------------
//-WEAPONS
if (_mainWeapon isEqualTo "") then {} else {
	player addWeapon _mainWeapon;
	if (count _mainWeaponAccessories > 0) then {
		{
			player addPrimaryWeaponItem _x;
		} foreach _mainWeaponAccessories;
	};
};
if (_sideWeapon isEqualTo "") then {} else {
	player addWeapon _sideWeapon;
	if (count _sideWeaponAccessories > 0) then {
		{
			player addHandgunItem _x;
		} foreach _sideWeaponAccessories;
	};
};
//-RANDOM
private "_weapon";
if (_mainWeapon isEqualTo "Random") then {
	_weaponFound = false;
	while {!_weaponFound} do {
		_weapon = selectRandom (Sinspawn_lootList select 0);
		if (_weapon isKindOf ["Rifle", configFile >> "CfgWeapons"]) then {
			_weaponFound = true;
		};
	};
	_magazines = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
	_magazine = selectRandom _magazines;
	player addMagazines [_magazine, 2];
	player addWeapon _weapon;
};
if (_sideWeapon isEqualTo "Random") then {
	_weaponFound = false;
	while {!_weaponFound} do {
		_weapon = selectRandom (Sinspawn_lootList select 0);
		if (_weapon isKindOf ["Pistol", configFile >> "CfgWeapons"]) then {
			_weaponFound = true;
		};
	};
	_magazines = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
	_magazine = selectRandom _magazines;
	player addMagazines [_magazine, 2];
	player addWeapon _weapon;
};
//-----------------------------------