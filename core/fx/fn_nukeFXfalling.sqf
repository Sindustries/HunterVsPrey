// by ALIAS
// nul = [obj_name_nuke] spawn compile preprocessFile "AlNuke\falling_nuke.sqf";

if (!isServer) exitWith {};			

	[] spawn {sleep 240; alias_fallout = false; publicVariable "alias_fallout"; };
	

	_inte = 1;
	alias_fallout = true; publicVariable "alias_fallout";
	_mark_temp = _this select 0;
	
	sleep 20;
	
while {alias_fallout} do {	

	[_mark_temp] spawn {
	_mark_dif = _this select 0;
	_factx = [-500,500] call BIS_fnc_selectRandom;
	_facty = [-500,500] call BIS_fnc_selectRandom;
	_factz = [-100,100] call BIS_fnc_selectRandom;
	_pozit = [(getPos _mark_dif select 0) + 100+random _factx,(getPos _mark_dif select 1) + 100+random _facty, 800 + _factz];
	
	_objcar = [_pozit,(random 360),"C_Offroad_01_F", EAST] call BIS_fnc_spawnVehicle;
	
	_blow = _objcar select 0;
    _drv = driver _blow;	
	deleteVehicle _drv;
	sleep 1+random 1;
	_blow setdammage 1;
	sleep 7+random 10;
	deletevehicle _blow;
	};
	
	sleep random _inte;
	_inte = _inte + 0.1;
};