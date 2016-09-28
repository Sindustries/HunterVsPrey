/*
	HVP2 Paradrop Spawn
	By Sinbane
	Finds a location within the phase radius and spawns player in freefall
*/
//-----------------------------------
//-GET SPAWN LOCATION
		
_spawnPos = _this select 0;

[player] call ace_hearing_fnc_putInEarplugs;

//-----------------------------------
//-SAVE BACKBACK CONTENTS & ADD PARACHUTE IF PLAYER HAS EXISTING BACKPACK

if (!isNull (unitBackpack player) && (backpack player) != "b_parachute") then {

private ["_pack","_class","_magazines","_weapons","_items"];
_pack	   = unitBackpack player;
_class	   = typeOf _pack;
_magazines = getMagazineCargo _pack;
_weapons   = getWeaponCargo _pack;
_items	   = getItemCargo _pack;

removeBackpack player;
player addBackpack "b_parachute";

sleep 0.1;

private "_packHolder";
_packHolder = createVehicle ["groundWeaponHolder", [0,0,0], [], 0, "can_collide"];
_packHolder addBackpackCargoGlobal [_class, 1];

//-----------------------------------
//-MOVE PLAYER TO SPAWN POINT

player setPos [_spawnPos select 0,_spawnPos select 1,(1500 + (random 1000))];
player setDir (random 360);

//-----------------------------------
//-FREE FALL

waitUntil {animationState player == "HaloFreeFall_non"};
sleep 3;
titleText ["YOUR PARACHUTE WILL OPEN AUTOMATICALLY AT 200m", "PLAIN", 1.5];

_packHolder attachTo [player,[-0.12,-0.02,-.74],"pelvis"]; 
_packHolder setVectorDirAndUp [[0,-1,-0.05],[0,0,-1]];

//-----------------------------------
//-PARACHUTE OPEN

waitUntil {(getPos player select 2) < 200 || animationState player == "para_pilot"};
player action ["OpenParachute", player];
_packHolder attachTo [vehicle player,[-0.07,0.67,-0.13],"pelvis"]; 
_packHolder setVectorDirAndUp [[0,-0.2,-1],[0,1,0]];
titleText ["AVOID LANDING AT SPEEDS GREATER THAN 10km/h", "PLAIN", 1];

//-PARASMOKE

[] spawn HVP_fnc_parasmoke;

//-----------------------------------
//-LANDING

waitUntil {(getPos player select 2) < 1 || isTouchingGround player};
if ((speed player) >= 20) then {
	waitUntil {animationState player != "para_pilot"};
	sleep 1;
	[player, 16] spawn SMS_fnc_setUnconscious;
	player setDamage 0.1;
	player setHit ["legs", 0.1];
	[player,3] spawn SMS_fnc_setBleeding;
};
	

detach _packHolder;
deleteVehicle _packHolder;
player addBackpack _class;
clearAllItemsFromBackpack player;

for "_i" from 0 to (count (_magazines select 0) - 1) do {
	(unitBackpack player) addMagazineCargoGlobal [(_magazines select 0) select _i,(_magazines select 1) select _i]; //return the magazines
};
for "_i" from 0 to (count (_weapons select 0) - 1) do {
	(unitBackpack player) addWeaponCargoGlobal [(_weapons select 0) select _i,(_weapons select 1) select _i]; //return the weapons
};
for "_i" from 0 to (count (_items select 0) - 1) do {
	(unitBackpack player) addItemCargoGlobal [(_items select 0) select _i,(_items select 1) select _i]; //return the items
};

sleep 2;	
	if (side player == RESISTANCE) then {
		player action ["nvGogglesOff", player];
	};

	1 fadeSound 1;
sleep 3;

//-----------------------------------
//-
} else {
//-----------------------------------
//-NO EXISTING BACKPACK
//-----------------------------------
//-MOVE PLAYER TO SPAWN POINT

	player addBackpack "b_parachute";
	player setPos [_spawnPos select 0,_spawnPos select 1,(1500 + (random 1000))];
	player setDir (random 360);
	
//-----------------------------------
//-FREE FALL

	waitUntil {animationState player == "HaloFreeFall_non"};
	player enableSimulation true;
	enableEnvironment true;
	cutText ["", "BLACK IN", 5];
	sleep 3;
	titleText ["YOUR PARACHUTE WILL OPEN AUTOMATICALLY AT 200m", "PLAIN", 1.5];
	
//-----------------------------------
//-PARACHUTE OPEN
		
	waitUntil {(getPos player select 2) < 200 || animationState player == "para_pilot"};
	player action ["OpenParachute", player];
	titleText ["AVOID LANDING AT SPEEDS GREATER THAN 10km/h", "PLAIN", 1];
	
//-PARASMOKE

[] spawn HVP_fnc_parasmoke;
	
//-----------------------------------
//-LANDING
	
	waitUntil {(getPos player select 2) < 1 || isTouchingGround player};
	if ((speed player) >= 20) then {
		waitUntil {animationState player != "para_pilot"};
		sleep 1;
		[player, 16] spawn SMS_fnc_setUnconscious;
		player setDamage 0.1;
		player setHit ["legs", 0.1];
		[player,3] spawn SMS_fnc_setBleeding;
	};
	
	sleep 2;	
	if (side player == RESISTANCE) then {
		player action ["nvGogglesOff", player];
	};
};

[player] call ace_hearing_fnc_removeEarplugs;
player removeItem "ACE_earplugs";

//-----------------------------------