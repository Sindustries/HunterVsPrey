/*
	HVP2 TIP MODE
	By Sin
	Displays random tips in systemchat every 2-3 minutes
*/
private ["_tip","_tips","_tipsTeam","_tipsCru","_tipsPred"];
//-----------------------------------

_tips = [
"The default key for Takedowns is CONTROL + T. This can be adjusted in CONTROLS -> CONFIGURE ADDONS.",
"Never trust a Norweigan with your longboat.",
"You may find extra supplies in buildings.",
"If you are bleeding you may pass out when you have lower than 40% blood and enter state of bleedout at 10%",
"Check how much ammo you have left by pressing CONTROL + R.",
"Cloaked players still emit a slight shimmer.",
"Supply Drops (marked green on the map) are a good source of loot.",
"You can configure most keybinds by going to CONTROLS -> CONFIGURE ADDONS.",
"If you are outside of the phase circle when it is in effect you will take periodic damage, may pass out and will slowly bleed to death without medical attention.",
"Hold CONTROL & WINDOWS KEY to open the self interaction menu. Hold only WINDOWS KEY to interact with objects and players.",
"You can rebind all mod related keys in CONTROLS -> CONFIGURE ADDONS",
"Helicopter crashes spawn gear not found anywhere else.",
"Keep a look out for Drop Pods. They fall from the sky burning, and emit an alarm when they crash. They contain rare loot, but have a limited time until they expire and the loot is lost forever.",
"Pressing 0 (zero) will holster your weapon. You can rebind this in CONTROLS -> CONFIGURE ADDONS",
"You can use your ability quickly by pressing SHIFT + ENTER",
"Weapon sway is effected by how much you are carrying. Travel light to lower the sway.",
"If AntiCamp is enabled you won't be able to stay in the same area for very long before your location is revealed to everybody",
"While inside a vehicle the fuel will quickly drain and you will be kicked out when it empties (doesn't effect boats in Crucible or Predator Mode)"
];

if (HVPGameType isEqualTo 1) then {
//TEAM MODE SPECIFIC
	_tipsTeam = [
	"Blue Team starts with Flashlights and guns, while Red Team has NVG's and must use Takedowns/Melee.",
	"Killing Blue Team members before they can group up is a good tactic.",	
	"Don't have a map? Co-ordinate with your team leader until you find one.",
	"Medics spawn with medical equipment.",
	"Each class starts with different gear and abilities.",
	"Red Team spawns with a silenced pistol that only has 1 bullet per phase that does no damage, but will force whoever the bullet hits into unconsciousness"
	];
	{_tips pushBack _x} forEach _tipsTeam;
};
if (HVPGameType isEqualTo 2) then {
//CRUCIBLE SPECIFIC
	_tipsCru = [
	"Press tilde: ` (to the left of 1 on your keyboard), I dare you!",
	"If you find a car, make sure to check it's contents for some extra gear",
	"Red Smoke grenades are actually Toxic Gas that will effect anyone (including yourself) that isn't wearing headgear that covers the mouth and nose",
	"If you have the Biohazard ability but don't have the correct protection, you'll be given protection temporarily",
	"The Escape ability can be used to instantly teleport away from a sticky situation, likewise the Banish ability can be used to get rid of nearby pesky players"
	];
	{_tips pushBack _x} forEach _tipsCru;
};
if (HVPGameType isEqualTo 3) then {
	_tipsPred = [
	"Red Smoke grenades are toxic towards The Prey. The Predator can't be effected by such things.",
	"If AntiCamp is enabled you won't be able to stay in the same area for very long before your location is revealed to everybody",
	"If you have the Biohazard ability but don't have the correct protection, you'll be given protection temporarily",
	"The Escape ability can be used to instantly teleport away from a sticky situation, likewise the Banish ability can be used to get rid of nearby pesky players"
	];
	{_tips pushBack _x} forEach _tipsPred;
};
//-----------------------------------
//-OPEN LOOP
while {alive player} do {
//-----------------------------------

sleep 120 + (random 60);

_tip = selectRandom _tips;
systemChat format["TIP: %1",_tip];

//-----------------------------------
//-CLOSE LOOP
};