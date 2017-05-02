class Params {

	class brk0 {
        title = "//-MAIN";
        values[] = {0};
        texts[] = {""};
        default = 0;
		isGlobal = 1;
    };

	class game1 {
		title = "Game Type";
		values[] = {1,2,3};
		texts[] = {"Hunter vs Prey","Crucible","Predator"};
		default = 1;
		isGlobal = 1;
	};

	class gameloc2 {
		title = "Game Location:";
		values[] = {0,1};
		texts[] = {"Random","Manual"};
		default = 0;
		isGlobal = 1;
	};

	class furn3 {
		title = "Furniture (Makes cities very laggy):";
		values[] = {0,10,25,50,75,100};
		texts[] = {"Disabled","10% of buildings","25% of buildings","50% of buildings","75% of buildings","100% of buildings"};
		default = 0;
		isGlobal = 1;
	};

	class gamedelay4 {
		title = "Delay Game Start:";
		values[] = {1,0};
		texts[] = {"True","False"};
		default = 0;
		isGlobal = 1;
	};

}