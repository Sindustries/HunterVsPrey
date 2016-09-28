/*
	Mission: Hunter vs Prey 2
	Author: Sinbane
	Description: Horror based Battle Royale style Team Deathmatch with custom classes, events & abilities
*/
private "_version";
_version = "7.4.9";
//-----------------------------------
waitUntil {isPlayer player};
enableSaving [false, false];
enableSentences false;
enableEnvironment false;
player enableSimulation false;
player allowDamage false;
player enableStamina false;
//-----------------------------------
//-TIME
HVPTime = (paramsArray select 1);
HVPTimeMult = (paramsArray select 2);
//-GAME
HVPGameType = (paramsArray select 4);
HVPSpawnType = (paramsArray select 5);
HVPManual = (paramsArray select 6);
HVPAbilitiesEnabled = (paramsArray select 7);
HVPPhaseType = (paramsArray select 8);
HVPPhaseSpacing = (paramsArray select 9);
HVPPhaseTime = (paramsArray select 10);
HVPZoneSizeMax = (paramsArray select 11);
//-LOOT, CARS AND EVENTS
HVPLootMode = (paramsArray select 13);
HVPLootChance = (paramsArray select 14);
HVPCarsNumber = (paramsArray select 15);
HVPEventsEnabled = (paramsArray select 16);
HVPExtEvents = (paramsArray select 17);
HVPParanormalEvent = (paramsArray select 18);
HVPEventTime = (paramsArray select 19);
//-EXTRAS
HVPZombieMode = (paramsArray select 21);
HVPAntiCamp = (paramsArray select 22);
HVPStatMode = (paramsArray select 23);
HVPTestMode = (paramsArray select 24);
HVPDebugMode = (paramsArray select 25);
/* Disable stat-saving if debug mode */
if (HVPDebugMode isEqualTo 1) then {
	HVPStatMode = 0;
};
//-----------------------------------
["HVP"] call HVP_fnc_getSettings;
SIN_adminUIDs = ["SIN_adminUIDs"] call HVP_fnc_getSetting;
HVP_music = ["HVP_music"] call HVP_fnc_getSetting;
HVP_gasMasks = ["HVP_gasMasks"] call HVP_fnc_getSetting;
HVP_mines = ["HVP_mines"] call HVP_fnc_getSetting;
HVP_redGuns = ["HVP_redGuns"] call HVP_fnc_getSetting;
HVP_redAmmo = ["HVP_redAmmo"] call HVP_fnc_getSetting;
//-----------------------------------
HVPErrorPos = (getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition"));
HVP_Pos_Found = false;
HVPZombiesLoaded = false;
HVPLootLoaded = false;
HVPCarsLoaded = false;
HVPBoatsLoaded = false;
//-----------------------------------
/* Admin Menu */
if ((getPlayerUID player) in SIN_adminUIDs) then {
	execVM "SINadmin\SIN_init.sqf";
};
//-----------------------------------
//REMOVE FUEL FROM PUMPS
{ 
	_x setFuelCargo 0;
} forEach nearestObjects [HVPErrorPos, [
	//Altis, Stratis
	"Land_FuelStation_Feed_F", "Land_fs_feed_F",
	//Tanoa
	"Land_FuelStation_01_pump_F", "Land_FuelStation_02_pump_F"
], 50000];
//-----------------------------------
player setVariable ["HVP_ready", false, true];
waitUntil {time > 0};
//-----------------------------------
if (player isKindof "B_Survivor_F" && HVPGameType isEqualTo 1 || player isKindof "O_Survivor_F" && HVPGameType isEqualTo 1) exitWith {
	["wrongslot",false] spawn BIS_fnc_endMission;
};
//-----------------------------------
cutText ["", "BLACK FADED", 999];
playMusic (selectRandom HVP_music);
//-----------------------------------
//-SET TIME OF DAY
if (isServer) then {
	if (HVPTime isEqualTo 50) then {
		HVPTime = floor(random 25);
	};
	if (HVPGameType isEqualTo 1) then {
		setDate [2015, 1, 12, HVPTime, 0];
	};
	if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
		setDate [2015, 8, 11, HVPTime, 0];	
	};
};
//-----------------------------------
//-STATS
if (isServer) then {
	private "_stats";
	if (HVPStatMode isEqualTo 1 && HVPDebugMode isEqualTo 0) then {
		_stats = execVM "SIN_stats_init.sqf";
		waitUntil {scriptDone _stats};
	};
	if (HVPStatMode isEqualTo 2) then {
		_stats = execVM "SIN_stats_init.sqf";
		waitUntil {scriptDone _stats};
		systemChat "-- SINStat: Resetting All Stats...";
		call STAT_statReset;
		systemChat "-- SINStat: Reset Complete";
	};
};
//-----------------------------------
//-ZONE SIZE AND TIME CHECK
if (isServer) then {
	private ["_allUnits","_adaptiveZoneMinSize","_adaptiveZoneMaxSize","_adaptiveZoneMinTime","_adaptiveZoneMaxTime"];
	HVP_phase_num = 0;
	HVP_phase_active = "false";
	_adaptiveZoneMinSize = ["adaptiveZoneMinSize"] call HVP_fnc_getSetting;
	_adaptiveZoneMaxSize = ["adaptiveZoneMaxSize"] call HVP_fnc_getSetting;
	_adaptiveZoneMinTime = ["adaptiveZoneMinTime"] call HVP_fnc_getSetting;
	_adaptiveZoneMaxTime = ["adaptiveZoneMaxTime"] call HVP_fnc_getSetting;
	if (HVPZoneSizeMax isEqualTo 0) then {
		_allUnits = {isPlayer _x && side _x != sideLogic} count allUnits;
		HVPZoneSizeMax = (_allUnits * 250);
		if (HVPZoneSizeMax > _adaptiveZoneMaxSize) then {
			HVPZoneSizeMax = _adaptiveZoneMaxSize;
		};
		if (HVPZoneSizeMax < _adaptiveZoneMinSize) then {
			HVPZoneSizeMax = _adaptiveZoneMinSize;
		};
	};		
	if (HVPPhaseTime isEqualTo 0) then {
		HVPPhaseTime = ((HVPZoneSizeMax * 2) / 5);
		if (HVPPhaseTime > _adaptiveZoneMaxTime) then {
			HVPPhaseTime = _adaptiveZoneMaxTime;
		};
		if (HVPPhaseTime < _adaptiveZoneMinTime) then {
			HVPPhaseTime = _adaptiveZoneMinTime;
		};
	};
	HVP_phase_radius = HVPZoneSizeMax;
	publicVariable "HVP_phase_num";
	publicVariable "HVP_phase_active";
	publicVariable "HVP_phase_radius";
	publicVariable "HVPPhaseTime";
};
//-----------------------------------
//-FIND GAME LOCATION
if (!isServer) then {
	switch (HVPManual) do {
		case 0: {
			cutText ["FINDING GAME LOCATION", "BLACK FADED", 999];
			waitUntil {HVP_Pos_Found isEqualTo true};
		};
		case 1: {
			player additem "itemMap";
			openMap [true, true];
			cutText ["", "BLACK IN", 1];
			systemChat "Waiting for Host to choose game location...";
			waitUntil {HVP_Pos_Found isEqualTo true};
			cutText ["SETTING GAME LOCATION...", "BLACK FADED", 999];
			openMap [false, false]; 
			player removeitem "itemMap";
		};
	};
};
if (isServer) then {
	switch (HVPManual) do {
		case 0: {
			cutText ["FINDING GAME LOCATION", "BLACK FADED", 999];
			HVP_Pos = [(getPos player),0,99999,0,0,0,0] call SIN_fnc_findPos;
			HVP_Pos_Found = "true";
			publicVariable "HVP_Pos_Found";		
		};
		case 1: {
			player additem "itemMap";
			[] call HVP_fnc_manual;
			player removeitem "itemMap";
		};
	};
};
cutText ["", "BLACK FADED", 999];
//-----------------------------------
//-DISPLAY WELCOME MESSAGE
switch (HVPGameType) do {
	case 1: {
		systemChat format["Welcome to Hunter vs Prey, %1",profileName];
	};
	case 2: {
		systemChat format["Welcome to Hunter vs Prey: Crucible, %1",profileName];
	};
	case 3: {
		systemChat format["Welcome to Hunter vs Prey: Predator, %1",profileName];
	};
};
systemChat format["Version: %1",_version];
if (isServer && HVPStatMode isEqualTo 1) then {
	[] spawn STAT_showStats;
};
//-----------------------------------
//-LEGACY MODE CHECK
if (isServer) then {
	if (worldName != "Altis" && worldName != "Stratis" && worldName != "Tanoa") then {
		HVPLegacyMode = 1;
		if (HVPDebugMode isEqualTo 1) then {
			systemChat format["Legacy Mode: Enabled for %2",HVPLegacyMode,worldName];
		};
	} else {
		HVPLegacyMode = 0;
		if (HVPDebugMode isEqualTo 1) then {
			systemChat format["Legacy Mode: Disabled for %2",HVPLegacyMode,worldName];
		};
	};
};
//-----------------------------------
//-SMS
["SMS"] call HVP_fnc_getSettings;
[player] call SMS_fnc_init;
//-----------------------------------
//-AMBIANCE
if (isServer) then {
	[[]] spawn HVP_fnc_tpw_core;
	[10,30,(HVPZoneSizeMax * 1.25),150,60] spawn HVP_fnc_tpw_animals;
	[90,(HVPEventTime/2),1,[20,30,50,70,80],0] spawn HVP_fnc_tpw_air;
};
//-----------------------------------
//-INIT LOOT, CARS, BOATS, ZOMBEES!
("HUDProgressBar" call BIS_fnc_rscLayer) cutRsc ["HVPHUDProgressBar","PLAIN",-1,true];
uiNameSpace getVariable "PBarProgress" ctrlSetTextColor [0.2, 0.5, 0.9, 1];

