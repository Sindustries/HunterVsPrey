/*
	fn_spawnZombies
	Author: Sinbane
	Spawn the zombees!
*/
if ((count HVP_zombieArrayClient) >= HVP_maxZombies) exitWith {};
private ["_pos","_zombieCount","_zombie","_group","_exclusions","_spawnPos"];
//-----------------------------------

	_pos = _this select 0;
	_maxNum = _this select 1;
	_group = createGroup resistance;
	
	for "_zombieCount" from 0 to (floor(random _maxNum)+1) do {
		if ((count HVP_zombieArrayClient) <= HVP_maxZombies) then {
			_spawnPos = [_pos,0,50,0,0,0,0] call SIN_fnc_findPos;
			if ((random 100) < HVP_zBossChance) then {
				_zombie = _group createUnit [(selectRandom HVP_BossZombies), _spawnPos, [], 0, "NONE"];
			} else {
				_zombie = _group createUnit [(selectRandom HVP_Zombies), _spawnPos, [], 0, "NONE"];
			};
			[_zombie,"AmovPercMstpSnonWnonDnon_SaluteOut"] remoteExec ["switchMove", 0];
			HVP_zombieArray pushBack _zombie;
			HVP_zombieArrayClient pushBack _zombie;
			publicVariable "HVP_zombieArray";
		};
	};

//-----------------------------------