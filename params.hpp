class Params {

	class brk0 {
        title = "//-TIME";
        values[] = {0};
        texts[] = {""};
        default = 0;
		isGlobal = 1;
    };

	class TimeOfDay1 {
        title = "Time of Day:";
        values[] = {50,0,7,12,17};
        texts[] = {"Random","Midnight","Morning","Midday","Evening"};
        default = 0;
		isGlobal = 1;
    };
	
	class TimeMulti2 {
		title = "Time Multiplier:";
		values[] = {200,0,1,10,30,60,120};
		texts[] = {"Adaptive","0x","1x","10x","30x","60x","120x"};
		default = 0;
		isGlobal = 1;
	};
		
	class brk4 {
        title = "//-GAME";
        values[] = {0};
        texts[] = {""};
        default = 0;
		isGlobal = 1;
    };
	
	class game5 {
		title = "Game Type";
		values[] = {1,2,3};
		texts[] = {"Hunter vs Prey","Crucible","Predator (BETA)"};
		default = 1;
		isGlobal = 1;
	};
	
	class spawn6 {
		title = "Type of Spawn:";
		values[] = {0,1,2,3,4};
		texts[] = {"Random","Ground","HALO","Helicopter","Drop Pod"};
		default = 0;
		isGlobal = 1;
	};
	
	class gameloc7 {
		title = "Game Location:";
		values[] = {0,1};
		texts[] = {"Random","Manual"};
		default = 0;
		isGlobal = 1;
	}	
	
	class abilites8 {
		title = "Class Abilities:";
		values[] = {1,0};
		texts[] = {"Enabled","Disabled"};
		default = 1;
		isGlobal = 1;
	}
	
	class phasetype9 {
		title = "Phase Type:";
		values[] = {1,2};
		texts[] = {"Multiple","Single"};
		default = 1;
		isGlobal = 1;
	}
	
	class phasespacing {
		title = "Phase Spacing:";
		values[] = {1,2};
		texts[] = {"Breaks Between","Continuous"};
		default = 1;
		isGlobal = 1;
	}
	
	class phasetime9 {
		title = "Phase Time: (Period between phases will be half this if applicable) (If set to Single Phase, this will used for Ability cooldown)";
		values[] = {0,120,300,600,900,1200};
		texts[] = {"Adaptive","2 minutes","5 minutes","10 minutes","15 minutes","20 minutes"};
		default = 0;
		isGlobal = 1;
	}
	
	class ZoneSizeMax10 {
		title = "First Zone Size:";
		values[] = {0,500,1000,1500,2000,2500,3000};
		texts[] = {"Adaptive","1000m","2000m","3000m","4000m","5000m","6000m"};
		default = 0;
		isGlobal = 1;
	}
	
	class brk11 {
        title = "//-LOOT, VEHICLES & EVENTS";
        values[] = {0};
        texts[] = {""};
        default = 0;
		isGlobal = 1;
    };
	
	class LootMode {
		title = "Loot Mode:";
		values[] = {2,1};
		texts[] = {"Buildings Only","Anywhere"};
		default = 1;
		isGlobal = 1;
	}
	
	class LootChance12 {
		title = "Loot Chance: (This effects both loot spawns and players spawning with extra equipment)";
		values[] = {10,20,33,50,66,80};
		texts[] = {"Very Rare (10%)","Rare (20%)","Uncommon (33%)","Common (50%)","Very Common (66%)","Abundant (80%)"};
		default = 20;
		isGlobal = 1;
	}
	
	class NumCars13 {
        title = "Number of Vehicles:";
        values[] = {0,100,5,10,15,20};
        texts[] = {"Disabled","Auto","5","10","15","20"};
        default = 100;
		isGlobal = 1;
    };
	
	class LootEvents14 {
		title = "Loot Events: (Airdrops, Drop Pods, Helicopter Crashes)";
		values[] = {1,0};
		texts[] = {"Enabled","Disabled"};
		default = 1;
		isGlobal = 1;
	}
	
	class DestEvents15 {
		title = "Area Denial Events: (Artillery, Chemical Attacks, Earthquakes, Nuke, Rogue UAV)";
		values[] = {1,0};
		texts[] = {"Enabled","Disabled"};
		default = 1;
		isGlobal = 1;
	}
	
	class paranormalEvent16 {
        title = "Paranormal Activity:";
        values[] = {1,0};
        texts[] = {"Enabled","Disabled"};
        default = 0;
		isGlobal = 1;
    };
	
	class EventFreq17 {
		title = "Event Randomiser:";
		values[] = {60,180,300,420,600};
		texts[] = {"1 Minute","3 Minutes","5 Minutes","7 Minutes","10 Minutes"};
		default = 300;
		isGlobal = 1;
	}
	
	class brk18 {
        title = "//-EXTRAS";
        values[] = {0};
        texts[] = {""};
        default = 1;
		isGlobal = 1;
    };
	
	class zomzoms {
		title = "Zombies:";
		values[] = {1,0};
		texts[] = {"Enabled","Disabled"};
		default = 1;
		isGlobal = 1;
	}
	
	class anticamp {
		title = "AntiCamp: (Reveals player locations if they linger in one area too long)";
		values[] = {0,30,60,90,120};
		texts[] = {"Disabled","30 seconds","60 seconds","90 seconds","120 seconds"};
		default = 0;
		isGlobal = 1;
	};

	class stats20 {
		title = "Stat Saving (Auto disabled if Debug Mode enabled)";
		values[] = {1,0,2};
		texts[] = {"Enabled","Disabled","Wipe Stats"};
		default = 1;
		isGlobal = 1;
	}
	
	class testmode2121 {
		title = "Testing Mode: (Prevents the game from ending and launches beta features)";
		values[] = {1,0};
		texts[] = {"Enabled","Disabled"};
		default = 0;
		isGlobal = 1;
	}
		
	class debugending21 {
		title = "Debug Mode: (Shows additional debugging information)";
		values[] = {1,0};
		texts[] = {"Enabled","Disabled"};
		default = 0;
		isGlobal = 1;
	}
	
}