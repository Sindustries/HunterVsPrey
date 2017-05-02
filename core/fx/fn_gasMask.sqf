fnc_overlay = { 0 cutRsc ["equipment_prot","PLAIN", 1, false];	sleep 1.6;};

sleep 1;

while {alive player} do {

	waitUntil {(headgear player) in HVP_gasMasks || (goggles player) in HVP_gasMasks};
		playsound "echipare";
		sleep 2.5;
		overlayeffects = 0 spawn fnc_overlay;
		sleep 0.5;
		0 fadeSound (soundVolume/6);

		[] spawn {
			while {(headgear player) in HVP_gasMasks || (goggles player) in HVP_gasMasks && alive player} do {
				_int_b = linearConversion [0, 1,(getFatigue player), 5, 0, true];
				playsound "breath";
				sleep (2 + _int_b);
			};
		};

	waitUntil {!((headgear player) in HVP_gasMasks) && !((goggles player) in HVP_gasMasks) || !alive player};
		playsound "dezechipare";
		terminate overlayeffects;
		0 cutText ["","PLAIN"];
		0 fadeSound 1;

	sleep 0.1;
};