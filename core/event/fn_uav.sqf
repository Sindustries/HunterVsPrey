/*
	HVP UAV Event
	Author: Sinbane
	Spawns a UAV to scout an area and reveals player locations globally until it leaves or it's shot down
*/

	private ["_uavArea","_uavSpawnPos","_uavScanSize","_uavTime","_uav","_wp","_uavUpdate"];
	
	_uavArea = _this select 0;
	_uavSpawnPos = _this select 1;
	_uavScanSize = _this select 2; //150-200
	_uavTime = _this select 3;
	_uavUpdate = _this select 4;
	
	_uav = createVehicle ["I_UAV_01_F",[_uavSpawnPos select 0,_uavSpawnPos select 1,100+(random 50)], [], 0, "FLY"];
	createVehicleCrew _uav;
	_uav flyInHeight 30+(random 70);
	
	_uav addEventHandler ["Hit",{
		(_this select 0) setDamage 1;
	}];
	
	_wp = (group _uav) addWaypoint [[(_uavArea select 0),(_uavArea select 1), 0], 0];
	_wp setWaypointType "LOITER";
	_wp setWaypointLoiterType "CIRCLE_L";
	_wp setWaypointLoiterRadius (_uavScanSize * 0.75);
	
	if (HVPDebugMode == 1) then {
		private["_uavMarkername", "_UAVMarker"];
		_uavMarkername = format["UAV%1",(getPos _uav)];
		_UAVMarker = createMarker [_uavMarkername,(getPos _uav)];
		_UAVMarker setMarkerShape "ICON";
		_UAVMarker setMarkerType "mil_triangle";
		_UAVMarker setMarkerColor "colorUnknown";
		_UAVMarker setMarkerSize [0.5,0.5];
		_UAVMarker setMarkerAlpha 0.8;
		[_uav,_UAVMarker] spawn {
			private["_uav", "_UAVMarker"];
			_uav = _this select 0;
			_UAVMarker = _this select 1;
			while {(damage _uav) < 0.7} do {
				_UAVMarker setMarkerPos (getPos _uav);
			};
			deleteMarker _UAVMarker;
		};
	};
	
	waitUntil {_uav distance2D _uavArea <= _uavScanSize || (damage _uav) >= 0.7};	
	if ((damage _uav) >= 0.7) exitWith {};
	
	{titleText ["UAV SCANNING IN PROGRESS", "PLAIN DOWN", 0.5];} remoteExec ["bis_fnc_call", 0];
	"WARNING: A rogue UAV is scanning an area, shoot it down or avoid the area" remoteExec ["systemChat", 0],
	["HUDuavLayer","HVPHUDuavImg"] remoteExec ["HVP_fnc_showEventIcon", 0];
	
	for "_timer" from 0 to _uavTime do {
		while {(damage _uav) < 1 && _uavTime > 0  && _uav distance2D _uavArea <= _uavScanSize} do {
			_playerCount = {isPlayer _x && alive _x && _x distance2D _uavArea <= _uavScanSize} count allUnits;
		
			if (_playerCount > 0) then {
				{
					if (isPlayer _x && alive _x && _x distance2D _uavArea <= _uavScanSize) then {
						private ["_aMarkername","_aMarker","_markerColor"];
						_aMarkername = format["UAVTracker: %1",(vehicleVarName _x)];
						_aMarker = createMarker [_aMarkername,(getPos _x)];
						_aMarker setMarkerShape "ICON";
						_aMarker setMarkerType "hd_objective";
						if (HVPGameType isEqualTo 1) then {
							_markerColor = [(side _x), true] call BIS_fnc_sideColor;
							_aMarker setMarkerColor _markerColor;
						};
						if (HVPGameType isEqualTo 2) then {
							_aMarker setMarkerColor "colorOpfor";
						};
						_aMarker setMarkerSize [0.75,0.75];
						_aMarker setMarkerAlpha 0.8;
						[_x,_aMarker,_uav,_uavArea,_uavScanSize,_uavUpdate] spawn {
							private ["_trackedPlayer","_aMarker","_uav","_uavArea","_uavScanSize","_uavUpdate"];
							_trackedPlayer = _this select 0;
							_aMarker = _this select 1;
							_uav = _this select 2;
							_uavArea = _this select 3;
							_uavScanSize = _this select 4;
							_uavUpdate = _this select 5;
							while {(damage _uav) < 0.7 && _uav distance2D _uavArea <= _uavScanSize && _trackedPlayer distance2D _uavArea <= _uavScanSize && alive _trackedPlayer} do {
								_aMarker setMarkerPos (getPos _trackedPlayer);
								sleep _uavUpdate;
							};
							if ((damage _uav) > 0.7 || _uav distance2D _uavArea > _uavScanSize || _trackedPlayer distance2D _uavArea > _uavScanSize || !alive _trackedPlayer) exitWith {
								deleteMarker _aMarker;
								("HUDuavLayer" call BIS_fnc_rscLayer) cutText ["","PLAIN"];
							};
						};
					};
				} forEach allUnits;
			};
			_uavTime = _uavTime - _uavUpdate;
			sleep _uavUpdate;
		};
		sleep _uavUpdate;
	};
	
	_uav setDamage 1;
	["HUDuavLayer"] remoteExec ["HVP_fnc_hideEventIcon", 0];