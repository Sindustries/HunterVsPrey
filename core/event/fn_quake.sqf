
	private ["_pos","_radius","_quakemarker","_quakemarker2","_quakemarker3","_buildings","_holders"];

	_pos = _this select 0;
	_radius = _this select 1;
	
	_quakemarker = createMarker ["quakeMarker", _pos];
	_quakemarker setMarkerShape "ICON";
	_quakemarker setMarkerType "mil_dot";
	_quakemarker setMarkerColor "ColorOpfor";
	_quakemarker setMarkerSize [1,1];
	_quakemarker setMarkerAlpha 1;
	
	_quakemarker2 = createMarker ["quakeMarker2", _pos];
	_quakemarker2 setMarkerShape "ELLIPSE";
	_quakemarker2 setMarkerType "EMPTY";
	_quakemarker2 setMarkerBrush "Border";
	_quakemarker2 setMarkerColor "ColorOpfor";
	_quakemarker2 setMarkerSize [(_radius*0.5),(_radius*0.5)];
	_quakemarker2 setMarkerAlpha 1;
	
	_quakemarker3 = createMarker ["quakeMarker3", _pos];
	_quakemarker3 setMarkerShape "ICON";
	_quakemarker3 setMarkerType "EMPTY";
	_quakemarker3 setMarkerBrush "Border";
	_quakemarker3 setMarkerColor "ColorOpfor";
	_quakemarker3 setMarkerSize [_radius,_radius];
	_quakemarker3 setMarkerAlpha 1;
	
	{titleText ["EARTHQUAKE INCOMING", "PLAIN DOWN", 0.5];} remoteExec ["bis_fnc_call", 0];
	"WARNING: Earthquake Incoming! If you're near the epicenter, get away from any buildings!" remoteExec ["systemChat", 0];
	true remoteExec ["showChat", 0];
	["HUDquakeLayer","HVPHUDquakeImg"] remoteExec ["HVP_fnc_showEventIcon", 0];
	
	sleep 60 + (random 60);
	
	[_pos,_radius] remoteExec ["HVP_fnc_quakeFX", 0];
	
	sleep 4;
	
	_buildings = nearestObjects [_pos,["building"], _radius];
	_holders = nearestObjects [_pos,["GroundWeaponHolder"], _radius];
	{_x setDamage 1} forEach _buildings;
	{deleteVehicle _x} forEach _holders;
	
	sleep 15;
	
	deletemarker _quakemarker;
	deletemarker _quakemarker2;
	deletemarker _quakemarker3;
	["HUDquakeLayer"] remoteExec ["HVP_fnc_hideEventIcon", 0];