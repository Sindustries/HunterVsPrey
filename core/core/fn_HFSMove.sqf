/*
	Filename: HFSMove.sqf
	By: TheLo and AxiosODST
*/

if ((player getVariable "attached") == 0) then
{
	player forceWalk true;
	player setVariable ["initHeight", 0.5, false];
	player setVariable ["attached", 1, false];
	_object = (_this select 0);
	removeAllActions _object;
	_object attachto [_this select 1,[0,2,0.5]];
	_act4 = player addAction ["Move up","HFS\HFSRotate.sqf",[_object,2]];
	_act1 = player addAction ["Make object face left","HFS\HFSRotate.sqf",[_object,1]];
	_act2 = player addAction ["Make object face right","HFS\HFSRotate.sqf",[_object,0]];
	_act5 = player addAction ["Make object face front","HFS\HFSRotate.sqf",[_object,3]];
	_act3 = player addAction ["Drop", "HFS\HFSDrop.sqf", [_object, _act1,_act2,_act4,_act5]];
	player addEventHandler ["killed", {_i = 0; _objnumb= count attachedobjects player; _objects = attachedobjects player; while{_i<_objnumb} do {detach _objects select _i}, player forceWalk false}];
}
else{hint "You're already moving an object"};