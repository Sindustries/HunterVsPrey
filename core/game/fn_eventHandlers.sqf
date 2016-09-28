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