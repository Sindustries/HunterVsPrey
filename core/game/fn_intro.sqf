/*
	File: welcomecredits.sqf
	Author: HellsGateGaming.com - Edited by Sin for HVP2
	Date: 14/12/2013
	Description:
	Creates an intro on the bottom-right hand corner of the screen.
*/

_onScreenTime = 8;

_role1 = "Special Thanks";
_role1names = ["VELTEN, TheMightyFoz, Sovereign, Commando, Shadow, Feather, C.Foley, Minxx, Vyper, Nathan, Josh, Sycorax"];
_role1b = "Special Thanks cont.";
_role1bnames = ["Finchy, Panchito, JooseY,	Crumbs, Tyseen, Kyle, Tivvroxx, Mishka, Reece (x2)"];
_role2 = "Mod Credits";
_role2names =["ACE3 by ACE Team", "MOCAP Melee by Kol9yN", "Blastcore Phoenix by Opticalsnare"];
_role3 = "Script Credits";
_role3names = ["Player Markers script by Ceh", "TPW Animals and TPW Air by TPW", "Tear Gas script by Taw_jarhead"];
_role4 = "Script Credits cont.";
_role4names = ["Cloaking script by XxRTEKxX, HallyG and DreadedEntity"];
 
{
sleep 2;
_memberFunction = _x select 0;
_memberNames = _x select 1;
_finalText = format ["<t size='0.60' color='#F79727' align='right'>%1<br /></t>", _memberFunction];
_finalText = _finalText + "<t size='0.50' color='#FFFFFF' align='right'>";
{_finalText = _finalText + format ["%1<br />", _x]} forEach _memberNames;
_finalText = _finalText + "</t>";
_onScreenTime + (((count _memberNames) - 1) * 2);
[
_finalText,
[safezoneX + safezoneW - 0.8,0.50], //DEFAULT: 0.5,0.35
[safezoneY + safezoneH - 0.8,0.7], //DEFAULT: 0.8,0.7
_onScreenTime,
0.5
] spawn BIS_fnc_dynamicText;
sleep (_onScreenTime);
} forEach [
//The list below should have exactly the same amount of roles as the list above
[_role1, _role1names],
[_role1b, _role1bnames],
[_role2, _role2names],
[_role3, _role3names],
[_role4, _role4names]
];