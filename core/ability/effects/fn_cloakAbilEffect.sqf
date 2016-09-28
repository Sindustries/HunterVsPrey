/*
	HVP2 Cloak Ability Effect
	By Sinbane
	Become invisible temporarily
*/
private ["_source","_timer","_time"];
//-----------------------------------
//-EFFECT

_time = _this select 0;

_source = "#particlesource" createVehicle (getPos player);  
_source setParticleCircle [0, [0.1, 0.1, 0.1]]; 
_source setParticleRandom [0, [0, 0.1, 1], [0.1, 0, 0.1], 0, 0.1, [0, 0, 0, 0.1], 0, 0]; 
_source setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract", 1, 0, 1], "", "Billboard", 1, 4, [0, 0, 0], [0, 0, 0.5], 9, 10, 7.9, 0.1, [0.6, 1, 0.9, 0.8], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0, 0.1, 0.2, 0.5, 0.1, 0.1], 0, 0, "", "", player]; 
_source setDropInterval 0.1;  
_source attachto [player,[0,0,0]];

for "_timer" from 1 to _time do {
	if ((velocityModelSpace player select 1) isEqualTo 0 && (stance player) != "PRONE") then {
		[player,true] remoteExec ["hideObject", 0]; 
		titleText ["CLOAK ACTIVATED", "PLAIN DOWN", 0.5];
	};
	if ((stance player) isEqualTo "PRONE") then {
		[player,true] remoteExec ["hideObject", 0];
		titleText ["CLOAK ACTIVATED", "PLAIN DOWN", 0.5];
	};
	if ((velocityModelSpace player select 1) != 0 && (stance player) != "PRONE") then {	
		[player,false] remoteExec ["hideObject", 0];
		titleText ["CLOAK DEACTIVATED", "PLAIN DOWN", 0.5];
	};
	sleep 1;
};

deleteVehicle _source;
[player,false] remoteExec ["hideObject", 0];

//-----------------------------------