class HVPHUD_ability
{
	idd = 50;
	fadeout=1;
	fadein=3;
	duration = 1e+1000;
	onLoad = "uiNameSpace setVariable ['HVP_HUD_AbilTitle', (_this select 0) displayCtrl 101];";

	class controls
	{
		class HVPHUD_scAbility
		{
			idc = 101;
			type = 0;
			style = 2;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.0204 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.011 * safezoneH;
			font = "PuristaLight";
			sizeEX = "0.016 / (getResolution select 5)";
			colorBackground[] = {0,0,0,0};
            colorText[] = {1,1,1,1};
			text = "";
		};
	};
};

class HVPHUD_phase
{
	idd = 60;
	fadeout=1;
	fadein=3;
	duration = 1e+1000;
	onLoad = "uiNameSpace setVariable ['HVP_HUD_PhaseTitle', (_this select 0) displayCtrl 102];";

	class controls
	{
		class HVPHUD_scPhase
		{
			idc = 102;
			type = 0;
			style = 2;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.0204 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.011 * safezoneH;
			font = "PuristaMedium";
			sizeEX = "0.016 / (getResolution select 5)";
			colorBackground[] = {0,0,0,0};
            colorText[] = {1,1,1,1};
			text = "";
		};
	};
};

class HVPHUDProgressBar
{
	name = "HVPHUDProgressBar";
	idd = 37200;
	fadein=1;
	duration = 1e+1000;
	fadeout=3;
	movingEnable = 0;
	onLoad = "uiNamespace setVariable ['PBarProgress', (_this select 0) displayCtrl 103];";

	class controls
	{
		class background: ProgressBaseTextHUD
		{
			idc = 37201;

			x = 0.43297 * safezoneW + safezoneX;
			y = 0.0479 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.0055 * safezoneH;
			colorBackground[] = {1,0,0,0.4};
		};
		class Progress: RscProgressBar
		{
			idc = 103;
			text = ""; //--- ToDo: Localize;
			x = 0.43297 * safezoneW + safezoneX;
			y = 0.0479 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.0055 * safezoneH;
		};
	};
};

class HVPHUDHPBar
{
	name = "HVPHUDHPBar";
	idd = 37201;
	fadein=1;
	duration = 1e+1000;
	fadeout=3;
	movingEnable = 0;
	onLoad = "uiNamespace setVariable ['HPBarProgress', (_this select 0) displayCtrl 1354];";

	class controls
	{
		class background: ProgressBaseTextHUD
		{
			idc = 37202;

			x = 0.432969 * safezoneW + safezoneX;
			y = 0.0402 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.0055 * safezoneH;
			colorBackground[] = {1,0,0,0.4};
		};
		class Progress: RscProgressBar
		{
			idc = 1354;
			text = ""; //--- ToDo: Localize;
			x = 0.432969 * safezoneW + safezoneX;
			y = 0.0402 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.0055 * safezoneH;
		};
	};
};

class HVPHUDhpBarPR: RscButtonMenu
{
	idc = 2401;
	text = "PROGRESS BAR HERE PLEASE"; //--- ToDo: Localize;

};
class HVPHUDProgressBarLocation: RscButtonMenu
{
	idc = 2400;
	text = "PROGRESS BAR HERE PLEASE"; //--- ToDo: Localize;

};

class HVPHUDartyImg
{
	idd = 60;
	fadeout=1;
	fadein=1;
	duration = 1e+1000;
	onLoad = "uiNameSpace setVariable ['HVPHUD_artyImg', (_this select 0) displayCtrl 165];";

	class controls
	{
		class HVPHUDartyBG: IGUIBack
		{
			idc = 2267;
			x = 0.329844 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class HVPHUDartyFRM: RscFrame
		{
			idc = 1268;
			x = 0.329844 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class HVPHUB_artyIcon: RscPicture
		{
			idc = 165;
			text = "GUI\img\artillery.paa";
			x = 0.329844 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.033 * safezoneH;
		};
	};
};

class HVPHUDquakeImg
{
	idd = 60;
	fadeout=1;
	fadein=1;
	duration = 1e+1000;
	onLoad = "uiNameSpace setVariable ['HVPHUD_quakeImg', (_this select 0) displayCtrl 166];";

	class controls
	{
		class HVPHUDquakeBG: IGUIBack
		{
			idc = 2269;
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class HVPHUDartyFRM: RscFrame
		{
			idc = 1270;
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class HVPHUD_quakeIcon: RscPicture
		{
			idc = 166;
			text = "GUI\img\quake.paa";
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.033 * safezoneH;
		};
	};
};

class HVPHUDuavImg
{
	idd = 60;
	fadeout=1;
	fadein=1;
	duration = 1e+1000;
	onLoad = "uiNameSpace setVariable ['HVPHUD_uavImg', (_this select 0) displayCtrl 167];";

	class controls
	{
		class HVPHUDuavBG: IGUIBack
		{
			idc = 2271;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class HVPHUDuavFRM: RscFrame
		{
			idc = 1272;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class HVPHUD_uavIcon: RscPicture
		{
			idc = 167;
			text = "GUI\img\uav.paa";
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.033 * safezoneH;
		};
	};
};

class HVPHUDchemImg
{
	idd = 60;
	fadeout=1;
	fadein=1;
	duration = 1e+1000;
	onLoad = "uiNameSpace setVariable ['HVPHUD_chemImg', (_this select 0) displayCtrl 168];";

	class controls
	{
		class HVPHUDchemBG: IGUIBack
		{
			idc = 2273;
			x = 0.355625 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class HVPHUDchemFRM: RscFrame
		{
			idc = 1274;
			x = 0.355625 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			h = 0.033 * safezoneH;
			w = 0.020625 * safezoneW;
		};
		class HVPHUD_chemAttackIcon: RscPicture
		{
			idc = 168;
			text = "GUI\img\chemattack.paa";
			x = 0.355625 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.033 * safezoneH;
		};
	};
};

class HVPHUDcamoTimer
{
	idd = 60;
	fadeout=1;
	fadein=3;
	duration = 1e+1000;
	onLoad = "uiNameSpace setVariable ['HVPHUD_camoTimer', (_this select 0) displayCtrl 3537];";

	class controls
	{
		class HVPHUDcamoBG: IGUIBack
		{
			idc = 3273;
			x = 0.288594 * safezoneW + safezoneX;
			y = -0.00599999 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class HVPHUDcamoFRM: RscFrame
		{
			idc = 3274;
			x = 0.288594 * safezoneW + safezoneX;
			y = -0.00599999 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class HVPHUDcamoTXT: RscText
		{
			idc = 3676;
			type = 0;
			style = 2;
			text = "Z-CAMO"; //--- ToDo: Localize;
			x = 0.292719 * safezoneW + safezoneX;
			y = 0.00279997 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.011 * safezoneH;
			font = "PuristaMedium";
			sizeEX = "0.016 / (getResolution select 5)";
			colorBackground[] = {0,0,0,0};
            colorText[] = {1,1,1,1};
		};
		class HVPHUDcamoTXT2: RscText
		{
			idc = 3537;
			type = 0;
			style = 2;
			text = "12:34"; //--- ToDo: Localize;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.0204 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.011 * safezoneH;
			font = "PuristaMedium";
			sizeEX = "0.016 / (getResolution select 5)";
			colorBackground[] = {0,0,0,0};
            colorText[] = {1,1,1,1};
		};

	};
};