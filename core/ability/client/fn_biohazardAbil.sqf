/*
	HVP2 Biohazard Ability Effect
	By Sinbane
	Surrounds user with toxic gas that effects enemy team
*/
//-----------------------------------
//-EFFECT

(findDisplay 46) displayRemoveEventHandler ["KeyDown", SIN_abilityDEH];

titleText ["BIOHAZARD ACTIVATED", "PLAIN DOWN", 0.5];

[] call HVP_fnc_biohazardAbilEffect;

//-----------------------------------
//-ADD AT NEXT PHASE

["Biohazard"] spawn HVP_fnc_addAbility;	