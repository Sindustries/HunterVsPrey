/*
	fn_monitor
	Author: Sinbane
	Monitors unit vitals & gives option to heal up and stop bleeding when above 75% health
*/
//-----------------------------------

	private ["_unit","_healAction"];

	_unit = _this select 0;

	while {alive _unit} do {

		waitUntil {sleep 3; (damage _unit) >= 0 && (damage _unit) < 0.1};

		if ((damage _unit) >= 0 && (damage _unit) < 0.1 && ("FirstAidKit" in (items _unit)) && vehicle player isEqualTo player) then {
			SMS_healAction = true;
			_healAction = _unit addAction ["Stop Bleeding", {
				private ["_unit","_damage"];
				_unit = _this select 0;
				_damage = (damage _unit);
				_unit action ["HealSoldierSelf", _unit];
				//waitUntil {animationState _unit isEqualTo "ainvpknlmstpslaywnondnon_medic" || animationState _unit isEqualTo "ainvppnemstpslaywnondnon_medic" || animationState _unit isEqualTo "ainvpknlmstpslaywrfldnon_medic"};
				//waitUntil {animationState _unit != "ainvpknlmstpslaywnondnon_medic" || animationState _unit != "ainvpknlmstpslaywnondnon_medic" || animationState _unit != "ainvpknlmstpslaywrfldnon_medic"};
				_unit removeItem "FirstAidKit";
				_unit setVariable ["SMS_bleedingRate", 0];
				_unit setDamage 0;
				_unit removeAction (_this select 2);
				SMS_healAction = false;
			}];
			while {SMS_healAction} do {
				if (!("FirstAidKit" in (items _unit))) then {
					SMS_healAction = false;
					_unit removeAction _healAction;
				};
				if ((damage _unit) isEqualTo 0 || (damage _unit) > 0.1) then {
					SMS_healAction = false;
					_unit removeAction _healAction;
				};
				if (vehicle player != player) then {
					SMS_healAction = false;
					_unit removeAction _healAction;
				};
				sleep 0.5;
			};
		};
		sleep 0.5;
		SMS_healAction = false;
		sleep 0.5;
	};