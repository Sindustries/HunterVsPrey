class Params {
		
	class brk4 {
        title = "//-MAIN";
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
	
	class ZoneSizeMax10 {
		title = "First Zone Size:";
		values[] = {0,500,1000,1500,2000,2500,3000};
		texts[] = {"Adaptive","1000m","2000m","3000m","4000m","5000m","6000m"};
		default = 0;
		isGlobal = 1;
	}	
}