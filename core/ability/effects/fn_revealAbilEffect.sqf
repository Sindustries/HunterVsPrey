
	private ["_aMarkername","_aMarker","_markerPos"];

	{
		if (side _x == sideLogic) exitWith {};
		if (isPlayer _x && _x != player && alive _x) then {
			_aMarkername = format["%1",(getPos _x)];
			_aMarker = createMarkerLocal [str(_aMarkername),[0,0]];
			_markerPos = [(getPos _x),0,200,0,1,9999,0] call BIS_fnc_findSafePos;
			_aMarker setMarkerPosLocal _markerPos;
			_aMarker setMarkerShapeLocal "ELLIPSE";
			_aMarker setMarkerSizeLocal [100,100];
			_aMarker setMarkerAlphaLocal 0.6;					
			_aMarker setMarkerColorLocal "colorOpfor";			
			[_aMarker] spawn {
				private ["_aMarker"];
				_aMarker = _this select 0;
				sleep 300 +(random 600);
				deleteMarkerLocal _aMarker;
			};
		};
	} forEach allUnits;