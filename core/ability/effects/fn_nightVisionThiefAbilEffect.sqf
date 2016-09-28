/*
	HVP2 Night Vision Thief Ability Effect
	By Sinbane
	Removes NVG's from nearby enemies temporarily and gives nearby friendlies temporary night vision
*/
private ["_pos","_time","_counter","_timer","_minTime","_maxTime"];
//-----------------------------------
//-EFFECT

_pos = _this select 0;

_minTime = ["nightVisionThiefMinTime"] call HVP_fnc_getSetting;
_maxTime = ["nightVisionThiefMaxTime"] call HVP_fnc_getSetting;
_time = (_minTime + random(_maxTime - _minTime));

if ((player distance _pos) < 80) then {
	if (side player == EAST) then {
		if (player isKindOf "O_spotter_F") then {
			player removeItem "NVGoggles_blk_F";
		} else {
			player removeItem "NVGoggles_OPFOR";
		};
		titleText ["YOU'VE BEEN HIT BY NIGHT VISION THIEF!", "PLAIN DOWN", 0.6];
		
		[_time] call HVP_fnc_progressBar;
		
		if (player isKindOf "O_spotter_F") then {
			player linkItem "NVGoggles_blk_F";
		} else {
			player linkItem "NVGoggles_OPFOR";
		};
	};

	if (side player == WEST) then {	
		player action ["GunLightOff", player];
		player action ["nvGoggles", player];
		titleText ["TEMPORARY NIGHT VISION", "PLAIN DOWN", 0.6];
				
		[_time] call HVP_fnc_progressBar;

		player action ["nvGogglesOff", player];
	};
};