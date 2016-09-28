/*
	HVP Anti-Camp Script
	Author: Sinbane
	Places a marker on the map revealing the location of the player if they stay still/in the same area for too long
*/
private ["_timeUntil","_distance","_trackingDist","_msg","_stoppedPos","_counter","_aMarkername","_aMarker"];
//-----------------------------------
//-VARIABLES

_timeUntil = HVPAntiCamp;
_distance = 15;
_trackingDist = 100;

waitUntil {(getPos player select 2) < 1 && vehicle player isEqualTo player};
//-----------------------------------
//-OPEN LOOP
while {true} do {
//-----------------------------------

	waitUntil {sleep 1; (speed player) < 1 && HVP_phase_active isEqualTo "true"};

	_stoppedPos = (getPos player);
	
	_counter = 0;
	while {player distance _stoppedPos <= _distance} do {
		if (!alive player) exitWith {};
		if (_counter isEqualTo (_timeUntil / 2)) then {
			systemChat format["WARNING: Your location will be revealed in %1 seconds unless you leave the area",_counter];
		};
		if (_counter isEqualTo (_timeUntil - 10)) then {
			systemchat "WARNING: Your location will be revealed in 10 seconds!";
		};
		if (_counter isEqualTo _timeUntil) exitWith {
			_aMarkername = format["%1%2",(vehicleVarName player),_stoppedPos];
			_aMarker = createMarker [_aMarkername,(getPos player)];
			_aMarker setMarkerShape "ICON";
			_aMarker setMarkerSize [0.75,0.75];
			_aMarker setMarkerAlpha 0.8;
			"WARNING: Player location revealed!" remoteExec ["systemChat", 0],
			[_aMarker,_stoppedpos,_distance,_trackingDist] spawn {
				private ["_aMarker","_stoppedPos","_distance","_trackingDist"];
				_aMarker = _this select 0;
				_stoppedPos = _this select 1;
				_distance = _this select 2;
				_trackingDist = _this select 3;
				
				while {true} do {
					waitUntil {sleep 1; player distance _stoppedpos <= _trackingDist || !alive player};
					if (!alive player) exitWith {
						sleep (random 300);
						deleteMarker _aMarker;
					};
					_aMarker setMarkerType "mil_start";
					_aMarker setMarkerColor "colorOpfor";
					while {player distance _stoppedpos <= _trackingDist} do {
						_aMarker setMarkerPos (getPos player);
						_aMarker setMarkerDir (getDir player);
						sleep 1;
					};
					_aMarker setMarkerType "mil_unknown";
					_aMarker setMarkerColor "colorUnknown";
					_aMarker setMarkerDir 0;
					sleep 6;
				};
			};
			
			if (HVPZombieMode isEqualTo 1) then {
				[(getPos player)] remoteExec ["z_fnc_setSpawn", 2];
				[(getPos player)] remoteExec ["z_fnc_setSpawn", 2];
				[(getPos player)] remoteExec ["z_fnc_setSpawn", 2];
			};
			
			systemChat "WARNING: Your location has been revealed";
			systemChat "Leave the area to regain your anonimity";
		};
		sleep 1;
		_counter = _counter + 1;
	};
	waitUntil {sleep 1; player distance _stoppedPos > _distance || !alive player};
	if (!alive player) exitWith {};	

//-----------------------------------
//-CLOSE LOOP
};