/*
	HVP2 Night Vision Thief Ability
	By Sinbane
	Removes NVG's from nearby enemies temporarily and gives nearby friendlies temporary night vision
*/
//-----------------------------------
//-ABILITY

(findDisplay 46) displayRemoveEventHandler ["KeyDown", SIN_abilityDEH];

[(getPos player)] remoteExec ["HVP_fnc_nightVisionThiefAbilEffect", 0];

titleText ["NIGHT VISION THIEF ACTIVATED", "PLAIN DOWN", 0.5];

//-----------------------------------
//-ADD AT NEXT PHASE

["NightVisionThief"] spawn HVP_fnc_addAbility;