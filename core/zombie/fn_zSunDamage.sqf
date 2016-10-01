/*
	fn_zSunDamage
	Author: Sinbane
	Slowly damages zombies in the sun
*/
//-----------------------------------

	while {true} do {
		sleep 10;
		waitUntil {sleep 10; (count HVP_zombieArray > 0)};
		
		if (sunOrMoon isEqualTo 1 && fog < 0.5 && overcast < 0.7) then {
			{
				_x setDamage ((damage _x) + (random 0.1));
			} forEach HVP_zombieArray;
		};
	};

//-----------------------------------