/*
	fn_getSetting
	Author: Sinbane
	Grabs setting from missionNamespace
*/
private ["_setting","_cfg","_return"];
//-----------------------------------

_setting = _this select 0;

//-----------------------------------
//-FIND IT!

_return = missionNamespace getVariable _setting;

_return;