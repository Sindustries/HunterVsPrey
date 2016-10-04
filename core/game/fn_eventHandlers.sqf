/*
	fn_eventHandlers
	Author: Sinbane
	Handles all event handlers and info messages
*/
//-----------------------------------
//-TIME SYNC

if (isServer) then {	
	[] spawn {
		while {true} do {
			setDate [(date select 0),(date select 1),(date select 2),(date select 3),(date select 4)];
			sleep 300;
		};
	};
};

//-----------------------------------
//-PREVENT LOOTING ENEMIES

player addEventHandler ["InventoryOpened", {
	private ["_unit","_container"];
	_unit = _this select 0;
	_container = _this select 1;
	
	if (HVPGameType isEqualTo 1) then {
		if (_container isKindOf "man" && !alive _container && side (group _container) != side _unit) exitWith {
			[] spawn {
				waitUntil {dialog};
				closeDialog 106;
				titleText ["YOU CAN'T LOOT THE ENEMY TEAM!", "PLAIN DOWN", 3];
			};
		};
	};
	if (HVPZombieMode isEqualTo 1 && (typeOf _container) in ((HVP_zombies)+(HVP_BossZombies))) then {
		[] spawn {
			waitUntil {dialog};
			closeDialog 106;
			titleText ["YOU CAN'T LOOT ZOMBIES!", "PLAIN DOWN", 3];
		};
	};
}];

//-----------------------------------
//-LOCATION DISPLAY

[] spawn {
	private ["_location","_locName","_locPos","_locStr","_now","_hour","_min","_time"];
	waitUntil {(player getVariable "HVP_spawned") isEqualTo true};
	while {alive player} do {
		//GET LOCATION
		_location = ((nearestLocations [position player, ["Airport", "NameVillage", "NameCity", "NameCityCapital"], 20000]) select 0);
		_locName = text _location;
		_locPos = locationPosition _location;
		if ((getPos player) distance2D _locPos >= 250) then {
			_locStr = format["Near %1",_locName];
		} else {
			_locStr = format["%1",_locName];
		};
		
		//GET TIME		
		_now = date;
		_hour = (_now select 3);
		_min = (_now select 4);
		if (_min < 10) then {
			_min = format["0%1",(_now select 4)];
		};
		_time = format["%1:%2",_hour,_min];
		
		//DISPLAY
		[_time, _locStr] spawn BIS_fnc_infoText;
		waitUntil {sleep 1; _location != ((nearestLocations [position player, ["Airport", "NameVillage", "NameCity", "NameCityCapital"], 20000]) select 0)};
	};
};

//-----------------------------------