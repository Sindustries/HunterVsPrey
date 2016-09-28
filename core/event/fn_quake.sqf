
	private ["_pos","_quakemarker","_buildings","_holders"];

	_pos = _this select 0;
	
	_quakemarker = createMarker ["quakeMarker", _pos];
	_quakemarker setMarkerShape "ICON";
	_quakemarker setMarkerType "hd_warning";
	_quakemarker setMarkerColor "ColorOpfor";
	_quakemarker setMarkerSize [1,1];
	_quakemarker setMarkerAlpha 1;
	
	{titleText ["EARTHQUAKE INCOMING", "PLAIN DOWN", 0.5];} remoteExec ["bis_fnc_call", 0];
	"WARNING: Earthquake Incoming! If you're near the epicenter, get away from any buildings!" remoteExec ["systemChat", 0];
	true remoteExec ["showChat", 0];
	["HUDquakeLayer","HVPHUDquakeImg"] remoteExec ["HVP_fnc_showEventIcon", 0];
	
	sleep 60 + (random 60);
	
	[_pos] remoteExec ["HVP_fnc_quakeFX", 0];
	
	sleep 4;
	
	_buildings = nearestObjects [_pos,["building"], 200];
	_holders = nearestObjects [_pos,["GroundWeaponHolder"], 200];
	{_x setDamage 1} forEach _buildings;
	{deleteVehicle _x} forEach _holders;
	
	sleep 15;
	
	deletemarker _quakemarker;
	["HUDquakeLayer"] remoteExec ["HVP_fnc_hideEventIcon", 0];