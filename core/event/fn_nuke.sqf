/*
	HVP Nuke Event
	Author: aliascartoons | Modified by Sinbane for HVP
	http://www.armaholic.com/page.php?id=30816
	Spawns a nuclear blast
*/
private ["_heliSelection","_nukePos","_radius","_damage_buildings_units","_weather_effect","_radiation","_fallout","_heliSpawnPos","_eventHeli","_pilot","_obj_nuke","_heliEndPos","_aMarkername","_aMarkername2","_nukeMarker","_nukeMarker2","_parachute","_eventheligroup","_location"];
//-----------------------------------
//-VARIABLES

_heliSelection = _this select 0;
_nukePos = _this select 1;
_radius = _this select 2;
_damage_buildings_units = _this select 3;
_weather_effect = _this select 4;
_radiation = _this select 5;
_fallout = _this select 6;

_heliSpawnPos = [_nukePos,(HVP_phase_radius + 1000),(HVP_phase_radius + 2000),0,1,0,0] call SIN_fnc_findPos;

//-----------------------------------
//-BRING IN THE NUKE!

_eventHeli = createVehicle [(selectRandom _heliSelection), [(_heliSpawnPos select 0),(_heliSpawnPos select 1),200],[], 0, "FLY"];
clearItemCargoGlobal _eventHeli;
clearMagazineCargoGlobal _eventHeli;
clearBackpackCargoGlobal _eventHeli;
clearWeaponCargoGlobal _eventHeli;
_eventHeli flyInHeight 100+(random 50);
_eventHeli setDir ((getPos _eventHeli) getDir _nukePos);

_eventheligroup = createGroup west;
_pilot = _eventheligroup createUnit ["B_Helipilot_F", [5,5,5], [], 0, "NONE"];
_pilot setcaptive true;
_pilot setskill 0;
_pilot disableAI "TARGET";
_pilot disableAI "AUTOTARGET";
_eventheligroup setBehaviour "CARELESS";
_eventheligroup setCombatMode "BLUE";
_eventheligroup allowfleeing 0;
_eventHeli lock true;
_eventHeli allowDamage false;
_pilot allowDamage false;
_pilot assignAsDriver _eventHeli;

_obj_nuke = createVehicle ["Land_Device_slingloadable_F", _heliSpawnPos,[], 0, "CAN COLLIDE"];
_eventHeli setSlingLoad _obj_nuke;

_pilot moveindriver _eventHeli;
_pilot doMove _nukePos;
_eventheligroup setSpeedMode "FULL";

waitUntil {(_eventHeli distance2D _nukePos) < 100 && unitReady _pilot || !alive _eventHeli};
if (!alive _eventHeli) exitWith {};
{ropeCut [_x, 0.5]} forEach (ropes _eventHeli);

//B_Parachute_02_F
_parachute = createVehicle ["NonSteerable_Parachute_F",[0,0,50], [], 0, "FLY"];
sleep 0.5;
_parachute setPosATL [(getPosATL _obj_nuke select 0), (getPosATL _obj_nuke select 1), (getPosATL _obj_nuke select 2)];
_obj_nuke attachTo [_parachute,[0,0,0.5]];

//-----------------------------------
//-FIND END LOCATION FOR HELI

_heliEndPos = [HVP_phase_pos,(HVP_phase_radius + 2000),(HVP_phase_radius + 4000),0,1,0,0] call SIN_fnc_findPos;
_pilot doMove _heliEndPos;

[_pilot,_eventHeli,_nukePos] spawn {
	_pilot = _this select 0;
	_eventHeli = _this select 1;
	_nukePos = _this select 2;
	waitUntil {_eventHeli distance _nukePos > (HVP_phase_radius + 1500) || !alive _eventHeli};
	deleteVehicle _eventHeli;
	deleteVehicle _pilot;
};

waitUntil {(getPos _obj_nuke select 2) < 1 && velocityModelSpace _obj_nuke isEqualTo [0,0,0]};
sleep 3;

//-----------------------------------
//-MARKER

_aMarkername = format["nuke%1",(getPos _obj_nuke)];
_nukeMarker = createMarker [_aMarkername, (getPos _obj_nuke)];
_nukeMarker setMarkerShape "ELLIPSE";
_nukeMarker setMarkerBrush "Grid";
_nukeMarker setMarkerColor "ColorOrange";
_nukeMarker setMarkerSize [_radius,_radius];
_nukeMarker setMarkerAlpha 1;

_aMarkername2 = format["nuke2%1",(getPos _obj_nuke)];
_nukeMarker2 = createMarker [_aMarkername2, (getPos _obj_nuke)];
_nukeMarker2 setMarkerShape "ICON";
_nukeMarker2 setMarkerType "MinefieldAP";
_nukeMarker2 setMarkerColor "colorIndependent";
_nukeMarker2 setMarkerSize [0.75,0.75];
_nukeMarker2 setMarkerAlpha 1;

{titleText ["NUCLEAR DEVICE DETECTED", "PLAIN DOWN", 0.5];} remoteExec ["bis_fnc_call", 0];
"WARNING: A nuclear device has been located in the orange area marked by a green skull. It will detonate in approx 2 minutes." remoteExec ["systemChat", 0];
true remoteExec ["showChat", 0];
sleep 60;
"WARNING: A nuclear device has been located in the orange area marked by a green skull. It will detonate in approx 1 minute." remoteExec ["systemChat", 0];
true remoteExec ["showChat", 0];
sleep 60;

//-----------------------------------
//-FIRE AT WILL!

[_obj_nuke,_radius] remoteExec ["HVP_fnc_nukeFXignite", 0];

hideObjectGlobal _obj_nuke;

if (_weather_effect) then {
	[] remoteExec ["HVP_fnc_nukeFXweather", 0];
	//[] remoteExec ["HVP_fnc_nukeFXfog", 0];
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

_nukeMarker setMarkerAlpha 0.33;
_nukeMarker setMarkerColor "ColorOrange";
_nukeMarker setMarkerBrush "Solid";
deleteMarker _nukeMarker2;

_location = createLocation ["NameVillage", (getPos _obj_nuke), _radius, _radius];
_location setText "Radiation Zone";

//-----------------------------------

if (HVPZombieMode isEqualTo 1) then {
	private ["_zPos","_count"];
	for "_count" from 1 to 4 do {
		_zPos = [(getMarkerPos _nukeMarker),0,_radius,0,0,0,0] call SIN_fnc_findPos;
		[_zPos] spawn Z_fnc_setSpawn;
	};
};

//-----------------------------------