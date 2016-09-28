chosen_placement = false;
clicked = false;
  
OnMapSingleClick "ClickedPos = _pos; clicked = true;";
openMap [true, true]; 
cutText ["", "BLACK IN", 1];

cutText ["CLICK SOMEWHERE FOR GAME LOCATION", "PLAIN", 1];

while {true} do {

    if (clicked) then {
		_findPos = [ClickedPos,0,50,0,0,100,0] call BIS_fnc_findSafePos;
		
		if ((HVPErrorPos select 0) == _findPos select 0 && (HVPErrorPos select 1) == _findPos select 1) then {
			clicked = false;
			cutText ["INVALID POSITION", "PLAIN", 1];
		} else 
		{
			cutText ["", "BLACK FADED", 999];
			onMapSingleClick "";
			openMap [false, false]; 
			chosen_placement = true;
			HVP_Pos = _findPos;
			publicVariable "HVP_Pos";
			HVP_Pos_Found = "true";
			publicVariable "HVP_Pos_Found";
			sleep 1;
			cutText ["", "BLACK FADED", 999];
		};     
    };
  sleep 0.2;
  if (chosen_placement) exitwith {};
};