if (HVPZombieMode isEqualTo 1) then {
	cutText ["RAISING THE DEAD", "BLACK FADED", 999];
	if (isServer) then {
		["Z"] call HVP_fnc_getSettings;
		[] call z_fnc_init;
		HVPzombiesLoaded = true;
		publicVariable "HVPZombiesLoaded";
	} else {
		waitUntil {HVPZombiesLoaded isEqualTo true}
	};
};

if (HVPLootMode > 0) then {
	cutText ["LOADING LOOT", "BLACK FADED", 999];
	if (isServer) then {
		[] call HVP_fnc_lootInit;
		HVPLootLoaded = true;
		publicVariable "HVPLootLoaded";
	} else {
		waitUntil {HVPLootLoaded isEqualTo "true"};
	};
};

if (HVPCarsNumber > 0) then {
	cutText ["LOADING VEHICLES (LAND)", "BLACK FADED", 999];
	if (isServer) then {
		[HVPCarsNumber] call HVP_fnc_spawnVeh;
		HVPCarsLoaded = true;
		publicVariable "HVPCarsLoaded";
	} else {
		waitUntil {HVPCarsLoaded isEqualTo true};
	};
};

if (HVPCarsNumber > 0) then {
	cutText ["LOADING VEHICLES (SEA)", "BLACK FADED", 999];
	if (isServer) then {
		[HVPCarsNumber] call HVP_fnc_spawnBoats;
		HVPBoatsLoaded = true;
		publicVariable "HVPBoatsLoaded";
	} else {
		waitUntil {HVPBoatsLoaded isEqualTo true};
	};
};

