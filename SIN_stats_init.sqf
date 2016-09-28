/*
	HVP Persistent Stats
	By Sinbane
	Loads player stats
*/
//-----------------------------------
//-GET STATS
//-----------------------------------
//-HVP MODE

STAT_timesPlayedHVP = profileNamespace getVariable "STAT_timesPlayedHVP";
if (isNil {STAT_timesPlayedHVP}) then {
	profileNamespace setVariable ["STAT_timesPlayedHVP", []];
	saveProfileNamespace;
	STAT_timesPlayedHVP = profileNamespace getVariable "STAT_timesPlayedHVP";
};

STAT_timesWonHVP = profileNamespace getVariable "STAT_timesWonHVP";
if (isNil {STAT_timesWonHVP}) then {
	profileNamespace setVariable ["STAT_timesWonHVP", []];
	saveProfileNamespace;
	STAT_timesWonHVP = profileNamespace getVariable "STAT_timesWonHVP";
};

STAT_timesLostHVP = profileNamespace getVariable "STAT_timesLostHVP";
if (isNil {STAT_timesLostHVP}) then {
	profileNamespace setVariable ["STAT_timesLostHVP", []];
	saveProfileNamespace;
	STAT_timesLostHVP = profileNamespace getVariable "STAT_timesLostHVP";
};

//-----------------------------------
//-CRUCIBLE MODE

STAT_timesPlayedCRU = profileNamespace getVariable "STAT_timesPlayedCRU";
if (isNil {STAT_timesPlayedCRU}) then {
	profileNamespace setVariable ["STAT_timesPlayedCRU", []];
	saveProfileNamespace;
	STAT_timesPlayedCRU = profileNamespace getVariable "STAT_timesPlayedCRU";
};

STAT_timesWonCRU = profileNamespace getVariable "STAT_timesWonCRU";
if (isNil {STAT_timesWonCRU}) then {
	profileNamespace setVariable ["STAT_timesWonCRU", []];
	saveProfileNamespace;
	STAT_timesWonCRU = profileNamespace getVariable "STAT_timesWonCRU";
};

STAT_timesLostCRU = profileNamespace getVariable "STAT_timesLostCRU";
if (isNil {STAT_timesLostCRU}) then {
	profileNamespace setVariable ["STAT_timesLostCRU", []];
	saveProfileNamespace;
	STAT_timesLostCRU = profileNamespace getVariable "STAT_timesLostCRU";
};

//-----------------------------------
//-PREDATOR MODE

STAT_timesPlayedPRED = profileNamespace getVariable "STAT_timesPlayedPRED";
if (isNil {STAT_timesPlayedPRED}) then {
	profileNamespace setVariable ["STAT_timesPlayedPRED", []];
	saveProfileNamespace;
	STAT_timesPlayedPRED = profileNamespace getVariable "STAT_timesPlayedPRED";
};

STAT_timesWonPRED = profileNamespace getVariable "STAT_timesWonPRED";
if (isNil {STAT_timesWonPRED}) then {
	profileNamespace setVariable ["STAT_timesWonPRED", []];
	saveProfileNamespace;
	STAT_timesWonPRED = profileNamespace getVariable "STAT_timesWonPRED";
};

STAT_timesLostPRED = profileNamespace getVariable "STAT_timesLostPRED";
if (isNil {STAT_timesLostPRED}) then {
	profileNamespace setVariable ["STAT_timesLostPRED", []];
	saveProfileNamespace;
	STAT_timesLostPRED = profileNamespace getVariable "STAT_timesLostPRED";
};

//-----------------------------------
//-FNCS

STAT_addStat = {
	private ["_statName","_stat","_player","_UID","_newPlayer","_index"];
	_statName = _this select 0;
	_stat = profileNamespace getVariable _statName;
	_player = _this select 1;
	_UID = getPlayerUID _player;
	_newPlayer = true;
	
	for "_index" from 0 to (count _stat) do {
		if (((_stat select _index) select 0) isEqualTo _UID) then {
			_timesPlayed = (((_stat select _index) select 1) + 1);
			_stat deleteAt _index;
			_stat pushBackUnique [_UID,_timesPlayed];
			profileNamespace setVariable [_statName, _stat];
			_newPlayer = false;
		};
	};
	if (_newPlayer) then {
		_stat pushBack [_UID,1];
		profileNamespace setVariable [_statName, _stat];
	};
	saveProfileNamespace;
};

//-----------------------------------

