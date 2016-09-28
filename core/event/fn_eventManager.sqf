/*
	HVP Event Manager
	By Sinbane
	Loads events and keeps them running
*/
private ["_common","_uncommon","_rare"];
//-----------------------------------
//-DEFINABLE
[] spawn {
	while {true} do {
		HVP_commonEvent = (HVPEventTime+(random HVPEventTime)-(random HVPEventTime));
		HVP_uncommonEvent = (HVPEventTime*1.5+(random HVPEventTime)-(random HVPEventTime));
		HVP_rareEvent = (HVPEventTime*2+(random HVPEventTime)-(random HVPEventTime));
		sleep 30;
	};
};
//-----------------------------------
//-LOAD EVENTS
if (isServer && HVPEventsEnabled isEqualTo 1) then {
//-----------------------------------
//-AIRDROPS

	[] spawn {
		private ["_time","_posFound","_dropPos","_posCheck","_heliSpawnPos"];
		waitUntil {sleep 5; HVP_phase_num >= 1};

		while {true} do {
			if (HVPLegacyMode isEqualTo 0) then {
				sleep HVP_commonEvent;
			} else {
				sleep ((HVP_commonEvent)/2);
			};
			_posFound = false;
			while {!_posFound} do {
				_dropPos = [HVP_phase_pos,0,(HVP_phase_radius * 0.9),0,0,0,0] call BIS_fnc_findSafePos;
				_posCheck = [_dropPos] call SIN_fnc_checkPos;
				if (_posCheck) then {
					_heliSpawnPos = [HVP_phase_pos,(HVPZoneSizeMax * 1.25),(HVPZoneSizeMax * 1.5),0,1,0,0] call BIS_fnc_findSafePos;
					_posCheck = [_heliSpawnPos] call SIN_fnc_checkPos;
					if (_posCheck) then {
						_posFound = true;
						["event",_dropPos,_heliSpawnPos] call HVP_fnc_airdrop;
					};
				};
			};
		};
	};
	
//-----------------------------------
//-DROP POD

	[] spawn {
		private ["_posFound","_dropPos","_posCheck"];
		waitUntil {sleep 5; HVP_phase_num >= 1};

		while {true} do {
			sleep HVP_uncommonEvent;
			
			_posFound = false;
			while {!_posFound} do {
				_dropPos = [HVP_phase_pos,0,HVP_phase_radius,0,0,0,0] call BIS_fnc_findSafePos;
				_posCheck = [_dropPos] call SIN_fnc_checkPos;
				if (_posCheck) then {
					_posFound = true;
					[_dropPos] call HVP_fnc_dropPod;
				};
			};
		};
	};

//-----------------------------------
//-HELICRASH


	[] spawn {
		private ["_posFound","_helicrash_pos","_posCheck"];
		waitUntil {sleep 5; HVP_phase_num >= 1};
		
		while {true} do {
			sleep HVP_rareEvent;
			
			_posFound = false;
			while {!_posFound} do {
				_helicrash_pos = [HVP_phase_pos,0,(HVP_phase_radius * 0.9),0,0,0,0] call BIS_fnc_findSafePos;
				_posCheck = [_helicrash_pos] call SIN_fnc_checkPos;
				if (_posCheck) then {
					_posFound = true;
					[_helicrash_pos] call HVP_fnc_heliCrash;
				};
			};
		};
	};

//-----------------------------------
};
if (isServer && HVPExtEvents isEqualTo 1) then {
//-----------------------------------
//-ARTILLERY

	private ["_vehCount","_missileCount"];
	
	_vehCount = 4;
	_missileCount = 12;

	[_vehCount,_missileCount] spawn {
		private ["_posFound","_artyPos","_posCheck","_vehCount","_missileCount"];

		_vehCount = _this select 0;
		_missileCount = _this select 1;

		while {true} do {

			waitUntil {sleep 5; HVP_phase_active isEqualTo "true"};
			sleep HVP_uncommonEvent;
			
			_posFound = false;
			while {!_posFound} do {
				_artyPos = [HVP_phase_pos,0,(HVP_phase_radius * 0.9),0,0,0,0] call BIS_fnc_findSafePos;
				_posCheck = [_artyPos] call SIN_fnc_checkPos;
				if (_posCheck) then {
					_posFound = true;
					[_artyPos,_vehCount,_missileCount] call HVP_fnc_artillery;
				};
			};
		};
	};
	
//-----------------------------------
//-CHEMICAL ATTACK

	[] spawn {
		private ["_size","_gasCount","_posFound","_chemPos","_posCheck"];
		while {true} do {
			waitUntil {sleep 5; HVP_phase_active isEqualTo "true"};
			sleep HVP_commonEvent;
			
			_size = (HVP_Phase_Radius * 0.05);
			_gasCount = (_size / 1.25);
			
			_posFound = false;
			while {!_posFound} do {
				_chemPos = [HVP_phase_pos,0,(HVP_phase_radius * 0.9),0,0,0,0] call BIS_fnc_findSafePos;
				_posCheck = [_chemPos] call SIN_fnc_checkPos;
				if (_posCheck) then {
					_posFound = true;
					[_chemPos,_size,_gasCount] call HVP_fnc_chemAttack;
				};
			};
		};
	};

//-----------------------------------
//-QUAKE

	[] spawn {
		private ["_posFound","_quakePos","_posCheck","_posFound"];
		waitUntil {sleep 5; HVP_phase_num >= 1};
		
		while {true} do {
			sleep HVP_uncommonEvent;
			
			_posFound = false;
			while {!_posFound} do {
				_quakePos = [HVP_phase_pos,0,(HVP_phase_radius * 0.9),0,1,0,0] call BIS_fnc_findSafePos;
				_posCheck = [_quakePos] call SIN_fnc_checkPos;
				if (_posCheck) then {
					_posFound = true;
					[_quakePos] call HVP_fnc_quake;
				};
			};
		};
	};
	
//-----------------------------------
//-NUKE	
	
	[] spawn {
		private ["_posFound","_nukePos","_nuke","_posCheck","_posFound"];
		waitUntil {sleep 5; HVP_phase_num >= 1};
		
		while {true} do {
			sleep HVP_rareEvent;
			
			_posFound = false;
			while {!_posFound} do {
				_nukePos = [HVP_phase_pos,0,(HVP_phase_radius * 0.9),0,0,0,0] call BIS_fnc_findSafePos;
				_posCheck = [_nukePos] call SIN_fnc_checkPos;
				if (_posCheck) then {
					_posFound = true;
					_nuke = createVehicle ["I_UAV_01_F",_nukePos, [], 0, "NONE"];
					_nuke hideObjectGlobal true;
					[_nuke,(HVP_phase_radius * 0.2),true,true,true,true] call HVP_fnc_nuke;
				};
			};
			sleep HVP_uncommonEvent;
		};
	};
	
//-----------------------------------
//-UAV

	[] spawn {
		private ["_temp","_uavScanSize","_uavTime","_uavUpdate","_posFound","_uavScanPos","_posCheck","_uavSpawnPos","_posCheck2"];
		_temp = createVehicle ["I_UAV_01_F",[0,0,0], [], 0, "FLY"];
		sleep 1;
		deleteVehicle _temp;
		
		while {true} do {
		
			waitUntil {sleep 5; HVP_phase_active isEqualTo "true"};
			sleep HVP_rareEvent;
			
			_uavScanSize = (HVP_Phase_Radius * 0.2);
			_uavTime = 60 +(random HVPPhaseTime);
			_uavUpdate = 3;
			
			_posFound = false;
			while {!_posFound} do {
				_uavScanPos = [HVP_phase_pos,0,(HVP_phase_radius * 0.9),0,0,0,0] call BIS_fnc_findSafePos;
				_posCheck = [_uavScanPos] call SIN_fnc_checkPos;
				if (_posCheck) then {
					_uavSpawnPos = [_uavScanPos,400,800,0,0,0,0] call BIS_fnc_findSafePos;
					_posCheck2 = [_uavScanPos] call SIN_fnc_checkPos;
					if (_posCheck2) then {
						_posFound = true;
						[_uavScanPos,_uavSpawnPos,_uavScanSize,_uavTime,_uavUpdate] call HVP_fnc_uav;
					};
				};
			};
		};
	};

//-----------------------------------
};
//-----------------------------------
//-PARANORMAL

if (HVPParanormalEvent isEqualTo 1 && side player != sideLogic) then {
	[] spawn HVP_fnc_paranormal;
};

//-----------------------------------