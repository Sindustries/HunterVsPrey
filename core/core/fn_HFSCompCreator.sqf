/*
	Filename: HFSCompCreator.sqf
	By: TheLo and AxiosODST

	HOW TO USE
	
	In the editor place a house and create your furniture as you like.
	Name that house however you want.
	In the mission init.sqf write the line : [*YOUR HOUSE NAME*,*RADIUS OF SEARCH FOR OBJECTS*] execvm "HFSCompCreator.sqf";
	Wait for the confirmation hint "string copied to clipboard";
	Copy using Ctrl+v into the HFSCompSpawner under the right building classname.
*/
_line="";
_radius = _this select 1;
_house = _this select 0;
_housename = (_this select 0) getvariable "varname";
_i=1;
_objectnumber = count (nearestObjects [getpos _house, ["thingx", "house"], _radius]);
hint format["found %1 objects", _objectnumber - 1];
uisleep 3;
_objects = (nearestObjects [getposASL _house, ["thingx", "house"], _radius]);
while{_i < _objectnumber}
	do{
		_objz = ((getposASL (_objects select _i)) select 2) - ((getposASL _house) select 2);
		_line = _line + format ["_%1%2 = createvehicle['%1',[0,0,5],[],0,'CAN_COLLIDE'];", typeof (_objects select _i),_i];
		_line = _line + format [" _%1%2 enablesimulation false;", typeof (_objects select _i), _i];
		_line = _line + format [" _%1%2 attachto [_house,%3];", typeof (_objects select _i), _i, (_house worldtomodel (getposASL (_objects select _i)))];
		_line = _line + format [" detach _%1%2;", typeof (_objects select _i), _i];
		_line = _line + format [" _%1%2 setposASL [getposASL _%1%2 select 0, getposASL _%1%2 select 1, %3 + (_housepos select 2)];", typeof (_objects select _i), _i, _objz];
		_line = _line + format [" _%1%2 setdir (%3+_housedir);", typeof (_objects select _i), _i, getdir (_objects select _i)];
		_i = _i+1;
	};
hint format["%1", _line];
uisleep 8;
copytoclipboard _line;
hint "String copied to clipboard";