/*
	HVP Banish Ability
	Author: Sinbane
	Immediatly teleports nearby players to a new location	
*/
private ["_safePlayer","_spawnFound","_pos","_posCheck","_abilPos"];
//-----------------------------------
//-GET POS TO TELEPORT TO

_safePlayer = _this select 0;
_abilPos = (getPos _safePlayer);

if (_safePlayer != player && player distance _abilPos <= 120 && playerSide != sideLogic) then {
	_spawnFound = false;
	while {!_spawnFound} do {
		_pos = [_abilPos,(HVP_phase_radius * 0.15),(HVP_phase_radius * 0.5),1,0,0,0] call BIS_fnc_findSafePos;
		_posCheck = [_pos] call SIN_fnc_checkPos;
		if (_posCheck) then {
			if ((_pos distance2D HVP_phase_pos) < HVP_phase_radius) then {
				_spawnFound = true;
				player allowDamage false;
				sleep 0.1;
				player setPos [(_pos select 0),(_pos select 1), 0];
				sleep 0.1;
				player allowDamage true;
				titleText ["YOU'VE BEEN BANISHED!", "PLAIN DOWN", 0.5];
			};
		};
	};
};

//-----------------------------------