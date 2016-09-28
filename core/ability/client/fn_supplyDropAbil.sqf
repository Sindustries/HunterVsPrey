//-----------------------------------
//-CALL THE AIRDROP
private ["_heliSelection","_cfg","_i","_cfgName"];

(findDisplay 46) displayRemoveEventHandler ["KeyDown", SIN_abilityDEH];

_heliSelection = [];
_cfg = (configFile >> "CfgVehicles");
for "_i" from 0 to ((count _cfg)-1) do {
	if (isClass (_cfg select _i)) then {
		_cfgName = configName (_cfg select _i);			
		if (_cfgName isKindOf "VTOL_Base_F" && (getNumber ((_cfg select _i) >> "scope") == 2) && (getNumber ((_cfg select _i) >> "isUav")) == 0) then {
			_heliSelection pushBackUnique _cfgName;
		};
	};
};

titleText ["SUPPLY DROP INCOMING", "PLAIN DOWN", 0.5];
["ability",_heliSelection,(getPos Player)] call HVP_fnc_airdrop;

titleText ["SUPPLY DROP DEPLOYED", "PLAIN DOWN", 0.5];

//-----------------------------------	