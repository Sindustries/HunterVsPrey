class HVP_HUD
{
	idd = 100;
	fadeout=1;
	fadein=3;
	duration = 1e+1000;
	movingenable = false;
//  onLoad = "_this call FRAME_01_Load";

class controlsBackground
{
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Sinbane, v1.063, #Zatyre)
////////////////////////////////////////////////////////

class HVPHUDBG: IGUIBack
{
	idc = 2200;
	x = 0.432969 * safezoneW + safezoneX;
	y = -0.00599999 * safezoneH + safezoneY;
	w = 0.134062 * safezoneW;
	h = 0.044 * safezoneH;
};
class HVPHUDabilfrm: RscFrame
{
	idc = 1800;
	x = 0.432969 * safezoneW + safezoneX;
	y = -0.00599999 * safezoneH + safezoneY;
	w = 0.0825 * safezoneW;
	h = 0.044 * safezoneH;
};
class HVPHUDphasefrm: RscFrame
{
	idc = 1801;
	x = 0.515469 * safezoneW + safezoneX;
	y = -0.00599999 * safezoneH + safezoneY;
	w = 0.0515625 * safezoneW;
	h = 0.044 * safezoneH;
};
class HVPHUDabilttltxt: RscText
{
	idc = 1000;
	text = "ABILITY"; //--- ToDo: Localize;
	x = 0.459781 * safezoneW + safezoneX;
	y = 0.00279997 * safezoneH + safezoneY;
	w = 0.0309375 * safezoneW;
	h = 0.011 * safezoneH;
	font = "PuristaMedium";
	sizeEX = "0.016 / (getResolution select 5)";
};
class HVPHUDphasettltxt: RscText
{
	idc = 1002;
	text = "TIMER"; //--- ToDo: Localize;
	x = 0.529906 * safezoneW + safezoneX;
	y = 0.00279997 * safezoneH + safezoneY;
	w = 0.020625 * safezoneW;
	h = 0.011 * safezoneH;
	font = "PuristaMedium";
	sizeEX = "0.016 / (getResolution select 5)";
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

};
};
