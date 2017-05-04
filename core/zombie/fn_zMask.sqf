/*
	fn_zMask
	Author: Sinbane
	"Hides" player from zombies when wearing the Zombie NVG mask
*/
//-----------------------------------
while {alive player} do {
//-----------------------------------

	waitUntil {sleep 1; (hmd player) isEqualTo "Kio_Z_Mask_NVG"};

	while {(hmd player) isEqualTo "Kio_Z_Mask_NVG"} do {
		player setCaptive true;
		sleep 6;
	};

	player setCaptive false;

//-----------------------------------
};