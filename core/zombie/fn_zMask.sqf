/*
	fn_zMask
	Author: Sinbane
	"Hides" player from zombies when wearing the Zombie NVG mask
*/
//-----------------------------------
private ["_time","_display"];
while {alive player} do {
//-----------------------------------

	waitUntil {sleep 1; (hmd player) isEqualTo "Kio_Z_Mask_NVG"};

	player setCaptive true;

	waitUntil {sleep 1; (hmd player) != "Kio_Z_Mask_NVG"};

	player setCaptive false;

//-----------------------------------
};