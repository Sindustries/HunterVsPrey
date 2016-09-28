/*
	HVP Chemical Attack Event
	Author: Sinbane
	Covers an area in toxic gas
*/
private ["_pos","_size","_gasCount","_aMarkername","_aMarkername2","_chemMarker","_chemMarker2","_gas","_smoke","_smokepos"];
//-----------------------------------
//-SETTINGS

_pos = _this select 0;
_size = _this select 1;
_gasCount = _this select 2;

//-----------------------------------
//-SPAWN MARKER ON POS

_aMarkername = format["ChemEventMarker: %1",(_pos select 0)];
_chemMarker = createMarker [_aMarkername, _pos];
_chemMarker setMarkerShape "ELLIPSE";
_chemMarker setMarkerBrush "Grid";
_chemMarker setMarkerColor "ColorUnknown";
_chemMarker setMarkerSize [(_size + 25),(_size + 25)];
_chemMarker setMarkerAlpha 0.7;

_aMarkername2 = format["ChemEventMarker2: %1",(_pos select 0)];
_chemMarker2 = createMarker [_aMarkername2, _pos];
_chemMarker2 setMarkerShape "ICON";
_chemMarker2 setMarkerType "MinefieldAP";
_chemMarker2 setMarkerColor "ColorRed";
_chemMarker2 setMarkerSize [0.75,0.75];
_chemMarker2 setMarkerAlpha 1;

{titleText ["CHEMICAL ATTACK COMMENCING", "PLAIN DOWN", 0.5];} remoteExec ["bis_fnc_call", 0];
"WARNING: A Chemical Attack is about to commence on the area marked by a red skull. You'll be safe from it if you have the correct protection!" remoteExec ["systemChat", 0];
["HUDchemLayer","HVPHUDchemImg"] remoteExec ["HVP_fnc_showEventIcon", 0];

sleep 20 + (random 30);

//-----------------------------------
//-SPAWN THE GAS

for "_gas" from 0 to _gasCount do {
	_smokepos = [(_pos select 0)+(random _size)-(random _size),(_pos select 1)+(random _size)-(random _size), 0];
	_smoke = createVehicle ["SmokeShellRed", [_smokepos select 0, _smokepos select 1, (random 100)], [], 0, "NONE"];
	if (HVPGameType == 1) then {
		_smokepos = [(_pos select 0)+(random _size)-(random _size),(_pos select 1)+(random _size)-(random _size), 0];
		_smoke = createVehicle ["SmokeShellBlue", [_smokepos select 0, _smokepos select 1, (random 100)], [], 0, "NONE"];
	};
	sleep (random 1);
};

if (HVPZombieMode isEqualTo 1) then {
	[_pos] spawn z_fnc_setSpawn;
};

//-----------------------------------

sleep 60;
	
deleteMarker _chemMarker;
deleteMarker _chemMarker2;
["HUDchemLayer"] remoteExec ["HVP_fnc_hideEventIcon", 0];

//-----------------------------------