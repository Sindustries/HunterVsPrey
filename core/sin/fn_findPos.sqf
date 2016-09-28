/*
	fn_findPos
	Author: Sinbane
	Finds a random location
*/
private ["_errorPos","_posFound","_return"];
//-----------------------------------
params [
    ["_pos",[]],
    ["_minDist",10],
    ["_maxDist",100],
    ["_objDist",0.2],
	["_water",0],
	["_maxGrad",0],
	["_shore",0]
];

_errorPos = (getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition"));

//-----------------------------------

_posFound = false;
while {!_posFound} do {
	_return = [_pos,_minDist,_maxDist,_objDist,_water,_maxGrad,_shore] call BIS_fnc_findSafePos;	
	if ((_return select 0) != (_errorPos select 0) && (_return select 1) != (_errorPos select 1)) then {
		_posFound = true;
	};
};

_return;
	
//-----------------------------------