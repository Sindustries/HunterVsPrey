/* 
	HVP2 Paranormal Activity Event Script
	By Sinbane
*/
//waitUntil {HVP_phase_active isEqualTo "true"};
private ["_eventRoll","_event"];
//-----------------------------------
//-TEAM MODE
if (HVPGameType isEqualTo 1) then {
//-----------------------------------
//-BEGIN LOOP
while {alive player} do {
//-----------------------------------
//-ROLL FOR EVENT

sleep (HVPEventTime*2+(random HVPEventTime)-(random HVPEventTime));

if (daytime > 18 || daytime < 6) then {
	if (vehicle player isEqualTo player) then {

		_eventRoll = floor (random 4);

		if (_eventRoll isEqualTo 0) then {
			if (side player isEqualTo WEST || side player isEqualTo RESISTANCE) then {
				_event = execVM "fn\event\paranormal\1ghost.sqf";
				waitUntil {scriptDone _event};
			};
			if (side player isEqualTo EAST) then {
				_event = execVM "fn\event\paranormal\1teleport.sqf";
				waitUntil {scriptDone _event};
			};
		};
		if (_eventRoll isEqualTo 1) then {
			if (side player isEqualTo WEST || side player isEqualTo RESISTANCE) then {
				_event = execVM "fn\event\paranormal\2decoy.sqf";
				waitUntil {scriptDone _event};
			};
			if (side player isEqualTo EAST) then {
				_event = execVM "fn\event\paranormal\2darkness.sqf";
				waitUntil {scriptDone _event};
			};
		};
		if (_eventRoll isEqualTo 2) then {
			player additem "ACE_Banana";
		};
		if (_eventRoll isEqualTo 3) then {
			_event = execVM "fn\event\paranormal\ghostchat.sqf";
		};
	};
};

//-----------------------------------
//-STOP LOOP
};};
//-----------------------------------
//-CRUCIBLE MODE
if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
//-----------------------------------
//-BEGIN LOOP
while {alive player} do {
//-----------------------------------
//-ROLL FOR EVENT

sleep (HVPEventTime*2+(random HVPEventTime)-(random HVPEventTime));

if (daytime > 18 || daytime < 6) then {
	if (vehicle player isEqualTo player) then {

		_eventRoll = floor (random 6);

		if (_eventRoll isEqualTo 0) then {
			_event = execVM "fn\event\paranormal\1ghost.sqf";
			waitUntil {scriptDone _event};
		};
		if (_eventRoll isEqualTo 1) then {
			_event = execVM "fn\event\paranormal\1teleport.sqf";
			waitUntil {scriptDone _event};
		};
		if (_eventRoll isEqualTo 2) then {
			_event = execVM "fn\event\paranormal\2decoy.sqf";
			waitUntil {scriptDone _event};
		};
		if (_eventRoll isEqualTo 3) then {
			_event = execVM "fn\event\paranormal\2darkness.sqf";
			waitUntil {scriptDone _event};
		};
		if (_eventRoll isEqualTo 4) then {
			player additem "ACE_Banana";
		};
		if (_eventRoll isEqualTo 5) then {
			_event = execVM "fn\event\paranormal\ghostchat.sqf";
			waitUntil {scriptDone _event};
		};
	};
};

//-----------------------------------
//-STOP LOOP
};};