/*
	HVP2 Fatigue Aura Ability Effect
	By Sinbane
	Hits player of enemy teams with max fatigue
*/
private ["_pos","_safePlayer"];
//-----------------------------------
//-EFFECT

_pos = _this select 0;
_safePlayer = _this select 1;

if (HVPGameType isEqualTo 1) then {
	if ((player distance _pos) < 80) then {
		if (side player isEqualTo WEST || side player isEqualTo RESISTANCE) then {
			if (!(player getVariable ["isFatigueFree",false])) then {
				titleText ["YOU'VE BEEN HIT BY FATIGUE AURA!", "PLAIN DOWN", 0.6];
				player setStamina 0;
			} else {
				titleText ["FATIGUE FREE PROTECTED YOU FROM FATIGUE AURA", "PLAIN DOWN", 0.6];
			};
		};
	};
};
if (HVPGameType isEqualTo 2) then {
	if ((player distance _pos) < 80 && player != _safePlayer) then {
		if (!(player getVariable ["isFatigueFree",false])) then {
			titleText ["YOU'VE BEEN HIT BY FATIGUE AURA!", "PLAIN DOWN", 0.6];
			player setStamina 0;
		} else {
			titleText ["FATIGUE FREE PROTECTED YOU FROM FATIGUE AURA", "PLAIN DOWN", 0.6];
		};
	};
};
if (HVPGameType isEqualTo 3) then {
	if ((player distance _pos) < 80 && playerSide != (side _safePlayer)) then {
		if (!(player getVariable ["isFatigueFree",false])) then {
			titleText ["YOU'VE BEEN HIT BY FATIGUE AURA!", "PLAIN DOWN", 0.6];
			player setStamina 0;
		} else {
			titleText ["FATIGUE FREE PROTECTED YOU FROM FATIGUE AURA", "PLAIN DOWN", 0.6];
		};
	};
};