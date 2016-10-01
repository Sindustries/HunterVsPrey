/*
	fn_zDeleter
	Author: Sinbane
	Deletes zombies further than a distance from players
*/
if (HVP_zombieCount >= HVP_maxZombies) exitWith {};
private ["_pos","_zombieCount","_zombie","_group","_posFound","_spawnPos","_posCheck"];
//-----------------------------------

	_pos = _this select 0;
	_maxNum = _this select 1;
	_group = createGroup resistance;
		
	for "_zombieCount" from 0 to (floor(random _maxNum)+1) do {
		if (HVP_zombieCount <= HVP_maxZombies) then {
			_spawnPos = [_pos,0,50,0,0,0,0] call SIN_fnc_findPos;
			if ((random 100) < HVP_zBossChance) then {
				_zombie = _group createUnit [(selectRandom HVP_BossZombies), _spawnPos, [], 0, "NONE"];
			} else {
				_zombie = _group createUnit [(selectRandom HVP_Zombies), _spawnPos, [], 0, "NONE"];
			};
			_zombie switchMove "AmovPercMstpSnonWnonDnon_SaluteOut";
			HVP_zombieArray pushBack _zombie;
			HVP_zombieCount = (count HVP_zombieArray);
			publicVariable "HVP_zombieCount";
		};
	};

//-----------------------------------