/*
	Filename: HFSDrop.sqf
	By: TheLo and AxiosODST 
*/

_object = (_this select 3) select 0;
player removeaction ((_this select 3) select 4);
player removeaction ((_this select 3) select 3);
player removeaction ((_this select 3) select 2);
player removeaction ((_this select 3) select 1);
player removeaction (_this select 2);
detach _object;
player setVariable ["attached", 0, false];
player forceWalk false;
uisleep 0.1;
_object enablesimulation true;
_object setposATL (getposATL _object);
_object setVelocity [0,0,-1];
uisleep 2;
_object addaction ["Move", "HFS\HFSMove.sqf",[],1.5,false,true,"","true"];

