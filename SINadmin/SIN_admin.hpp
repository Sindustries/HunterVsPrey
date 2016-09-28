class SIN_admin
{
	idd = -1;
	movingenable = true;
//  onLoad = "_this call FRAME_01_Load";

class controls
{

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Sinbane, v1.063, #Luqune)
////////////////////////////////////////////////////////

class sinBGframe: RscFrame
{
	idc = 1800;
	x = 0.314375 * safezoneW + safezoneX;
	y = 0.357 * safezoneH + safezoneY;
	w = 0.175313 * safezoneW;
	h = 0.297 * safezoneH;
};
class sinmainbg: IGUIBack
{
	idc = 2201;
	x = 0.314375 * safezoneW + safezoneX;
	y = 0.357 * safezoneH + safezoneY;
	w = 0.175313 * safezoneW;
	h = 0.297 * safezoneH;
	colorBackground[] = {-1,-1,-1,0.7};
};
class SINplayer1Frm: RscFrame
{
	idc = 1801;
	text = "SELECT TARGET"; //--- ToDo: Localize;
	x = 0.319531 * safezoneW + safezoneX;
	y = 0.357 * safezoneH + safezoneY;
	w = 0.159844 * safezoneW;
	h = 0.055 * safezoneH;
	sizeEX = "0.016 / (getResolution select 5)";
};
class SINCMDfrm: RscFrame
{
	idc = 1803;
	text = "COMMANDS"; //--- ToDo: Localize;
	x = 0.319531 * safezoneW + safezoneX;
	y = 0.423 * safezoneH + safezoneY;
	w = 0.165 * safezoneW;
	h = 0.22 * safezoneH;
	sizeEX = "0.016 / (getResolution select 5)";
};
class sinbgtop: IGUIBack
{
	idc = 2200;
	x = 0.314375 * safezoneW + safezoneX;
	y = 0.335 * safezoneH + safezoneY;
	w = 0.175313 * safezoneW;
	h = 0.022 * safezoneH;
	colorBackground[] = {-1,-1,-1,1};
};
class sinMenutxt: RscText
{
	idc = 1000;
	text = "ADMIN MENU"; //--- ToDo: Localize;
	x = 0.37625 * safezoneW + safezoneX;
	y = 0.335 * safezoneH + safezoneY;
	w = 0.0515625 * safezoneW;
	h = 0.022 * safezoneH;
	tooltip = "by Sinbane"; //--- ToDo: Localize;
	sizeEX = "0.016 / (getResolution select 5)";
};
class sinPlayer1List: RscCombo
{
	idc = 2100;
	x = 0.324687 * safezoneW + safezoneX;
	y = 0.379 * safezoneH + safezoneY;
	w = 0.149531 * safezoneW;
	h = 0.022 * safezoneH;
	sizeEX = "0.016 / (getResolution select 5)";
};
class sinTPCMD: RscButton
{
	idc = 1600;
	text = "TELEPORT"; //--- ToDo: Localize;
	x = 0.324687 * safezoneW + safezoneX;
	y = 0.445 * safezoneH + safezoneY;
	w = 0.0721875 * safezoneW;
	h = 0.022 * safezoneH;
	tooltip = "Teleport to selected player"; //--- ToDo: Localize;
	sizeEX = "0.016 / (getResolution select 5)";
	action = "call SIN_fnc_Teleport";
};
class sindisabledmgcmd: RscButton
{
	idc = 1601;
	text = "INVULNERABLE"; //--- ToDo: Localize;
	x = 0.324687 * safezoneW + safezoneX;
	y = 0.511 * safezoneH + safezoneY;
	w = 0.0721875 * safezoneW;
	h = 0.022 * safezoneH;
	tooltip = "Makes selected player invulnerable to damage"; //--- ToDo: Localize;
	sizeEX = "0.016 / (getResolution select 5)";
	action = "call SIN_fnc_Invulnerable";
};
class SINdisablefatiguecmd: RscButton
{
	idc = 1603;
	text = "DISABLE FATIGUE"; //--- ToDo: Localize;
	x = 0.324687 * safezoneW + safezoneX;
	y = 0.478 * safezoneH + safezoneY;
	w = 0.0721875 * safezoneW;
	h = 0.022 * safezoneH;
	tooltip = "Disables fatigue for selected players"; //--- ToDo: Localize;
	sizeEX = "0.016 / (getResolution select 5)";
	action = "call SIN_fnc_Fatigue";
};
class sinKICKcmd: RscButton
{
	idc = 1604;
	text = "KICK"; //--- ToDo: Localize;
	x = 0.324687 * safezoneW + safezoneX;
	y = 0.577 * safezoneH + safezoneY;
	w = 0.0721875 * safezoneW;
	h = 0.022 * safezoneH;
	tooltip = "Kick player to lobby"; //--- ToDo: Localize;
	sizeEX = "0.016 / (getResolution select 5)";
	action = "call SIN_fnc_Kick";
};
class sininvisible: RscButton
{
	idc = 1606;
	text = "INVISIBLE"; //--- ToDo: Localize;
	x = 0.324687 * safezoneW + safezoneX;
	y = 0.544 * safezoneH + safezoneY;
	w = 0.0721875 * safezoneW;
	h = 0.022 * safezoneH;
	tooltip = "Makes selected player invisible"; //--- ToDo: Localize;
	sizeEX = "0.016 / (getResolution select 5)";
	action = "call SIN_fnc_Invisible";
};
class sinresetcmdbtn: RscButton
{
	idc = 1607;
	text = "RESET"; //--- ToDo: Localize;
	x = 0.324687 * safezoneW + safezoneX;
	y = 0.61 * safezoneH + safezoneY;
	w = 0.0721875 * safezoneW;
	h = 0.022 * safezoneH;
	tooltip = "Resets player"; //--- ToDo: Localize;
	sizeEX = "0.016 / (getResolution select 5)";
	action = "call SIN_fnc_Reset";
};
class sinTP2btn: RscButton
{
	idc = 1602;
	text = "TELEPORT 2"; //--- ToDo: Localize;
	x = 0.407187 * safezoneW + safezoneX;
	y = 0.445 * safezoneH + safezoneY;
	w = 0.0721875 * safezoneW;
	h = 0.022 * safezoneH;
	tooltip = "Teleports player to you"; //--- ToDo: Localize;
	sizeEX = "0.016 / (getResolution select 5)";
	action = "call SIN_fnc_TeleportToAdmin";
};
class sinNVGbtn: RscButton
{
	idc = 1605;
	text = "GIVE NIGHT VISION"; //--- ToDo: Localize;
	x = 0.407187 * safezoneW + safezoneX;
	y = 0.478 * safezoneH + safezoneY;
	w = 0.0721875 * safezoneW;
	h = 0.022 * safezoneH;
	tooltip = "Gives player NVG's"; //--- ToDo: Localize;
	sizeEX = "0.016 / (getResolution select 5)";
	action = "call SIN_fnc_NightVision";
};
class sinUNUSED3btn: RscButton
{
	idc = 1608;
	text = "FULLY HEAL"; //--- ToDo: Localize;
	x = 0.407187 * safezoneW + safezoneX;
	y = 0.511 * safezoneH + safezoneY;
	w = 0.0721875 * safezoneW;
	h = 0.022 * safezoneH;
	tooltip = "UNUSED"; //--- ToDo: Localize;
	sizeEX = "0.016 / (getResolution select 5)";
	action = "call SIN_fnc_fullHeal";
};
class sinUNUSED4btn: RscButton
{
	idc = 1609;
	text = "UNUSED"; //--- ToDo: Localize;
	x = 0.407187 * safezoneW + safezoneX;
	y = 0.544 * safezoneH + safezoneY;
	w = 0.0721875 * safezoneW;
	h = 0.022 * safezoneH;
	tooltip = "UNUSED"; //--- ToDo: Localize;
	sizeEX = "0.016 / (getResolution select 5)";
};
class sinUNUSED5btn: RscButton
{
	idc = 1610;
	text = "UNUSED"; //--- ToDo: Localize;
	x = 0.407187 * safezoneW + safezoneX;
	y = 0.577 * safezoneH + safezoneY;
	w = 0.0721875 * safezoneW;
	h = 0.022 * safezoneH;
	tooltip = "UNUSED"; //--- ToDo: Localize;
	sizeEX = "0.016 / (getResolution select 5)";
};
class sinUNUSED6btn: RscButton
{
	idc = 1611;
	text = "UNUSED"; //--- ToDo: Localize;
	x = 0.407187 * safezoneW + safezoneX;
	y = 0.61 * safezoneH + safezoneY;
	w = 0.0721875 * safezoneW;
	h = 0.022 * safezoneH;
	tooltip = "UNUSED"; //--- ToDo: Localize;
	sizeEX = "0.016 / (getResolution select 5)";
	action = "";
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////


};
};
