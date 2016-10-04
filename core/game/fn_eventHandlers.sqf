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

if (HVPGameType isEqualTo 1) then {
	player addEventHandler ["InventoryOpened", {
		private ["_unit","_container"];
		_unit = _this select 0;
		_container = _this select 1;
		
		if (_container isKindOf "man" && !alive _container && side (group _container) != side _unit) exitWith {
			[] spawn {
				waitUntil {dialog};
				closeDialog 106;
				titleText ["YOU CAN'T LOOT THE ENEMY TEAM!", "PLAIN DOWN", 3];
			};
		};
	}];
};

//-----------------------------------
//-LOCATION DISPLAY

[] spawn {
	private ["_loc","_now","_hour","_min","_time"];
	waitUntil {sleep 5; HVP_phase_num isEqualTo 1};
	while {alive player} do {
		_loc = text ((nearestLocations [position player, ["Airport", "NameLocal", "NameVillage", "NameCity", "NameCityCapital", "NameMarine"], 20000]) select 0);
		_now = date;
		_hour = (_now select 3);
		_min = (_now select 4);
		if (_min < 10) then {
			_min = format["0%1",(_now select 4)];
		};
		_time = format["%1:%2",_hour,_min];
		[_time, _loc] spawn BIS_fnc_infoText;
		waitUntil {sleep 1; _loc != _loc};
	};
};

//-----------------------------------