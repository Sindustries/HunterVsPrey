// by ALIAS
// nul = [obj_nuke,radius,radiation,fallout] execvm "AlNuke\ignite_nuke.sqf";

if (!hasInterface) exitWith {};

obj_nuke_c = _this select 0;
radius_c = _this select 1;

// _npos= [getPos obj_nuke_c select 0,getPos obj_nuke_c select 1,0];

	// lumina

	[obj_nuke_c] spawn {
			_poz_lum = _this select 0;
			li2 = "#lightpoint" createVehicleLocal [getPos _poz_lum select 0,getPos _poz_lum select 1,0];
			li2 setLightBrightness 1100;
			li2 setLightAmbient[1,1,1];
			li2 setLightColor[1,1,1];
			li2 lightAttachObject [_poz_lum, [0.5,0,500]];	
			
			_i=1000;
			while {_i>0} do {
			li2 setLightBrightness _i;
			_i = _i-1;
			sleep 0.1;
			};
	};

	// orbire

	[] spawn 
		{		
			cutText ["", "WHITE OUT", 1];
			sleep 1;
			titleCut ["", "WHITE IN", 1];
			"dynamicBlur" ppEffectEnable true;   
			"dynamicBlur" ppEffectAdjust [40];   
			"dynamicBlur" ppEffectCommit 0;     
			"dynamicBlur" ppEffectAdjust [0.0];  
			// "dynamicBlur" ppEffectCommit 17;  
			"dynamicBlur" ppEffectCommit 10;  
			sleep 10;
			"dynamicBlur" ppEffectEnable false; 
		};
	obj_nuke_c say3D "nuke";
	// distort
	[] spawn 
		{
			// sleep 3;
			"colorCorrections" ppEffectEnable true;
			alpha_c=1;
			while {alpha_c >0} do {
			"colorCorrections" ppEffectAdjust[ 1, 1, alpha_c, [0.16, 0.38, 4.94, -1.65],[4.71, 2.68, 5, -0.29],[0.99, 0.81, -1.04, -1.76]];	
			"colorCorrections" ppEffectCommit 0;
			sleep 0.01;
			alpha_c=alpha_c-0.05;
			};
			sleep 3;
//			hint "capat";
//			a1=0.16;			a2=0.38;			a3=4.94;
			a4=-1.65;
//			b1=4.71;			b2=2.68;			b3=5;
			b4=-0.29;
//			c1=0.99;			c2=0.81;			c3=-1.04;
			c4=-1.76;
			schimb_c=false;
			sleep 1;
		
			while {!schimb_c} do {
				a4=a4+0.001;
				b4=b4+0.001;
				c4=c4+0.001;
				sleep 0.01;

				if (b4<0.86) then {"colorCorrections" ppEffectAdjust[1, 1, 0, [0.16, 0.38, 4.94, a4],[4.71, 2.68, 5, b4],[0.99, 0.81, -1.04, c4]];
				"colorCorrections" ppEffectCommit 0;}
					else {
					obj_nuke_c say3D "nuke_3";
					cutText ["", "WHITE OUT", 1];
					sleep 0.1;
					titleCut ["", "WHITE IN", 1];
					"dynamicBlur" ppEffectEnable true;   
					"dynamicBlur" ppEffectAdjust [40];   
					"dynamicBlur" ppEffectCommit 0;     
					"dynamicBlur" ppEffectAdjust [0.0];  
					"dynamicBlur" ppEffectCommit 10;  
					"dynamicBlur" ppEffectEnable false;		
					schimb_c=true;// hint"done";
					};
					
			};
			
			NukeFallout = true;
			while {NukeFallout} do {
				"colorCorrections" ppEffectEnable true;
				"colorCorrections" ppEffectAdjust[1, 1, 0, [-0.2, 0.1, 0.23, -0.2],[0.76, -0.4, 0.86, 0.86],[-0.57, 0.81, -1.2, 0.88]];
				"colorCorrections" ppEffectCommit 0; 
				"filmGrain" ppEffectEnable true; 
				"filmGrain" ppEffectAdjust [0.3, 10, 1, 0.1, 1, false];
				"filmGrain" ppEffectCommit 2;
				sleep 3;				
			};
			"colorCorrections" ppEffectEnable true;
			"colorCorrections" ppEffectAdjust [1, 1, 0,[ 0, 0, 0, 0],[ 1, 1, 1, 1],[ 0, 0, 0, 0]];
			"colorCorrections" ppEffectCommit 10;
			"filmGrain" ppEffectEnable false;
		};
	
	
	
	obj_nuke_baza_1 = "land_helipadempty_f" createVehicle [getPos obj_nuke_c select 0,getPos obj_nuke_c select 1,0];
	
	_ciuperca = "#particlesource" createVehicleLocal getPos obj_nuke_baza_1;
	_ciuperca setParticleCircle [30, [0, 3, 7]];
	_ciuperca setParticleRandom [0, [0.25, 0.25, 0], [0.175, 0.175, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
	_ciuperca setParticleParams [["\A3\data_f\cl_fire", 16, 0, 16], "", "Billboard", 1, 50, [0, 0, 0], [0, 0, 400], 3, 21, 19, 0.2, [200, 100, 200, 90, 200, 100, 300, 450, 500, 200], [[1, 1, 1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0.5], [0, 0, 0, 1], [1, 1, 1, 1], [0, 0, 0, 0], [1, 1, 1, 0.5], [0, 0, 0, 0.5], [1, 1, 1, 1], [1, 1, 1, 1]], [0.08], 1, 0.5, "", "", obj_nuke_baza_1];
	_ciuperca setDropInterval 0.01;

	//sleep 1; 
	//obj_nuke_c say3D "nuke";	
	
	addCamShake [0.5, 253, 37];
	
	obj_nuke_baza_2 = "land_helipadempty_f" createVehicle [getPos obj_nuke_c select 0,getPos obj_nuke_c select 1,0];
	
	_val = "#particlesource" createVehicleLocal getPos obj_nuke_baza_2;
	_val setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48], "", "Billboard", 1, 50, [0, 0, 0],[0, 0, 0], 0, 1.5, 1, 0, [50, 100], [[0.1, 0.1, 0.1, 0.5], [0.5, 0.5, 0.5, 0.5], [1, 1, 1, 0.3], [1, 1, 1, 0]], [1,0.5], 0.1, 1, "", "", obj_nuke_baza_2];
	_val setParticleRandom [2, [20, 20, 20], [5, 5, 0], 0, 0, [0, 0, 0, 0.1], 0, 0];
	_val setParticleCircle [50, [-80, -80, 2.5]];
	_val setDropInterval 0.0002;
	
	[] spawn 
		{
		sleep 3;
		obj_nuke_c say3D "nuke_2";
		playsound "wind_strong";
		playsound "murmur";
	};
	
	[] spawn {
		sleep 15; deleteVehicle obj_nuke_baza_2;
		_valix = "#particlesource" createVehicleLocal getPos obj_nuke_baza_1;
		_valix setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48], "", "Billboard", 1, 10, [0, 0, 0],[0, 0, 0], 0, 1.5, 1, 0, [50, 100], [[1, 1, 1, 1], [0.5, 0.5, 0.5, 1], [1, 1, 1, 1], [1, 1, 1, 0]], [1,0.5], 0.1, 1, "", "", obj_nuke_baza_1];
		_valix setParticleRandom [10, [10, 10, 3], [5, 5, 0], 0, 0, [0, 0, 0, 0.1], 0, 0];
		_valix setParticleCircle [100, [-10, -10, 5]];
		_valix setDropInterval 0.1;
	};
	
	[] spawn {
	sleep 150;
	deleteVehicle obj_nuke_baza_1;
	enableCamShake false;
	};
	
	[] spawn {
	sleep 90;
	deleteVehicle obj_nuke_baza_1;
	deleteVehicle li2;
	enableCamShake false;
	};