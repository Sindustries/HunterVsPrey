/*
	HVP Tear/Toxic Gas Script
	Origonal by Taw_jarhead, edited by Sinbane for HVP
*/
//-----------------------------------
//-VARIABLES

if (HVPGameType isEqualTo 1) then {
	if (playerSide isEqualTo WEST) then {
		tearGas = "SmokeShellRed";
		tearGasGL = "1Rnd_SmokeRed_Grenade_shell";
	};
	if (playerSide isEqualTo EAST) then {
		tearGas = "SmokeShellBlue";
		tearGasGL = "1Rnd_SmokeBlue_Grenade_shell";
	};
};
if (HVPGameType isEqualTo 2) then {
	tearGas = "SmokeShellRed";
	tearGasGL = "1Rnd_SmokeRed_Grenade_shell";
};
if (HVPGameType isEqualTo 3) then {
	if (playerSide != RESISTANCE) then {
		tearGas = "SmokeShellRed";
		tearGasGL = "1Rnd_SmokeRed_Grenade_shell";
	};
};

if (side player isEqualTo RESISTANCE && HVPGameType isEqualTo 1) exitWith {};
if (side player isEqualTo RESISTANCE && HVPGameType isEqualTo 3) exitWith {};
//-----------------------------------
//-OPEN LOOP
while {true} do {
//-----------------------------------

	// normal conditions
	if (playerSide isEqualTo WEST || HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
		player forceWalk false;
	};
	"dynamicBlur" ppEffectEnable true; // enables ppeffect
	"dynamicBlur" ppEffectAdjust [0]; // enables normal vision
	"dynamicBlur" ppEffectCommit 10; // time it takes to normal
	resetCamShake; // resets the shake
	20 fadeSound 1;	 //fades the sound back to normal

	waitUntil {sleep 1; (nearestObject [getpos player, tearGas]) distance player < 10 || (nearestObject [getpos player, tearGasGL]) distance player < 10};
	if (getpos (nearestObject [getpos player, tearGas]) select 2 < 5 || getpos (nearestObject [getpos player, tearGasGL]) select 2 < 5) then {

		if ((headgear player) in HVP_gasMasks || (goggles player) in HVP_gasMasks) then {sleep 1} else {

			"dynamicBlur" ppEffectEnable true; // enables ppeffect
			"dynamicBlur" ppEffectAdjust [10]; // intensity of blur
			"dynamicBlur" ppEffectCommit 3; // time till vision is fully blurred
			enableCamShake true;	 // enables camera shake
			addCamShake [10, 45, 10];	// sets shakevalues
			player setStamina 3; // sets stamina to pretty much empty
			5 fadeSound 0.1;	 // fades the sound to 10% in 5 seconds
			sleep 5;
			if (playerSide isEqualTo WEST && HVPGameType isEqualTo 1 || HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
				player forceWalk true;
				player setDamage ((damage player)+0.05);
				[player,3] spawn SMS_fn_setBleeding;
			};
			"dynamicBlur" ppEffectAdjust [20]; // intensity of blur
			"dynamicBlur" ppEffectCommit 3; // time till vision is fully blurred
			sleep 5;
		};
	};
	
//-----------------------------------
//-CLOSE LOOP
};