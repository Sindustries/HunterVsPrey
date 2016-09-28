/*
	HVP Side Tasks
	Author: Sinbane
	Gives player side tasks for finding certain items
*/
if (isNil "Sinspawn_lootList") exitWith {};
private ["_taskGasMask","_taskNVG","_taskGPS","_taskWep"];
//-----------------------------------

_taskGasMask = player createSimpleTask ["taskGasMask"];
_taskGasMask setSimpleTaskDescription ["Find and equip some headgear that covers your mouth and nose to protect against toxic gas","Find Toxic Gas protection",""];
_taskGasMask setTaskState "Assigned";
[_taskGasMask] spawn {
	_taskGasMask = _this select 0;
	waitUntil {sleep 3; (headgear player) in HVP_gasMasks || (goggles player) in HVP_gasMasks};
	_taskGasMask setTaskState "Succeeded";
	["TaskSucceeded",["","Find Toxic Gas protection"]] call bis_fnc_showNotification;
};

//-----------------------------------

if (HVPGameType != 1) then {
	_taskNVG = player createSimpleTask ["taskNVG"];
	_taskNVG setSimpleTaskDescription ["Find Night Vision Goggles","Find Night Vision Goggles",""];
	_taskNVG setTaskState "Assigned";
	[_taskNVG] spawn {
		_taskNVG = _this select 0;
		waitUntil {sleep 3; (hmd player) in (Sinspawn_lootList select 7)};
		_taskNVG setTaskState "Succeeded";
		["TaskSucceeded",["","Find Night Vision Goggles"]] call bis_fnc_showNotification;
	};
};

//-----------------------------------

_taskGPS = player createSimpleTask ["taskGPS"];
_taskGPS setSimpleTaskDescription ["Find a GPS","Find a GPS",""];
_taskGPS setTaskState "Assigned";
[_taskGPS] spawn {
	_taskGPS = _this select 0;
	waitUntil {sleep 3; "ItemGPS" in (items player + assignedItems player)};
	_taskGPS setTaskState "Succeeded";
	["TaskSucceeded",["","Find a GPS"]] call bis_fnc_showNotification;
};

//-----------------------------------

if (HVPGameType != 1) then {
	_taskWep = player createSimpleTask ["taskWep"];
	_taskWep setSimpleTaskDescription ["Find a Weapon","Find a Weapon",""];
	_taskWep setTaskState "Assigned";
	[_taskWep] spawn {
		_taskWep = _this select 0;
		waitUntil {sleep 3; (currentWeapon player) in (Sinspawn_lootList select 0)};
		_taskWep setTaskState "Succeeded";
		["TaskSucceeded",["","Find a Weapon"]] call bis_fnc_showNotification;
	};
};

//-----------------------------------