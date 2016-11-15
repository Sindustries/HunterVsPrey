/*
	ADMIN MENU
	Author: Sinbane
	
	BASE:
	
	SIN_fnc_X = {
		_command = "";
		_selectedplayer = SIN_player_list select lbCurSel 2100;
		_target = _selectedplayer select 1;	
		{
			if (isPlayer _x) then {
				if ((getPlayerUID _x) == _target) then {
					
					[_command,(name _x)] call SIN_fnc_Message;				
				};
			};
		} forEach allUnits;
	};

*/
//-----------------------------------
//-USER CONFIG

SIN_sendMessage = true;		//SET TO FALSE TO DISABLE SERVER-WIDE NOTIFICATIONS

//-----------------------------------
//-CORE FNC

SIN_fnc_Open = {
	(findDisplay 46) displayRemoveEventHandler ["KeyDown", SIN_adminOpen];
	call SIN_fnc_getPlayers;
	_handle = createDialog "SIN_admin";
	waitUntil {dialog};
	
	for [{_t=1}, {_t<=count SIN_player_list}, {_t=_t+1}] do {
		_indexNum = _t-1;
		_player = SIN_player_list select _indexNum;
		_name = _player select 0;
		_playerVis = format["%1",_name];
		_index0 = lbAdd [2100, _playerVis];
	};
			
	lbSetCurSel [2100, 0];
	
	waitUntil {!dialog};
	[] spawn SIN_fnc_Key;
};

SIN_fnc_Key = {
	waitUntil {!(isNull (findDisplay 46))};
	SIN_adminOpen = (findDisplay 46) displayAddEventHandler ["KeyDown", "
	_source  = _this select 0;
    _keyCode = _this select 1;
    _isShift = _this select 2;
    _isCtrl  = _this select 3;
    _isAlt   = _this select 4;
	
	if (_keyCode isEqualTo 221) then {
		[] spawn SIN_fnc_Open;
		true;
	}"];
};

SIN_fnc_getPlayers = {
	SIN_player_list = [];
	{
		if (isPlayer _x && side _x != CIVILIAN) then {
			_name = name _x;
			_uid = getPlayerUID _x;
			_player = [_name,_uid];
			SIN_player_list pushBack _player;
		};
	} forEach allUnits;
		
	SIN_player_list = SIN_player_list call BIS_fnc_sortAlphabetically;
};

SIN_fnc_Message = {
	if (SIN_sendMessage) then {
		_command = _this select 0;
		_name = _this select 1;
		_msg = format["--SINAdmin: %1 used command: %2 on %3",(name player),_command,_name];
		_msg remoteExec ["systemChat", 0];
	};		
};

//-----------------------------------
//-COMMANDS

SIN_fnc_Fatigue = {
	_command = "Disable Stamina";
	_selectedplayer = SIN_player_list select lbCurSel 2100;
	_target = _selectedplayer select 1;	
	{
		if (isPlayer _x) then {
			if ((getPlayerUID _x) == _target) then {
				[_x,false] remoteExec ["enableStamina", _x];
				[_command,(name _x)] call SIN_fnc_Message;
			};
		};
	} forEach allUnits;
};

SIN_fnc_Invisible = {
	_command = "Set Invisible";
	_selectedplayer = SIN_player_list select lbCurSel 2100;
	_target = _selectedplayer select 1;	
	{
		if (isPlayer _x) then {
			if ((getPlayerUID _x) == _target) then {
				_x hideObjectGlobal true;
				[_command,(name _x)] call SIN_fnc_Message;
			};
		};
	} forEach allUnits;
};

SIN_fnc_Invulnerable = {
	_command = "God Mode";
	_selectedplayer = SIN_player_list select lbCurSel 2100;
	_target = _selectedplayer select 1;	
	{
		if (isPlayer _x) then {
			if ((getPlayerUID _x) == _target) then {
				[_x,false] remoteExec ["allowDamage", _x];
				[_command,(name _x)] call SIN_fnc_Message;
			};
		};
	} forEach allUnits;
};

SIN_fnc_Kick = {
	_command = "Kick";
	_selectedplayer = SIN_player_list select lbCurSel 2100;
	_target = _selectedplayer select 1;	
	{
		if (isPlayer _x) then {
			if ((getPlayerUID _x) == _target) then {
				_x setDamage 1;
				"loser" remoteExec ["BIS_fnc_endMission", _x];
				[_command,(name _x)] call SIN_fnc_Message;
			};
		};
	} forEach allUnits;
};

SIN_fnc_NightVision = {
	_command = "Give Night Vision";
	_selectedplayer = SIN_player_list select lbCurSel 2100;
	_target = _selectedplayer select 1;	
	{
		if (isPlayer _x) then {
			if ((getPlayerUID _x) == _target) then {
				_x linkItem "H_HelmetO_ViperSP_ghex_F";
				[_x,["nvGoggles",_x]] remoteExec ["action", _x];
				[_command,(name _x)] call SIN_fnc_Message;
			};
		};
	} forEach allUnits;
};

SIN_fnc_Reset = {
	_command = "Reset Player";
	_selectedplayer = SIN_player_list select lbCurSel 2100;
	_target = _selectedplayer select 1;	
	{
		if (isPlayer _x) then {
			if ((getPlayerUID _x) == _target) then {
				[_x,true] remoteExec ["allowDamage", _x];
				[_x,true] remoteExec ["enableStamina", _x];			
				_x hideObjectGlobal false;
				[_x,true] remoteExec ["enableSimulation", _x];
				[_x,false] remoteExec ["setCaptive",_x];
				[_command,(name _x)] call SIN_fnc_Message;
			};
		};
	} forEach allUnits;
};

SIN_fnc_Teleport = {
	_command = "Teleport To";
	_selectedplayer = SIN_player_list select lbCurSel 2100;
	_target = _selectedplayer select 1;	
	{
		if (isPlayer _x) then {
			if ((getPlayerUID _x) == _target) then {
				player setPos (getPos _x);
				[_command,(name _x)] call SIN_fnc_Message;
			};
		};
	} forEach allUnits;
};

SIN_fnc_TeleportToAdmin = {
	_command = "Teleport To Admin";
	_selectedplayer = SIN_player_list select lbCurSel 2100;
	_target = _selectedplayer select 1;	
	{
		if (isPlayer _x) then {
			if ((getPlayerUID _x) == _target) then {
				_x setPos (getPos player);
				[_command,(name _x)] call SIN_fnc_Message;
			};
		};
	} forEach allUnits;
};

SIN_fnc_fullHeal = {
	_command = "Fully Heal";
	_selectedplayer = SIN_player_list select lbCurSel 2100;
	_target = _selectedplayer select 1;	
	{
		if (isPlayer _x) then {
			if ((getPlayerUID _x) == _target) then {				
				_x setDamage 0;
				_x setVariable ["SMS_bleedingRate",0,true];				
				[_command,(name _x)] call SIN_fnc_Message;				
			};
		};
	} forEach allUnits;
};

SIN_fnc_setCaptive = {
	_command = "Set Captive";
	_selectedplayer = SIN_player_list select lbCurSel 2100;
	_target = _selectedplayer select 1;	
	{
		if (isPlayer _x) then {
			if ((getPlayerUID _x) == _target) then {
				[_x,true] remoteExec ["setCaptive",_x];
				[_command,(name _x)] call SIN_fnc_Message;				
			};
		};
	} forEach allUnits;
};

//-----------------------------------
[] spawn SIN_fnc_Key;
systemChat "--SINAdmin: READY--";
//-----------------------------------