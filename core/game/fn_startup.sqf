/*
	HVP2 Startup Script
	By Sinbane
	Launches all critical scripts, zone & events managers and player spawn
*/
enableSentences false;
enableEnvironment false;
player enableSimulation false;
player allowDamage false;
player enableStamina false;
//-----------------------------------
//-GAME SETTINGS
private "_allUnits";

cutText ["", "BLACK FADED", 999];

























sleep 5;











//-----------------------------------
//-TESTING CODE
if (HVPTestMode isEqualTo 1) then {
hintSilent "TESTING CODE START";

private "_keyHandler";
_keyHandler = (findDisplay 46) displayAddEventHandler ["KeyDown", {
	private ["_code","_shift","_ctrl","_alt","_success"];
	_code = _this select 1;
	_shift = _this select 2;
	_ctrl = _this select 3;
	_alt = _this select 4;
	_success = false;

	switch (_code) do {
		/* Earplugs with Shift-O */
		case 24: {
			if (_shift) then {
				if (soundVolume != 1) then {
					1 fadeSound 1;
				} else {
					1 fadeSound 0.1;
				};
				_success = true;
			};
		};
		
		/* Holster with Shift-H */
		case 35: {
			if (_shift && !(currentWeapon player isEqualTo "")) then {
				holsteredWeapon = currentWeapon player;
				player action ["SwitchWeapon", player, player, 100];
				_success = true;
			};
		};
		
		/* Unholster with Shift-F */
		case 33: {
			if (_shift && !isNil "holsteredWeapon" && (currentWeapon player isEqualTo "")) then {
				if (holsteredWeapon in [primaryWeapon player,secondaryWeapon player,handgunWeapon player]) then {
					player selectWeapon holsteredWeapon;
					_success = true;
				};
			};
		};
	};
	_success;
}];
	
	
hintSilent "TESTING CODE END";	
};
//-----------------------------------