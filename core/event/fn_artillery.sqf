
	private ["_artyPos","_vehCount","_missileCount","_MLRS_vehArray","_MLRS_gunnerArray","_size","_aMarkername","_aMarkername2","_artilleryMarker","_artilleryMarker2","_MLRSgroup","_pos","_MLRS","_MLRSgunner"];
	
	_artyPos = _this select 0;
	_vehCount = _this select 1;
	_missileCount = _this select 2;
	
	_MLRS_vehArray = [];
	_MLRS_gunnerArray = [];
	
	_size = (HVP_Phase_Radius * 0.25);

	sleep 1;

	_aMarkername = format["%1",(_artyPos select 0)];
	_artilleryMarker = createMarker [_aMarkername, _artyPos];
	_artilleryMarker setMarkerShape "ELLIPSE";
	_artilleryMarker setMarkerBrush "Grid";
	_artilleryMarker setMarkerColor "ColorOpfor";
	_artilleryMarker setMarkerSize [(_size + 25),(_size + 25)];
	_artilleryMarker setMarkerAlpha 1;

	_aMarkername2 = format["%1",(_artyPos select 1)];
	_artilleryMarker2 = createMarker [_aMarkername2, _artyPos];
	_artilleryMarker2 setMarkerShape "ICON";
	_artilleryMarker2 setMarkerType "o_art";
	_artilleryMarker2 setMarkerColor "ColorOpfor";
	_artilleryMarker2 setMarkerSize [0.75,0.75];
	_artilleryMarker2 setMarkerAlpha 1;
	
	_MLRSgroup = createGroup west; 
	
	for [{_i=0}, {_i<_vehCount}, {_i=_i+1}] do {
		_pos = [HVP_phase_pos,(HVP_phase_radius * 1.1),(HVP_phase_radius * 2),3,0,0.4,0] call BIS_fnc_findSafePos;
		_MLRS = "B_MBT_01_mlrs_F" createVehicle (_pos);
		_MLRS lock true;
		_MLRS hideObjectGlobal true;
		_MLRSgunner = _MLRSgroup createUnit ["b_g_survivor_F", [5,5,5], [], 0, "NONE"];
		_MLRSgunner moveingunner _MLRS;
		_MLRS_vehArray pushBack _MLRS;
		_MLRS_gunnerArray pushBack _MLRSgunner;
	};
	
	{titleText ["ARTILLERY BARRAGE COMMENCING", "PLAIN DOWN", 0.5];} remoteExec ["bis_fnc_call", 0];
	"WARNING: Artillery Barrage incoming to the area marked by a red circle. If you are inside it, don't linger too long.." remoteExec ["systemChat", 0];
	true remoteExec ["showChat", 0];
	["HUDartyLayer","HVPHUDartyImg"] remoteExec ["HVP_fnc_showEventIcon", 0];
	
	sleep 25;
	
	for [{_i=0}, {_i<_missileCount}, {_i=_i+1}] do {
		{
			if ("12Rnd_230mm_rockets" in getArtilleryAmmo [_x]) then {		
				_x commandArtilleryFire [[(_artyPos select 0)+(random _size)-(random _size), (_artyPos select 1)+(random _size)-(random _size), 0], "12Rnd_230mm_rockets", 1];			
				sleep 6;
			};
		} forEach _MLRS_vehArray;
	};
		
	
	{deleteVehicle _x} forEach _MLRS_vehArray;
	{deleteVehicle _x} forEach _MLRS_gunnerArray;
		
	sleep 60;
	
	deleteMarker _artilleryMarker;
	deleteMarker _artilleryMarker2;
	["HUDartyLayer"] remoteExec ["HVP_fnc_hideEventIcon", 0];