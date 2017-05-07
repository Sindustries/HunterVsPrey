// by ALIAS
// [[[],"ALpost\dust_alias.sqf"],"BIS_fnc_execVM",true,false] spawn BIS_fnc_MP;

if (!hasInterface) exitWith {};

waituntil {isplayer player};

_velocity_dust = _this select 0;
_color_dust = _this select 1;
_alpha_dust = _this select 2;

_pos_pl = position player;
_dust_pl = "#particlesource" createVehicleLocal _pos_pl;
if (vehicle player != player) then {
	_dust_pl attachto [vehicle player,[0,0,0]];
} else {
	_dust_pl attachto [player,[0,0,0]];
};

playSound "sandstorm";
_dust_pl setParticleParams [["\A3\data_f\cl_basic",1,0,1], "", "Billboard", 1, 7+random 4, [0, 0, -6], _velocity_dust, 13, 1.275, 1, 0, [4,10,20], [_color_dust  + [0], _color_dust + [_alpha_dust], _color_dust  + [0]], [0.08], 1, 0, "", "", vehicle player];
_dust_pl setParticleRandom [3, [30, 30, 0], [0, 0, 0], 1, 0, [0, 0, 0, 0.01], 0, 0];
_dust_pl setParticleCircle [0.1, [0, 0, 0]];
_dust_pl setDropInterval 0.01;

sleep 15;
deletevehicle _dust_pl;