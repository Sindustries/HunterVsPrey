/*
	HVP Mine Detector Script
	Author: Sinbane
	Plays a beeping sound when player is near a mine (with correct equipment)
*/
private ["_scanSize","_scanTime","_mines","_cfg","_cfgName","_mineScan","_mine"];
//-----------------------------------
//-CONFIG

_scanSize = 30;
_scanTime = 3;

//-----------------------------------
//-OPEN LOOP
while {alive player} do {
//-----------------------------------
	
	waitUntil {sleep 3; "MineDetector" in (items player)};
	
	while {"MineDetector" in (items player)} do {
		
		_mineScan = [nearestObject [player,"MineBase"],nearestObject [player,"TimeBombCore"]];
		_mine = [_mineScan,[],{_x distance player},"ASCEND",{!isNull _x}] call BIS_fnc_sortBy select 0;
		if (!(isNil "_mine")) then {
			if (player distance _mine <= _scanSize && player distance _mine > (_scanSize * 0.66)) then {
				playSound "beep_target";
				sleep (_scanTime/2);
			};
			if (player distance _mine <= (_scanSize * 0.66) && player distance _mine > (_scanSize * 0.33)) then {
				playSound "beep_target";
				sleep (_scanTime/3);
			};
			if (player distance _mine <= (_scanSize * 0.33) && player distance _mine > (_scanSize * 0.1)) then {
				playSound "beep_target";
				sleep (_scanTime/4);
			};
			if (player distance _mine <= (_scanSize * 0.1)) then {
				playSound "beep_target";
				sleep (_scanTime/5);
			};
		} else {
			sleep _scanTime;
		};
	};

//-----------------------------------
//-CLOSE LOOP
};