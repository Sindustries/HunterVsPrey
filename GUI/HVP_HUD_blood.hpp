class HVPHUD_blood
{
	idd = 88;
	fadeout=1;
	fadein=1;
	duration = 1e+1000;
	onLoad = "uiNameSpace setVariable ['HVPHUDBloodcount', (_this select 0) displayCtrl 204];";
	
	class controls
	{		
		class HVPHUDBloodBG: IGUIBack
		{
			idc = 2201;
			x = 0.567031 * safezoneW + safezoneX;
			y = -0.00599999 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class HVPHUDBloodFRM: RscFrame
		{
			idc = 1802;
			x = 0.567031 * safezoneW + safezoneX;
			y = -0.00599999 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class HVPHUD_bloodimg: RscPicture
		{
			idc = 208;
			text = "GUI\img\blood.paa";
			x = 0.570125 * safezoneW + safezoneX;
			y = 0.0138 * safezoneH + safezoneY;
			w = 0.0103125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class HVPHUDbloodtxt: RscText
		{
			idc = 1005;
			text = "BLOOD"; //--- ToDo: Localize;
			x = 0.572187 * safezoneW + safezoneX;
			y = 0.00279997 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.011 * safezoneH;
			font = "PuristaMedium";
			sizeEX = "0.016 / (getResolution select 5)";
			//colorText[] = {1,1,1,1};
		};
		class HVPHUDBloodcount: RscText
		{
			idc = 204;
			text = "100%"; //--- ToDo: Localize;
			x = 0.579407 * safezoneW + safezoneX;
			y = 0.0204 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.011 * safezoneH;
			font = "PuristaMedium";
			sizeEX = "0.016 / (getResolution select 5)";
			colorText[] = {1,1,1,1};
		};
	};
};

