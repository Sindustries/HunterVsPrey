/*
	HVP Car Penalty Script
	By Sinbane
	Punishes players inside vehicles
*/
//-----------------------------------
//-VARIABLES

waitUntil {sleep 1; vehicle player isEqualTo player};
//-----------------------------------
//-OPEN LOOP
while {alive player} do {
//-----------------------------------
private ["_inCar","_car","_driver","_fuel"];

	waitUntil {sleep 3; vehicle player != player || !alive player};
	if (!alive player) exitWith {};
	
	if (vehicle player isKindOf "Ship" && HVPGameType isEqualTo 2 || vehicle player isKindOf "Ship" && HVPGameType isEqualTo 3) then {
		_inCar = false;
		waitUntil {sleep 3; vehicle player isEqualTo player};
	};
	if (vehicle player isKindOf "Land") then {		
		_inCar = true;
		_car = vehicle player;		
		while {_inCar} do {
			if (!alive player) exitWith {};
			if (vehicle player isEqualTo player) then {
				if ({alive _x} count crew _car isEqualTo 0) then {
					player action ["lightOff", _car];
				};
				_inCar = false;
			};
			
			_driver = driver _car;				
			_fuel = fuel _car;
			
			if (_fuel < 0.05) then {
				[_car,0] remoteExec ["setFuel", 0];
			};
			if (_fuel isEqualTo 0) then {
				[_car,["wheel_1_1_steering", 1]] remoteExec ["setHit", 0];
				[_car,["wheel_2_1_steering", 1]] remoteExec ["setHit", 0];
				waitUntil {sleep 0.1; speed _car < 1};
				[_car,true] remoteExec ["lock",0];
				player action ["lightOff", _car];
				moveOut player;
			};
			if (_driver isEqualTo player || isNull _driver) then {
				[_car,_fuel - 0.01] remoteExec ["setFuel", 0];
			};
			sleep 1;
		};
	};	
	
//-----------------------------------
//-CLOSE LOOP
};