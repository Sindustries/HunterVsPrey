//-----------------------------------
//-CALL THE AIRDROP
private ["_posFound","_dropPos","_posCheck","_heliSpawnPos"];

(findDisplay 46) displayRemoveEventHandler ["KeyDown", SIN_abilityDEH];

_dropPos = getPos Player;

_posFound = false;
while {!_posFound} do {
	_dropPos = (getPos Player);
	_posCheck = [_dropPos] call SIN_fnc_checkPos;
	if (_posCheck) then {
		_heliSpawnPos = [HVP_phase_pos,(HVP_phase_radius * 1.25),(HVP_phase_radius * 1.5),0,1,100,0] call BIS_fnc_findSafePos;
		_posCheck = [_heliSpawnPos] call SIN_fnc_checkPos;
		if (_posCheck) then {
			_posFound = true;
			titleText ["SUPPLY DROP INCOMING", "PLAIN DOWN", 0.5];
			["ability",_dropPos,_heliSpawnPos] call HVP_fnc_airdrop;
		};
	};
};

titleText ["SUPPLY DROP DEPLOYED", "PLAIN DOWN", 0.5];

//-----------------------------------
//-ADD AT NEXT PHASE

["SupplyDrop"] spawn HVP_fnc_addAbility;	