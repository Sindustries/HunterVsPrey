/*
	Filename: HFSRotate.sqf
	By: TheLo and AxiosODST
*/

_object = (_this select 3) select 0;
switch ((_this select 3)select 1) 
do{
	case 0: {_object setVectorDirAndUp [[+1,0,0],[0,0,1]]};
	case 1: {_object setVectorDirAndUp [[-1,0,0],[0,0,1]]};
	case 2: {if(player getvariable "initHeight" <= 2.5)then{player setVariable ["initHeight", (player getVariable "initHeight")+0.5]; detach _object; _object attachto [_this select 1, [0,2,player getVariable "initHeight"]]}else{hint "you can't place the object higher"}};
	case 3: {_object setVectorDirAndUp [[0,1,0],[0,0,1]]}
}