// by ALIAS
// nul = [] execvm "AlNuke\fog_nuke.sqf";

// if (!isServer) exitWith {};	

	enableEnvironment false;
		
//	fog_up=true;publicVariable "fog_up";	[] spawn {sleep 60; fog_up=false;publicVariable "fog_up";};	

/*	
	fog_dens = 0;
	while {fog_up} do {
		0 setFog [fog_dens,0.1,50];
		sleep 0.01;
		fog_dens =fog_dens+0.0001;
//		hint "cresc";		hint str fog;
	};
*/
	10 setFog [0.3,0.1,50];

	sleep 20;
	
	fog_dens = 0.3;
	
	while {fog_dens>0.14} do {
	0 setFog [fog_dens,0.1,50];
	sleep 0.5;
	fog_dens =fog_dens-0.001;
//	hint "scad";		hint str fog;		
	};

	/*	
	if (!fog_up) then {
		while {fog_dens>0.14} do {
		0 setFog [fog_dens,0.1,50];
		sleep 0.5;
		fog_dens =fog_dens-0.001;
		hint "scad";		hint str fog;		
		};
	};
*/
	sleep 40;
	//0 setRain 0.05;
	enableEnvironment true;