STAT_showStats = {
	private ["_UID","_newPlayer","_index","_timesPlayed","_msg"];
	{
		if (isPlayer _x && side _x != sideLogic) then {
			_UID = getPlayerUID _x;
			if (HVPGameType isEqualTo 1) then {
				_newPlayer = true;
				for "_index" from 0 to (count STAT_timesPlayedHVP) do {
					if (((STAT_timesPlayedHVP select _index) select 0) isEqualTo _UID) then {
						_newPlayer = false;
						_timesPlayed = ((STAT_timesPlayedHVP select _index) select 1);
						_msg = format["You have played Hunter vs Prey %1 times.",_timesPlayed];
						_msg remoteExec ["systemChat", _x];
					};
				};
				if (_newPlayer) then {
					_msg = format["This is your first time playing Hunter vs Prey."];
					_msg remoteExec ["systemChat", _x];
				};
				for "_index" from 0 to (count STAT_timesWonHVP) do {
					if (((STAT_timesWonHVP select _index) select 0) isEqualTo _UID) then {
						_newPlayer = false;
						_timesPlayed = ((STAT_timesWonHVP select _index) select 1);
						_msg = format["You have won %1 games.",_timesPlayed];
						_msg remoteExec ["systemChat", _x];
					};
				};
				for "_index" from 0 to (count STAT_timesLostHVP) do {
					if (((STAT_timesLostHVP select _index) select 0) isEqualTo _UID) then {
						_newPlayer = false;
						_timesPlayed = ((STAT_timesLostHVP select _index) select 1);
						_msg = format["You have lost %1 games.",_timesPlayed];
						_msg remoteExec ["systemChat", _x];
					};
				};
			};
			if (HVPGameType isEqualTo 2) then {
				_newPlayer = true;
				for "_index" from 0 to (count STAT_timesPlayedCRU) do {
					if (((STAT_timesPlayedCRU select _index) select 0) isEqualTo _UID) then {
						_newPlayer = false;
						_timesPlayed = ((STAT_timesPlayedCRU select _index) select 1);
						_msg = format["You have played Crucible %1 times.",_timesPlayed];
						_msg remoteExec ["systemChat", _x];
					};
				};
				if (_newPlayer) then {
					_msg = format["This is your first time playing Crucible."];
					_msg remoteExec ["systemChat", _x];
				};
				for "_index" from 0 to (count STAT_timesWonCRU) do {
					if (((STAT_timesWonCRU select _index) select 0) isEqualTo _UID) then {
						_newPlayer = false;
						_timesPlayed = ((STAT_timesWonCRU select _index) select 1);
						_msg = format["You have won %1 games.",_timesPlayed];
						_msg remoteExec ["systemChat", _x];
					};
				};
				for "_index" from 0 to (count STAT_timesLostCRU) do {
					if (((STAT_timesLostCRU select _index) select 0) isEqualTo _UID) then {
						_newPlayer = false;
						_timesPlayed = ((STAT_timesLostCRU select _index) select 1);
						_msg = format["You have lost %1 games.",_timesPlayed];
						_msg remoteExec ["systemChat", _x];
					};
				};
			};
			if (HVPGameType isEqualTo 3) then {
				_newPlayer = true;
				for "_index" from 0 to (count STAT_timesPlayedPRED) do {
					if (((STAT_timesPlayedPRED select _index) select 0) isEqualTo _UID) then {
						_newPlayer = false;
						_timesPlayed = ((STAT_timesPlayedPRED select _index) select 1);
						_msg = format["You have played Predator %1 times.",_timesPlayed];
						_msg remoteExec ["systemChat", _x];
					};
				};
				if (_newPlayer) then {
					_msg = format["This is your first time playing Predator."];
					_msg remoteExec ["systemChat", _x];
				};
				for "_index" from 0 to (count STAT_timesWonPRED) do {
					if (((STAT_timesWonPRED select _index) select 0) isEqualTo _UID) then {
						_newPlayer = false;
						_timesPlayed = ((STAT_timesWonPRED select _index) select 1);
						_msg = format["You have won %1 games.",_timesPlayed];
						_msg remoteExec ["systemChat", _x];
					};
				};
				for "_index" from 0 to (count STAT_timesLostPRED) do {
					if (((STAT_timesLostPRED select _index) select 0) isEqualTo _UID) then {
						_newPlayer = false;
						_timesPlayed = ((STAT_timesLostPRED select _index) select 1);
						_msg = format["You have lost %1 games.",_timesPlayed];
						_msg remoteExec ["systemChat", _x];
					};
				};
			};
		};
	} forEach allUnits;
};

//-----------------------------------

STAT_statReset = {
	profileNamespace setVariable ["STAT_timesPlayedHVP", nil];
	profileNamespace setVariable ["STAT_timesWonHVP", nil];
	profileNamespace setVariable ["STAT_timesLostHVP", nil];
	profileNamespace setVariable ["STAT_timesPlayedCRU", nil];
	profileNamespace setVariable ["STAT_timesWonCRU", nil];
	profileNamespace setVariable ["STAT_timesLostCRU", nil];
	profileNamespace setVariable ["STAT_timesPlayedPRED", nil];
	profileNamespace setVariable ["STAT_timesWonPRED", nil];
	profileNamespace setVariable ["STAT_timesLostPRED", nil];
	saveProfileNamespace;
};

//-----------------------------------