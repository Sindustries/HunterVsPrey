/*
	HVP2 Reveal Enemies Ability
	By Sinbane
	Places a marker on the approx location of all enemies
*/
//-----------------------------------

	titleText ["FINDING ENEMIES", "PLAIN DOWN", 0.5];
	
	sleep 5 + (random 25);

	[] call HVP_fnc_revealAbilEffect;
	
	titleText ["ENEMIES REVEALED", "PLAIN DOWN", 0.5];

//-----------------------------------
//-ADD AT NEXT PHASE

["Reveal"] spawn HVP_fnc_addAbility;