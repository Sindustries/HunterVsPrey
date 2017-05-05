// by ALIAS
// nul = [obj_pozition,duration] execvm "ALfireworks\alias_rock.sqf";

if (!hasInterface) exitWith {};

sleep 0.5;

_obj = _this select 0;
_duration = _this select 1;

endf=false;

[_duration] spawn {
	_dur=_this select 0;
	sleep _dur;
	endf=true;
};


while {!endf} do {

	_lanspoint = "land_helipadempty_f" createVehicleLocal [getPosATL _obj select 0,getPosATL _obj select 1,getPosATL _obj select 2];
	_lansspark = "land_helipadempty_f" createVehicleLocal [getPosATL _obj select 0,getPosATL _obj select 1,getPosATL _obj select 2];

	_firsound = ["firework1","firework2","firework3"] call BIS_fnc_selectRandom;
	_firflut = ["fluier1","fluier2","fluier3","fluier4","fluier5","fluier6","fluier7"] call BIS_fnc_selectRandom;

// muta obiect secundar

	_h=200+random 200; // altitude
	_lanspoint setPos [getPos _obj select 0,getPos _obj select 1, _h];
	_lansspark setPos [getPos _obj select 0,getPos _obj select 1, _h-10];

	_ro =[1,0] call BIS_fnc_selectRandom;
	_ve =[1,0] call BIS_fnc_selectRandom;
	_bl =[1,0] call BIS_fnc_selectRandom;

	if ((_ro==0)and(_ve==0)and(_bl==0)) then {""} else {

// genereaza rachete cu sunet
	[_obj,_h,_firflut] call HVP_fnc_fwrRock;

// genereaza lumina
	[_obj,_ro,_ve,_bl,_h] spawn HVP_fnc_fwrLumina;

// genereaza scantei
	[_lansspark,_ro,_ve,_bl,_h] call HVP_fnc_fwrSparks;

	sleep 0.3;


	[_lanspoint, _firsound] remoteExec ["say3d", 0];

	sleep 3+random 1;
	deleteVehicle _lanspoint;
	deleteVehicle _lansspark;
	sleep 1+random 2;
	};
};