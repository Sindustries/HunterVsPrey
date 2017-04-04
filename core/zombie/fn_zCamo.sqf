/*
	fn_zCamo
	Author: Sinbane
	Allows player to camo themselves with dead zombie remains to become "invisible" to other zombies
*/
//-----------------------------------

private [];

//-----------------------------------

player action ["HealSoldierSelf", player];

sleep 6;

player setCaptive true;
HVP_zCamoApplied = true;

titleText ["ZOMBIE CAMOUFLAGE APPLIED", "PLAIN", 0.5];

sleep 300+(random 300);

player setCaptive false;
HVP_zCamoApplied = false;

titleText ["ZOMBIE CAMOUFLAGE EXPIRED", "PLAIN", 0.5];

//-----------------------------------