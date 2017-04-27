/*
	HVP2 Parasmoke
	By Sinbane
	Attches a smoke grenade or flare-trail to a parachuting player
*/
private ["_smoke","_attached"];

_attached = false;

//-----------------------------------

	waitUntil {(getPos player select 2) < 200 && animationState player isEqualTo "para_pilot"};

	while {animationState player isEqualTo "para_pilot"} do {
		if (sunOrMoon < 1) then {
			if (HVPGameType isEqualTo 1) then {
				if (side player isEqualTo EAST || side player isEqualTo RESISTANCE) then {
					player action ["nvGoggles", player];
				};
			};
			if (side player isEqualTo WEST || HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
				_smoke = "F_20mm_White" createVehicle (player ModelToWorld [0,5,5]);
				_smoke setVelocity [0,0,-7];
				sleep 4;
			};
		} else {
			player action ["nvGogglesOff", player];
			if (side player isEqualTo WEST || HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
				if (!_attached) then {
					_smoke = createVehicle ["SmokeShellBlue", (getposATL player), [], 0, "NONE"];
					_smoke attachTo [vehicle player, [0,0,0.15]];
					_attached = true;
				};
			};
		};
	};

	waitUntil {(getPos player select 2) < 1 || isTouchingGround player};

	if (_attached) then {
		detach _smoke;
	};

	if (playerSide isEqualTo resistance && HVPGameType isEqualTo 1) then {
		player action ["nvGogglesOff", player];
	};

//-----------------------------------