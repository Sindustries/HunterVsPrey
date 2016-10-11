/* 
	fn_proximity
	By Sinbane
	Enables player stamina when they get close enough to other players of certain sides
*/
private ["_warnDist","_stamEnableDist","_stamDrainDist","_proxSides","_proxPlayer","_curStam"];
waitUntil {time > 0};
player enableStamina false;
//-----------------------------------
//-VARIABLES

_warnDist = ["PROXwarnDist"] call HVP_fnc_getSetting;
_stamEnableDist = ["PROXstamEnableDist"] call HVP_fnc_getSetting;
_stamDrainDist = ["PROXstamDrainDist"] call HVP_fnc_getSetting;

if (count (_this select 0) > 0) then {
	_proxSides = _this select 0;
} else {
	_proxSides = [WEST,EAST,RESISTANCE];
};

player setVariable ["isFatigueFree",false];
HVP_proximityPlayer = [];
HVP_proximityActive = false;

HVP_proximityChecker = {
//-----------------------------------
	
	private ["_proxPlayer","_warnDist","_stamEnableDist","_stamDrainDist"];
	_proxPlayer = _this select 0;
	_warnDist = _this select 1;
	_stamEnableDist = _this select 2;
	_stamDrainDist = _this select 3;
	
	if (!alive _proxPlayer) exitWith {};
	if (isNull _proxPlayer) exitWith {};
	
	player enableStamina false;
	
	if (alive _proxPlayer) then {
		//Player is outside of the warn distance
		if (player distance _proxPlayer > _warnDist && !HVP_proximityActive) then {
			player enableStamina false;
		};
		
		//Player inside warn distance
		if ((player distance _proxPlayer) < _warnDist && !HVP_proximityActive) then {
			HVP_proximityActive = true;
			enableCamShake true;
			addCamShake [1, 6, 33];
			
			if (HVP_proximityActive) then {
				//Player outside warn distance -> disable
				if ((player distance _proxPlayer) > _warnDist) then {
					HVP_proximityActive = false;
					player enableStamina false;
				};
				//Less than stamina enable distance
				if ((player distance _proxPlayer) < _stamEnableDist && (!(player getVariable ["isFatigueFree",false]))) then {
					player enableStamina true;
					//Less than stamina drain distance
					if ((player distance _proxPlayer) < _stamDrainDist) then {
						_curStam = getStamina player;
						if ((speed player) > 0) then {
							player setStamina (_curStam - 1);
						} else {
							player setStamina (_curStam - 2);
						};
						sleep 0.1;
					};
				};
			};
		};
	};
	
	sleep 3;
	[_proxPlayer,_warnDist,_stamEnableDist,_stamDrainDist] spawn HVP_proximityChecker;
};
//-----------------------------------
{
	if (isPlayer _x && (side _x in _proxSides) && _x != player) then {
		HVP_proximityPlayer pushBack _x;
	};
} forEach playableUnits;

{
	[_x,_warnDist,_stamEnableDist,_stamDrainDist] spawn HVP_proximityChecker;
} forEach HVP_proximityPlayer;

[] spawn {
	while {alive player} do {
		if (loadAbs player >= 1000 && !isStaminaEnabled player) then {
			systemChat "WARNING: You are carrying too much and will be unable to run when stamina is enabled!";
			showChat true;
		};
		sleep 10;
	};
};

//-----------------------------------