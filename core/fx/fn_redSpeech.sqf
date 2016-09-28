/* 
	Red Team Speech
	By Sinbane
	Allows Red Team units to speak pre-set super spooky noises
*/
//-----------------------------------
//-THE KEYBIND

SIN_say_Key = {
	waitUntil {!(isNull (findDisplay 46))};
	SIN_sayFX = (findDisplay 46) displayAddEventHandler ["KeyDown", "
	_source  = _this select 0;
    _keyCode = _this select 1;
    _isShift = _this select 2;
    _isCtrl  = _this select 3;
    _isAlt   = _this select 4;
	if (_keyCode isEqualTo 41) then {
		[] spawn SIN_fnc_say;
		true;
	}"];
};

//-----------------------------------
//-THE FNC

SIN_fnc_say = {
	private ["_selection","_add","_speaker","_SFX"];
	(findDisplay 46) displayRemoveEventHandler ["KeyDown", SIN_sayFX];
	
	_selection = [
	"raptor1",
	"raptor2",
	"raptor3",
	"raptor4",
	"raptor5"
	];
	
	if (HVPGameType == 2) then {
		_add = ["mockingbird","demongirlsong","evilLaugh"];
		{_selection pushback _x} forEach _add;
	};
	
	_SFX = selectRandom _selection;	
	_speaker = player;
	//[_speaker,[_SFX,150]] remoteExec ["say", 0];
	[_speaker,_SFX] remoteExec ["say", 0];
	
	sleep 120;
	
	[] spawn SIN_say_Key;
};

[] spawn SIN_say_Key;

//-----------------------------------