("HUDProgressBar" call BIS_fnc_rscLayer) cutText ["","PLAIN"];
cutText ["", "BLACK FADED", 999];
//-----------------------------------
//-ZONE & EVENT MANAGERS
if (isServer) then {
	[] spawn HVP_fnc_phaseInit;
};
[] call HVP_fnc_eventManager;
//-----------------------------------
//-PLAYER LOADOUTS
cutText ["GEARING UP", "BLACK FADED", 999];
//["LOADOUT"] call HVP_fnc_getSettings;
player enableSimulation true;
[] call HVP_fnc_loadout;
player enableSimulation false;
cutText ["", "BLACK FADED", 999];
//-----------------------------------
//-INIT SPECTATORS
if (player isKindOf "VirtualSpectator_F" && !isServer) exitWith {
	[] spawn {
		private "_currentPhase";
		_currentPhase = HVP_phase_num;
		waitUntil {HVP_phase_num isEqualTo (_currentPhase + 1)};
		("HUDGUILayer" call BIS_fnc_rscLayer) cutRsc ["HVP_HUD","PLAIN"];
		("HUDPhaseLayer" call BIS_fnc_rscLayer) cutRsc ["HVPHUD_phase","PLAIN"];
	};
};
if (player isKindOf "VirtualSpectator_F" && isServer) then {
	[] spawn {
		private "_currentPhase";
		_currentPhase = HVP_phase_num;
		waitUntil {HVP_phase_num isEqualTo (_currentPhase + 1)};
		("HUDGUILayer" call BIS_fnc_rscLayer) cutRsc ["HVP_HUD","PLAIN"];
		("HUDPhaseLayer" call BIS_fnc_rscLayer) cutRsc ["HVPHUD_phase","PLAIN"];
	};
};
//-----------------------------------
//-ABILITY MANAGER
if (HVPAbilitiesEnabled isEqualTo 1) then {
	[] spawn HVP_fnc_abilityManager;
};
//-----------------------------------
//-PLAYER MARKERS
[] spawn HVP_fnc_playermarkers;
//-----------------------------------
//-PLAYER SPAWN
cutText ["PREPARING TO SPAWN", "BLACK FADED", 999];
player setVariable ["HVP_ready", true, true];
player setVariable ["HVP_spawned", false, true];

