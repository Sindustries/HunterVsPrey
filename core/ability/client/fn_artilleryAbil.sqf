/*
	HVP2 Player Artillery Strike Ability
	By Sinbane
*/
private ["_vehCount","_missileCount","_maxTime","_posFound","_artyPos","_posChec"];
//-----------------------------------
//-SET VARIABLES

_vehCount = 2;
_missileCount = 12;		//How many each MLRS will try to fire

//-----------------------------------
//-GET STRIKE LOCATION

(findDisplay 46) displayRemoveEventHandler ["KeyDown", SIN_abilityDEH];

chosen_placement = false;
clicked = false;
  
OnMapSingleClick "ClickedPos = _pos; clicked = true;";
openMap [true, true]; 

titleText ["DESIGNATE ARTILLERY CO-ORDINATES", "PLAIN", 0.5];

while {true} do {

    if (clicked) then {
		
		_posCheck = [ClickedPos] call SIN_fnc_checkPos;
		if (_posCheck) then {
			onMapSingleClick "";
			openMap [false, false]; 
			chosen_placement = true;
			titleText ["CO-ORDINATES RECIEVED", "PLAIN", 0.5];
			[ClickedPos,_vehCount,_missileCount] spawn HVP_fnc_artillery;
			sleep 1;
			//cutText ["", "BLACK FADED", 999];
		} else {
			clicked = false;
			titleText ["INVALID POSITION", "PLAIN", 1];
		};
	};
  sleep 0.2;
  if (chosen_placement) exitwith {};
};

//-----------------------------------
//-ADD AT NEXT PHASE

["Artillery"] spawn HVP_fnc_addAbility;