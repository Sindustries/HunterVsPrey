/*
	HVP Biohazard fnc
	Author: Sinbane
*/
private ["_flare","_pos","_smoke","_smoke2","_savedGoggles"];

if (HVPGameType isEqualTo 1) then {
	for "_flare" from 0 to 30 do {
		_pos = [(getPos player),0,30,0,0,1,0] call BIS_fnc_findSafePos;		
		_smoke = createVehicle ["SmokeShellBlue", _pos, [], 0, "NONE"];
		
		if (_flare isEqualTo 6 || _flare isEqualTo 12 || _flare isEqualTo 18 || _flare isEqualTo 24 || _flare isEqualTo 30) then {
			_smoke2 = "F_20mm_Yellow" createvehicle ((_smoke) ModelToWorld [0,0,(floor (random 40))]); 
			_smoke2 setVelocity [0,0,-2];
		};
		sleep 0.1;
	};
};
if (HVPGameType isEqualTo 2) then {
	if (!(goggles player in HVP_gasMasks) || !(headgear player in HVP_gasMasks)) then {
		_savedGoggles = (goggles player);
		removeGoggles player;
		player addGoggles "G_Bandanna_tan";
		titleText ["YOU'RE PROTECTED FROM THE TOXIC GAS FOR 1 MINUTE", "PLAIN DOWN", 0.5];
		[_savedGoggles] spawn {
			sleep 60;
			removeGoggles player;
			player addGoggles (_this select 0);
		};
	};
	for "_flare" from 0 to 30 do {
		_pos = [(getPos player),0,30,0,0,1,0] call BIS_fnc_findSafePos;		
		_smoke = createVehicle ["SmokeShellRed", _pos, [], 0, "NONE"];
		
		if (_flare isEqualTo 6 || _flare isEqualTo 12 || _flare isEqualTo 18 || _flare isEqualTo 24 || _flare isEqualTo 30) then {
			_smoke2 = "F_20mm_Yellow" createvehicle ((_smoke) ModelToWorld [0,0,(floor (random 40))]); 
			_smoke2 setVelocity [0,0,-2];
		};
		sleep 0.1;
	};
};
if (HVPGameType isEqualTo 3) then {
	for "_flare" from 0 to 30 do {
		_pos = [(getPos player),0,30,0,0,1,0] call BIS_fnc_findSafePos;		
		_smoke = createVehicle ["SmokeShellRed", _pos, [], 0, "NONE"];
		
		if (_flare isEqualTo 6 || _flare isEqualTo 12 || _flare isEqualTo 18 || _flare isEqualTo 24 || _flare isEqualTo 30) then {
			_smoke2 = "F_20mm_Yellow" createvehicle ((_smoke) ModelToWorld [0,0,(floor (random 40))]); 
			_smoke2 setVelocity [0,0,-2];
		};
		sleep 0.1;
	};
};