if (isServer) then {
	call HVP_fnc_findSpawns;
};
//-----------------------------------
//-WEATHER CONTROL
if (isServer) then {
	[] spawn HVP_fnc_weather;
};
//-----------------------------------
switch (HVPGameType) do {
	//-HVP SETTINGS
	case 1: {
		west setFriend [east, 0];
		west setFriend [resistance, 0];
		east setFriend [west, 0];
		east setFriend [resistance, 1];
		resistance setFriend [west, 0];
		resistance setFriend [east, 1];
	};
	//-CRUCIBLE SETTINGS
	case 2: {
		[player] join grpNull;
		west setFriend [east, 0];
		west setFriend [resistance, 0];
		east setFriend [west, 0];
		east setFriend [resistance, 0];
		resistance setFriend [west, 0];
		resistance setFriend [east, 0];
	};
	//-PREDATOR SETTINGS
	case 3: {
		private "_grp";
		west setFriend [east, 1];
		west setFriend [resistance, 0];
		east setFriend [west, 1];
		east setFriend [resistance, 0];
		resistance setFriend [west, 0];
		resistance setFriend [east, 0];
		
		_grp = createGroup WEST;
		sleep 1;
		{
			if (isPlayer _x) then {
				if (side _x isEqualTo WEST || side _x isEqualTo EAST) then {
					[_x] joinSilent grpNull;
					sleep 0.1;
					[_x] joinSilent _grp;
				};
			};
		} forEach allUnits;	
	};
};
[] call HVP_fnc_knockOutGun;
[] spawn HVP_fnc_mineDetector;
[] spawn HVP_fnc_toxicGas;
//-----------------------------------
waitUntil {(player getVariable "HVP_spawned") isEqualTo true};
//-----------------------------------
playMusic "";
sleep 3;
waitUntil {(player getVariable "SMS_isUnconscious") isEqualTo false};
player setCustomAimCoef 0.75;
player enableSimulation true;
enableEnvironment true;
cutText ["", "BLACK IN", 5];
//-----------------------------------
//-HUD Elements
[] spawn {
	private "_currentPhase";
	_currentPhase = HVP_phase_num;
	waitUntil {HVP_phase_num isEqualTo (_currentPhase + 1)};
	("HUDGUILayer" call BIS_fnc_rscLayer) cutRsc ["HVP_HUD","PLAIN",-1,false];
	("HUDAbilLayer" call BIS_fnc_rscLayer) cutRsc ["HVPHUD_ability","PLAIN",-1,false];
	("HUDPhaseLayer" call BIS_fnc_rscLayer) cutRsc ["HVPHUD_phase","PLAIN",-1,false];
	
	if (HVPPhaseType isEqualTo 2) then {
		uiNameSpace getVariable "HVP_HUD_AbilTitle" ctrlSetText "WAITING";
		uiNameSpace getVariable "HVP_HUD_AbilTitle" ctrlSetTextColor [0, 0, 1, 1];
	};
};
//-----------------------------------
//-BIG WELCOME TEXT
if (HVPDebugMode isEqualTo 0) then {
	playSound "intro";
	sleep 1;
	switch (HVPGameType) do {
		case 1: {
			[
				[
					["Welcome to Hunter vs Prey","<t align = 'center' color='#F79727' shadow = '1' size = '1.0' font='PuristaBold'>%1</t><br/>", 20],
					["by Sinbane","<t align = 'center' shadow = '1' size = '0.8'>%1</t>", 15]
				]
			] spawn BIS_fnc_typeText;
		};
		case 2: {
			[
				[
					["Welcome to Hunter vs Prey: Crucible","<t align = 'center' color='#F79727' shadow = '1' size = '1.0' font='PuristaBold'>%1</t><br/>", 20],
					["by Sinbane","<t align = 'center' shadow = '1' size = '0.8'>%1</t>", 15]
				]
			] spawn BIS_fnc_typeText;
		};
		case 3: {
			[
				[
					["Welcome to Hunter vs Prey: Predator","<t align = 'center' color='#F79727' shadow = '1' size = '1.0' font='PuristaBold'>%1</t><br/>", 20],
					["by Sinbane","<t align = 'center' shadow = '1' size = '0.8'>%1</t>", 15]
				]
			] spawn BIS_fnc_typeText;
		};
	};
};
//-----------------------------------
//-PLAYER START
[] spawn {
	waitUntil {sleep 1; (getPos player select 2) < 1};
	sleep 1.5;
	player allowDamage true;
	if (playerSide isEqualTo resistance) then {
		if (HVPGameType isEqualTo 1 || HVPGameType isEqualTo 2) then {
			player addRating -10000;
		};
	};
	[] spawn HVP_fnc_sideTasks;
	switch (HVPGameType) do {
		case 1: {
			maintask = player createSimpleTask ["maintask"];
			maintask setSimpleTaskDescription ["Kill all enemies to crown your team champions of the games","Win The Games",""];
			maintask setTaskState "Assigned";
			["TaskAssigned",["","Win The Games"]] call bis_fnc_showNotification;
		};
		case 2: {
			maintask = player createSimpleTask ["maintask"];
			maintask setSimpleTaskDescription ["Kill everyone else to crown yourself Champion of the Crucible","Win The Games",""];
			maintask setTaskState "Assigned";
			["TaskAssigned",["","Win The Games"]] call bis_fnc_showNotification;
		};
		case 3: {
			if (playerSide != RESISTANCE) then {
				maintask = player createSimpleTask ["maintask"];
				maintask setSimpleTaskDescription ["Kill The Predator","Win The Games",""];
				maintask setTaskState "Assigned";
				["TaskAssigned",["","Win The Games"]] call bis_fnc_showNotification;
			};
			if (playerSide isEqualTo RESISTANCE) then {
				maintask = player createSimpleTask ["maintask"];
				maintask setSimpleTaskDescription ["Kill The Prey","Win The Games",""];
				maintask setTaskState "Assigned";
				["TaskAssigned",["","Win The Games"]] call bis_fnc_showNotification;
			};
		};
	};
	if (side player isEqualTo WEST || side player isEqualTo RESISTANCE) then {
		player action ["GunLightOn", player];
	};
	if (side player isEqualTo EAST && HVPGameType isEqualTo 1) then {
		player action ["nvGoggles", player];
	};
	
	sleep 8;
	[] spawn HVP_fnc_intro;
};
//-----------------------------------
//-WIN CONDITIONS
if (isServer && HVPTestMode isEqualTo 0 && HVPDebugMode isEqualTo 0) then {
	[] spawn HVP_fnc_endConditions;
};
//-----------------------------------
[] spawn HVP_fnc_carPenalty;
if (side player isEqualTo EAST && HVPGameType isEqualTo 1) then {
	[] spawn HVP_fnc_redhp;
};
//-----------------------------------
//-PROXIMITY
switch (HVPGameType) do {
	case 1: {
		if (playerSide isEqualTo WEST || playerSide isEqualTo RESISTANCE) then {
			[[EAST]] spawn HVP_fnc_proximity;
		};
	};
	case 2: {
		if (playerSide != sideLogic) then {
			[[]] spawn HVP_fnc_proximity;
		};
	};
	case 3: {
		if (playerSide isEqualTo WEST || playerSide isEqualTo EAST) then {
			[[RESISTANCE]] spawn HVP_fnc_proximity;
		};
	};
};
//-----------------------------------
//-VOICES
if (side player isEqualTo EAST || HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3 && playerSide isEqualTo RESISTANCE) then {
	[] call HVP_fnc_redSpeech;
};
//-----------------------------------
//-ANTI CAMP
if (HVPAntiCamp > 0) then {
	[] spawn HVP_fnc_antiCamp;
};
//-----------------------------------
//-TIPS
[] spawn HVP_fnc_tips;

//-----------------------------------
//-MUSIC LOOP
/*
[] spawn {
	while {true} do {
		waitUntil {daytime < 6 || daytime > 18};
		sleep 300+(random 300);
		if (daytime < 6 || daytime > 18) then {
			playMusic (selectRandom HVPMusic);
		};
	};
};
*/

//-----------------------------------