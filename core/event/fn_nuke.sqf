/*
	HVP Nuke Event
	Author: aliascartoons | Modified by Sinbane for HVP
	http://www.armaholic.com/page.php?id=30816
	Spawns a nuclear blast
*/
private ["_aMarkername","_nukeMarker","_nukeMarker2","_obj_nuke","_radius","_damage_buildings_units","_weather_effect","_radiation","_fallout"];
//-----------------------------------
//-VARIABLES

_obj_nuke = _this select 0;
_radius = _this select 1;
_damage_buildings_units = _this select 2;
_weather_effect = _this select 3;
_radiation = _this select 4;
_fallout = _this select 5;

//-----------------------------------
//-MARKER

_aMarkername = format["nuke%1",(getPos _obj_nuke)];
_nukeMarker = createMarker [_aMarkername, _obj_nuke];
_nukeMarker setMarkerShape "ELLIPSE";
_nukeMarker setMarkerBrush "Grid";
_nukeMarker setMarkerColor "ColorOpfor";
_nukeMarker setMarkerSize [(_radius + 25),(_radius + 25)];
_nukeMarker setMarkerAlpha 1;

_aMarkername2 = format["%1",(getPos _obj_nuke)];
_nukeMarker2 = createMarker [_aMarkername2, _obj_nuke];
_nukeMarker2 setMarkerShape "ICON";
_nukeMarker2 setMarkerType "MinefieldAP";
_nukeMarker2 setMarkerColor "colorIndependent";
_nukeMarker2 setMarkerSize [0.75,0.75];
_nukeMarker2 setMarkerAlpha 1;

{titleText ["NUCLEAR LAUNCH DETECTED", "PLAIN DOWN", 0.5];} remoteExec ["bis_fnc_call", 0];
"WARNING: A nuclear bomb is incoming to the red area marked by a green skull. The area will be decimated in approx 2 minutes." remoteExec ["systemChat", 0];
true remoteExec ["showChat", 0];
sleep 60;
"WARNING: A nuclear bomb is incoming to the red area marked by a green skull. The area will be decimated in approx 1 minute." remoteExec ["systemChat", 0];
true remoteExec ["showChat", 0];
sleep 60;

//-----------------------------------
//-FIRE AT WILL!


[_obj_nuke,_radius] remoteExec ["HVP_fnc_nukeFXignite", 0];

if (_weather_effect) then {
	[] remoteExec ["HVP_fnc_nukeFXweather", 0];
	[] remoteExec ["HVP_fnc_nukeFXfog", 0];
};
if (_damage_buildings_units) then {
	[_obj_nuke,_radius] spawn HVP_fnc_nukeFXdamage;
};
if (_radiation) then {
	[_obj_nuke,_radius] remoteExec ["HVP_fnc_nukeFXrad", 0];
};
if (_fallout) then {
	[] remoteExec ["HVP_fnc_nukeFXash", 0];
};
[_obj_nuke] spawn HVP_fnc_nukeFXfalling;

//-----------------------------------

_nukeMarker setMarkerAlpha 0.33;
//_nukeMarker2 setMarkerAlpha 0.33;

if (HVPZombieMode isEqualTo 1) then {
	[(getMarkerPos _nukeMarker)] spawn Z_fnc_setSpawn;
	[(getMarkerPos _nukeMarker)] spawn Z_fnc_setSpawn;
	[(getMarkerPos _nukeMarker)] spawn Z_fnc_setSpawn;
	[(getMarkerPos _nukeMarker)] spawn Z_fnc_setSpawn;
};

//-----------------------------------