/*
	HVP2 Player Ability Manager
	By Sinbane
*/
//-----------------------------------
//-VARIABLES

player setVariable ["isFatigueFree",false];

//-----------------------------------
//-VARIABLES

HVP_abilityTime = HVPPhaseTime;

//-----------------------------------
//-ABILITY LISTS

HVP_AbilityList = [
["Artillery","ARTILLERY STRIKE","Call down an Artillery Bombardment.",HVP_fnc_artilleryAbil,"false","true"],
["Biohazard","BIOHAZARD","Surround yourself in flares and toxic gas that effects nearby enemies",HVP_fnc_biohazardAbil,"false","true"],
["NightVisionThief","NIGHT VISION THIEF","Removes night vision from nearby enemies and gives night vision to nearby friendlies",HVP_fnc_nightVisionThiefAbil,"false","false"],
["HealingAura","HEALING AURA","Sends an aura that slowly heals you and nearby friendlies & grants temporary immunity to fatigue",HVP_fnc_healingAuraAbil,"false","true"],
["Blackout","BLACKOUT","Turn off all lights within 300m, including enemy flashlights.",HVP_fnc_blackoutAbil,"false","false"],
["FatigueAura","FATIGUE AURA","Drains the Stamina of all nearby enemies.",HVP_fnc_fatigueAuraAbil,"false","false"],
["Invincibility","INVINCIBILITY","Become invincible temporarily.",HVP_fnc_invincibilityAbil,"false","true"],
["Cloak","CLOAK","Become temporarily invisible as long as you're standing still, or prone",HVP_fnc_cloakAbil,"false","true"],
["TemporaryNightVision","NIGHT VISION","Temporary Night Vision",HVP_fnc_temporaryNightVisionAbil,"true","false"],
["FatigueFree","FATIGUE FREE","Temporary immunity to fatigue",HVP_fnc_fatigueFreeAbil,"false","false"],
["Reveal","REVEAL ENEMIES","Roughly reveals where enemies are on the map",HVP_fnc_revealAbil,"true","true"],

/* CRU/PRED ONLY */
["Escape","ESCAPE","Immediatly teleport to a new, random nearby location.",HVP_fnc_escapeAbil,"false","true"],
["Banish","BANISH","Banish nearby players to a new location.",HVP_fnc_banishAbil,"false","true"],
["Disarm","DISARM","Immediatly disarm nearby players of their current weapon",HVP_fnc_disarmAbil,"false","true"],
["SupplyDrop","SUPPLY DROP","Call a supply drop to your position",HVP_fnc_supplyDropAbil,"false","true"]
];

//-----------------------------------
//GIVE ABILITIES

if (HVPGameType isEqualTo 1) then {
//-----------------------------------
//-BLUE TEAM
//-----------------------------------
//-TEAM LEADER

if (player isKindof "B_Soldier_TL_F") then {
	["Artillery"] spawn HVP_fnc_addAbility;
};

//-----------------------------------
//-GRENADIER

if (player isKindof "B_Soldier_GL_F") then {
	["Biohazard"] spawn HVP_fnc_addAbility;
};

//-----------------------------------
//-TECH EXPERT

if (player isKindof "B_soldier_exp_F") then {
	["NightVisionThief"] spawn HVP_fnc_addAbility;
};

//-----------------------------------
//-MEDIC

if (player isKindof "B_medic_F") then {
	["HealingAura"] spawn HVP_fnc_addAbility;
};

//-----------------------------------
//-RED TEAM
//-----------------------------------
//-TEAM LEADER

if (player isKindof "O_Soldier_TL_F") then {
	["Blackout"] spawn HVP_fnc_addAbility;
};

//-----------------------------------
//-STALKER

if (player isKindof "O_spotter_F") then {
	["FatigueAura"] spawn HVP_fnc_addAbility;
};

//-----------------------------------
//-BOOMER

if (player isKindof "O_soldier_exp_F") then {
	["Invincibility"] spawn HVP_fnc_addAbility;
};

//-----------------------------------
//-WRAITH

if (player isKindof "O_soldier_UAV_F") then {
	["Cloak"] spawn HVP_fnc_addAbility;
};

//-----------------------------------
//-MERCENARY

if (player isKindof "I_medic_F") then {
	["FatigueFree"] spawn HVP_fnc_addAbility;
	["TemporaryNightVision"] spawn HVP_fnc_addAbility;
	["Reveal"] spawn HVP_fnc_addAbility;
};

};
if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
//-----------------------------------
//-RANDOM ABILITY

	[""] spawn HVP_fnc_addAbility;

};
if (HVPGameType isEqualTo 3 && playerSide isEqualTo RESISTANCE) then {
//-----------------------------------
//-PREDATOR EXTRA ONE-USE ABILITIES
	private "_abil";

	_abil = [player,"Invincibility"] call BIS_fnc_addCommMenuItem;
	_abil = [player,"Cloak"] call BIS_fnc_addCommMenuItem;
	_abil = [player,"Reveal"] call BIS_fnc_addCommMenuItem;

};
//-----------------------------------