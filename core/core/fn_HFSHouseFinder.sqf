/*
	Filename: HFSHouseFinder.sqf
	By: TheLo and AxiosODST
*/

if (isServer) then {
_debug = 0;
_mkrsize = (HVPZoneSizeMax * 1.25);
_mkrx = _mkrsize;
_mkry = _mkrsize;
_mkrmax = 0;
_mkrpos = HVP_Pos;

_i=0;					//index
//uisleep 3;
if (_mkry>_mkrx) then {_mkrmax=_mkry}else{_mkrmax=_mkrx};// Gets the largest size between x and y
_housenumber = count (nearestObjects [_mkrpos, ["house"], _mkrmax]); //counts number of houses in marker
if(_debug == 1) then{hint format ["Found %1 houses", _housenumber];} else{};
_houses =  (nearestObjects [_mkrpos, ["house"], _mkrmax]);// Fills an array with the houses informations
uisleep 3;
_counter = _housenumber;
while {_i < _housenumber} do {
	if (random 100 < 20) then {
		[_houses select (_i)] call HVP_fnc_HFSCompSpawner;		//every house executes the script
	};
	_i = _i+1;
	_counter = _counter - 1;
	[_counter,_housenumber] remoteExec ["HVP_fnc_updateProgressBar", 0];
};
} else {};