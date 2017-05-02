/*
	Filename: HFSMoveComp.sqf
	By: TheLo and AxiosODST
*/

_i=0;
_mkrsize = (HVPZoneSizeMax * 1.25);
_mkrpos = HVP_Pos;
_mkrx = _mkrsize;
_mkry = _mkrsize;
_mkrmax = 0;

if (_mkry>_mkrx) then {_mkrmax=_mkry}else{_mkrmax=_mkrx};
_objects = nearestobjects [_mkrpos, ["house","thingX"], _mkrmax];
_maxobj = count _objects;
hint format ["found %1 objects", _maxobj];
uisleep 3;
player setVariable ["attached", 0, false];
while {_i<_maxobj} do {
	if(((typeof (_objects select _i)) isequalto "Land_Bench_F") or ((typeof (_objects select _i)) isequalto
	"Land_ChairPlastic_F") or ((typeof (_objects select _i)) isequalto
	"Land_OfficeChair_01_F") or ((typeof (_objects select _i)) isequalto "Land_OfficeCabinet_01_F") or ((typeof (_objects select _i)) isequalto
	"Land_WaterCooler_01_new_F") or ((typeof (_objects select _i)) isequalto
	"Land_WoodenBox_F") or ((typeof (_objects select _i)) isequalto
	"Land_GasTank_01_blue_F") or ((typeof (_objects select _i)) isequalto
	"Land_GarbageContainer_closed_F"))
	then {(_objects select _i) addAction ["Move", HVP_fnc_HFSMove,[],1.5,false,true,"","true"]}
	else{};
	_i = _i+1
}