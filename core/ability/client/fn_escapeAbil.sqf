/*
	HVP Escape Ability
	Author: Sinbane
	Immediatly teleports the user to a new location	
*/
private ["_spawnFound","_pos","_posCheck"];
//-----------------------------------
//-GET POS TO TELEPORT TO

(findDisplay 46) displayRemoveEventHandler ["KeyDown", SIN_abilityDEH];

_spawnFound = false;
while {!_spawnFound} do {
	_pos = [(getPos player),(HVP_phase_radius * 0.15),(HVP_phase_radius * 0.5),1,0,0,0] call BIS_fnc_findSafePos;
	_posCheck = [_pos] call SIN_fnc_checkPos;
	if (_posCheck) then {
		if ((_pos distance2D HVP_phase_pos) < HVP_phase_radius) then {
			_spawnFound = true;
			player allowDamage false;
			sleep 0.1;
			player setPos [(_pos select 0),(_pos select 1), 0];
			sleep 0.1;
			player allowDamage true;
			titleText ["ESCAPE ACTIVATED", "PLAIN DOWN", 0.5];
		};
	};
};

//-----------------------------------
//-ADD AT NEXT PHASE

["Escape"] spawn HVP_fnc_addAbility;	