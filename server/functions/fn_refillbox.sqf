// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: fn_refillbox.sqf  "fn_refillbox"
//	@file Author: [404] Pulse , [404] Costlyy , [404] Deadbeat, AgentRev
//	@file Created: 22/1/2012 00:00
//	@file Args: [OBJECT (Weapons box that needs filling), STRING (Name of the fill to give to object)]

if (!isServer) exitWith {};

#define RANDOM_BETWEEN(START,END) ((START) + floor random ((END) - (START) + 1))
#define RANDOM_ODDS(ODDS) ([0,1] select (random 1 < (ODDS))) // between 0.0 and 1.0

private ["_box", "_boxType", "_boxItems", "_item", "_qty", "_mag"];
_box = _this select 0;
_boxType = _this select 1;

_box setVariable [call vChecksum, true];

_box allowDamage false; // No more fucking busted crates
_box setVariable ["allowDamage", false, true];
_box setVariable ["A3W_inventoryLockR3F", true, true];

// Clear pre-existing cargo first
//clearBackpackCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearItemCargoGlobal _box;

if (_boxType == "mission_USSpecial2") then { _boxType = "mission_USSpecial" };

switch (_boxType) do
{
	case "mission_USLaunchers":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", ["Laserdesignator", "Laserdesignator_02", "Laserdesignator_03"], 1, 1],
			["wep",[
				"launch_NLAW_F",
				["launch_RPG32_F", "launch_RPG32_ghex_F"],
				["launch_Titan_short_F", "launch_O_Titan_short_F", "launch_I_Titan_short_F", "launch_B_Titan_short_tna_F", "launch_O_Titan_short_ghex_F"],
				["launch_MRAWS_green_rail_F", "launch_MRAWS_olive_rail_F", "launch_MRAWS_sand_rail_F", "launch_MRAWS_green_F", "launch_MRAWS_olive_F", "launch_MRAWS_sand_F"],
				["launch_O_Vorona_brown_F", "launch_O_Vorona_green_F"]
			], RANDOM_BETWEEN(2,5), RANDOM_BETWEEN(1,3)],
			["wep", ["launch_Titan_F", "launch_O_Titan_F", "launch_I_Titan_F", "launch_B_Titan_tna_F", "launch_O_Titan_ghex_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(1,3)],
			["mag", ["APERSTripMine_Wire_Mag", "APERSBoundingMine_Range_Mag", "APERSMine_Range_Mag", "ClaymoreDirectionalMine_Remote_Mag"], RANDOM_BETWEEN(2,5)],
			["mag", ["SLAMDirectionalMine_Wire_Mag", "ATMine_Range_Mag", "DemoCharge_Remote_Mag", "SatchelCharge_Remote_Mag"], RANDOM_BETWEEN(2,5)],
			["mag", "HandGrenade", RANDOM_BETWEEN(5,10)],
			["mag", "1Rnd_HE_Grenade_shell", RANDOM_BETWEEN(5,10)],
			["itm", [["H_HelmetB", "H_HelmetIA"], ["H_HelmetSpecB", "H_HelmetSpecO_ocamo"], "H_HelmetLeaderO_ocamo"], RANDOM_BETWEEN(1,4)],
			["itm", [
				["V_PlateCarrier1_rgr", "V_PlateCarrier1_blk", "V_PlateCarrierIA1_dgtl"], // Lite
				["V_PlateCarrier2_rgr", "V_PlateCarrier2_blk", "V_PlateCarrierIA2_dgtl"], // Rig
				["V_PlateCarrierSpec_rgr", "V_PlateCarrierSpec_blk", "V_PlateCarrierSpec_mtp"], // Special
				["V_PlateCarrierGL_rgr", "V_PlateCarrierGL_blk", "V_PlateCarrierGL_mtp", "V_PlateCarrierIAGL_dgtl", "V_PlateCarrierIAGL_oli"] // GL
			], RANDOM_BETWEEN(1,4)]
		];
	};
	case "mission_USSpecial":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			//["itm", "NVGoggles", 5],
			["wep", ["Binocular", "Rangefinder"], RANDOM_BETWEEN(0,3)],
			["itm", "Medikit", RANDOM_BETWEEN(1,3)],
			["itm", "Toolkit", RANDOM_BETWEEN(1,3)],
			["itm", ["optic_Aco", "optic_Aco_grn", "optic_MRCO", "optic_Hamr", "optic_Arco"], RANDOM_BETWEEN(2,4)],
			["itm", ["muzzle_snds_M", "muzzle_snds_H", "muzzle_snds_H_MG", "muzzle_snds_B", "muzzle_snds_acp", ["muzzle_snds_338_black", "muzzle_snds_338_green", "muzzle_snds_338_sand"], ["muzzle_snds_93mmg", "muzzle_snds_93mmg_tan"]], RANDOM_BETWEEN(1,5)],
			["wep", [["MMG_02_sand_F", "MMG_02_camo_F", "MMG_02_black_F"], ["MMG_01_tan_F", "MMG_01_hex_F"]], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(2,4)],
			["wep", ["LMG_Mk200_F", "LMG_Zafir_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(2,4)],
			["wep", ["srifle_EBR_F", "srifle_DMR_01_F"], RANDOM_BETWEEN(0,2), RANDOM_BETWEEN(4,8)],
			["wep", ["srifle_LRR_LRPS_F", "srifle_LRR_camo_LRPS_F", "srifle_LRR_tna_LRPS_F", "srifle_GM6_LRPS_F", "srifle_GM6_camo_LRPS_F", "srifle_GM6_ghex_LRPS_F"], RANDOM_BETWEEN(0,2), RANDOM_BETWEEN(6,12)],
			["wep", "arifle_SDAR_F", RANDOM_BETWEEN(0,2), RANDOM_BETWEEN(3,5)],
			["wep", ["hgun_Pistol_heavy_01_F", "hgun_Pistol_heavy_01_MRD_F", "hgun_Pistol_heavy_02_F", "hgun_Pistol_heavy_02_Yorris_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(4,8)],
			["mag", "30Rnd_556x45_Stanag", RANDOM_BETWEEN(5,10)],
			["mag", "30Rnd_65x39_caseless_mag", RANDOM_BETWEEN(5,10)],
			["mag", "30Rnd_65x39_caseless_green", RANDOM_BETWEEN(5,10)],
			["mag", "9Rnd_45ACP_Mag", RANDOM_BETWEEN(5,10)],
			["mag", "16Rnd_9x21_Mag", RANDOM_BETWEEN(5,10)],
			["itm", [["H_HelmetB", "H_HelmetIA"], ["H_HelmetSpecB", "H_HelmetSpecO_ocamo"], "H_HelmetLeaderO_ocamo"], RANDOM_BETWEEN(1,4)],
			["itm", [
				["V_PlateCarrier1_rgr", "V_PlateCarrier1_blk", "V_PlateCarrierIA1_dgtl"], // Lite
				["V_PlateCarrier2_rgr", "V_PlateCarrier2_blk", "V_PlateCarrierIA2_dgtl"], // Rig
				["V_PlateCarrierSpec_rgr", "V_PlateCarrierSpec_blk", "V_PlateCarrierSpec_mtp"], // Special
				["V_PlateCarrierGL_rgr", "V_PlateCarrierGL_blk", "V_PlateCarrierGL_mtp", "V_PlateCarrierIAGL_dgtl", "V_PlateCarrierIAGL_oli"] // GL
			], RANDOM_BETWEEN(1,4)]
		];
	};
	case "mission_Main_A3snipers":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", "Rangefinder", RANDOM_BETWEEN(1,4)],
			["wep", ["srifle_LRR_LRPS_F", "srifle_LRR_camo_LRPS_F", "srifle_LRR_tna_LRPS_F", "srifle_GM6_LRPS_F", "srifle_GM6_camo_LRPS_F", "srifle_GM6_ghex_LRPS_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(6,12)],
			["wep", [
				["srifle_DMR_02_F", "srifle_DMR_02_camo_F", "srifle_DMR_02_sniper_F"], // MAR-10
				["srifle_DMR_03_F", "srifle_DMR_03_multicam_F", "srifle_DMR_03_khaki_F", "srifle_DMR_03_tan_F", "srifle_DMR_03_woodland_F"], // Mk-I
				["srifle_DMR_05_blk_F", "srifle_DMR_05_hex_F", "srifle_DMR_05_tan_f"], // Cyrus
				["srifle_DMR_06_camo_F", "srifle_DMR_06_olive_F"] // Mk14
			], RANDOM_BETWEEN(0,3), RANDOM_BETWEEN(5,10)],
			["wep", ["srifle_EBR_F", "srifle_DMR_01_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(5,10)],
			["itm", ["optic_SOS", "optic_DMS", "optic_LRPS"], RANDOM_BETWEEN(2,4)],
			["itm", ["optic_AMS", "optic_AMS_khk", "optic_AMS_snd", "optic_KHS_blk", "optic_KHS_hex", "optic_KHS_tan"], RANDOM_BETWEEN(1,3)],
			["itm", ["optic_tws", "optic_tws_mg", "optic_Nightstalker"], RANDOM_ODDS(0.5)],
			["itm", "optic_NVS", RANDOM_BETWEEN(1,3)],
			["itm", ["bipod_01_F_blk", "bipod_01_F_mtp", "bipod_01_F_snd", "bipod_02_F_blk", "bipod_02_F_hex", "bipod_02_F_tan", "bipod_03_F_blk", "bipod_03_F_oli"], RANDOM_BETWEEN(1,4)],
			["itm", ["muzzle_snds_B", ["muzzle_snds_338_black", "muzzle_snds_338_green", "muzzle_snds_338_sand"], ["muzzle_snds_93mmg", "muzzle_snds_93mmg_tan"]], RANDOM_BETWEEN(1,4)],
			["itm", [["H_HelmetB", "H_HelmetIA"], ["H_HelmetSpecB", "H_HelmetSpecO_ocamo"], "H_HelmetLeaderO_ocamo"], RANDOM_BETWEEN(1,4)],
			["itm", [
				["V_PlateCarrier1_rgr", "V_PlateCarrier1_blk", "V_PlateCarrierIA1_dgtl"], // Lite
				["V_PlateCarrier2_rgr", "V_PlateCarrier2_blk", "V_PlateCarrierIA2_dgtl"], // Rig
				["V_PlateCarrierSpec_rgr", "V_PlateCarrierSpec_blk", "V_PlateCarrierSpec_mtp"], // Special
				["V_PlateCarrierGL_rgr", "V_PlateCarrierGL_blk", "V_PlateCarrierGL_mtp", "V_PlateCarrierIAGL_dgtl", "V_PlateCarrierIAGL_oli"] // GL
			], RANDOM_BETWEEN(1,4)]
		];
	};
	case "airdrop_DLC_Rifles":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", ["srifle_DMR_03_multicam_F", "srifle_DMR_02_sniper_F", "srifle_DMR_05_hex_F", "srifle_DMR_04_Tan_F"], 4,4],
			["bac", ["B_Carryall_mcamo", "B_Kitbag_mcamo"], RANDOM_BETWEEN(2,5)],
			["itm", ["V_PlateCarrierIAGL_dgtl", "V_TacVest_camo", "V_PlateCarrierGL_rgr"], RANDOM_BETWEEN(4,8)],
			["itm", ["bipod_01_F_blk", "bipod_02_F_hex"], 3],
			["itm", ["optic_DMS","optic_AMS","optic_KHS_blk"], RANDOM_BETWEEN(3,5)],
			["itm", "ItemGPS", RANDOM_BETWEEN(0,1)],
			["itm", ["muzzle_snds_B", "muzzle_snds_338_black", "muzzle_snds_338_sand", "muzzle_snds_93mmg"], RANDOM_BETWEEN(3,5)]
		];
	};
	case "airdrop_DLC_LMGs":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", ["MMG_02_black_F", "MMG_02_camo_F","MMG_02_sand_F","MMG_01_hex_F","MMG_01_tan_F"], 4,4],
			["bac", ["B_Carryall_mcamo", "B_Kitbag_mcamo"], RANDOM_BETWEEN(2,5)],
			["itm", ["V_PlateCarrierIAGL_dgtl", "V_TacVest_camo", "V_PlateCarrierGL_rgr"], RANDOM_BETWEEN(1,8)],
			["itm", ["bipod_01_F_blk", "bipod_02_F_hex"], 2],
			["itm", ["optic_DMS","optic_AMS","optic_KHS_blk"], RANDOM_BETWEEN(3,5)],
			["itm", "ItemGPS", RANDOM_BETWEEN(0,1)],
			["itm", ["muzzle_snds_338_black", "muzzle_snds_338_sand", "muzzle_snds_93mmg"], RANDOM_BETWEEN(3,5)]
		];
	};
	case "airdrop_Snipers":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", ["srifle_LRR_LRPS_F", "srifle_LRR_camo_LRPS_F", "srifle_GM6_LRPS_F", "srifle_GM6_camo_LRPS_F"], RANDOM_BETWEEN(3,4), RANDOM_BETWEEN(6,8)],
			["wep", ["srifle_EBR_F", "srifle_DMR_01_F"], RANDOM_BETWEEN(2,3), RANDOM_BETWEEN(6,8)],
			["wep", ["Binocular", "Rangefinder"], RANDOM_BETWEEN(1,3)],
			["bac", ["B_Carryall_mcamo", "B_Kitbag_mcamo"], RANDOM_BETWEEN(2,5)],	
			["itm", "ItemGPS", RANDOM_BETWEEN(0,1)],
			["itm", ["optic_DMS","optic_AMS","optic_KHS_blk"], RANDOM_BETWEEN(5,8)]
		];
	};
	case "Diving_Gear": //diving equipment for squad of 2
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", "arifle_SDAR_F", 2, RANDOM_BETWEEN(4,6)],
			["itm", "V_RebreatherB", 2],
			["itm", "V_RebreatherIR", 2],
			["itm", "V_RebreatherIA", 2],
			["itm", "G_Diving", 2],
			["itm", "U_B_Wetsuit", 2],
			["itm", "U_O_Wetsuit", 2],
			["itm", "U_I_Wetsuit", 2],
			["itm", ["Chemlight_red", "Chemlight_green", "Chemlight_yellow", "Chemlight_blue"], RANDOM_BETWEEN(6,9)],
			["bac", ["B_Kitbag_mcamo", "B_Bergen_sgg", "B_FieldPack_khk", "B_Carryall_mcamo"], RANDOM_BETWEEN(3,5)]	
		];
	};
	case "mission_TOP_Sniper":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", ["srifle_LRR_SOS_F", "srifle_LRR_camo_SOS_F", "srifle_GM6_SOS_F", "srifle_GM6_camo_SOS_F"], RANDOM_BETWEEN(1,5), RANDOM_BETWEEN(4,6)],
			["wep", ["srifle_EBR_F", "srifle_DMR_01_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(4,6)],			
			["wep", "Rangefinder", RANDOM_BETWEEN(1,3)],
			["itm", ["optic_DMS","optic_AMS","optic_SOS"], RANDOM_BETWEEN(1,5)]
		];
	};
	case "mission_TOP_Gear1":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["itm", ["V_RebreatherB", "V_PlateCarrierIAGL_dgtl", "V_TacVest_camo", "V_PlateCarrierGL_rgr"], RANDOM_BETWEEN(1,8)],
			["itm", ["B_Carryall_mcamo", "B_Kitbag_mcamo"], RANDOM_BETWEEN(1,5)],
			["itm", ["U_B_HeliPilotCoveralls","U_B_Wetsuit","U_B_CombatUniform_mcam_vest"], RANDOM_BETWEEN(1,4)],
			["itm", ["H_HelmetCrew_B","H_CrewHelmetHeli_B","H_HelmetB_plain_blk","H_HelmetSpecB"], RANDOM_BETWEEN(1,5)]
		];
	};
	case "General_supplies":
	{
	_boxitems =
		[
			//first aid, medkit, tookit, gps, rangefinder, etc
			// Item type, Item class(es), # of items, # of magazines per weapon
			["itm", "FirstAidKit", RANDOM_BETWEEN(5,6)],
			["wep", ["Binocular", "Rangefinder", "Laserdesignator"], RANDOM_BETWEEN(3,5)],
			["wep", ["hgun_Pistol_heavy_01_F", "hgun_Pistol_heavy_01_MRD_F", "hgun_Pistol_heavy_02_F", "hgun_Pistol_heavy_02_Yorris_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(3,5)],
			["itm", "Medikit", RANDOM_BETWEEN(2,3)],
			["itm", "Toolkit", RANDOM_BETWEEN(2,3)],
			["itm", "Laserbatteries", RANDOM_BETWEEN(2,4)],
			["itm", "MineDetector", 3],
			["itm", ["H_CrewHelmetHeli_B","H_CrewHelmetHeli_O", "H_CrewHelmetHeli_I"], RANDOM_BETWEEN(2,4)],
			["bac", ["B_Kitbag_mcamo", "B_Bergen_sgg", "B_FieldPack_khk", "B_Carryall_mcamo"], RANDOM_BETWEEN(3,5)],
			["itm", ["V_PlateCarrierIAGL_dgtl", "V_TacVest_camo", "V_PlateCarrierGL_rgr"], RANDOM_BETWEEN(2,4)],
			["itm", ["Chemlight_red", "Chemlight_green", "Chemlight_yellow", "Chemlight_blue"], RANDOM_BETWEEN(6,9)],
			//["itm", ["V_RebreatherB", "U_B_Wetsuit"], RANDOM_BETWEEN(3,6)],
			["mag", ["SmokeShell", "SmokeShellRed", "SmokeShellgreen"], RANDOM_BETWEEN(5,9)]
		];
	};
	case "Ammo_Drop":
	{
	_boxitems =
		[
	// Item type, Item class(es), # of items, # of magazines per weapon
			["mag",["16Rnd_9x21_Mag", "30Rnd_9x21_Mag", "6Rnd_45ACP_Cylinder", "11Rnd_45ACP_Mag", "9Rnd_45ACP_Mag"], RANDOM_BETWEEN(15,20)],
			["mag",["30Rnd_45ACP_MAG_SMG_01", "30Rnd_45ACP_Mag_SMG_01_tracer_green"], RANDOM_BETWEEN(10,15)],
			["mag",["20Rnd_556x45_UW_mag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag_Tracer_Green"], RANDOM_BETWEEN(10,11)],
			["mag",["30Rnd_556x45_Stanag_Tracer_Yellow","30Rnd_556x45_Stanag_Tracer_Red"], RANDOM_BETWEEN(10,11)],
			["mag",["30Rnd_65x39_caseless_mag", "30Rnd_65x39_caseless_mag_Tracer"], RANDOM_BETWEEN(10,15)],
			["mag",["30Rnd_65x39_caseless_green", "30Rnd_65x39_caseless_green_mag_Tracer"], RANDOM_BETWEEN(10,15)],
			["mag",["100Rnd_65x39_caseless_mag", "100Rnd_65x39_caseless_mag_Tracer"], RANDOM_BETWEEN(7,10)],
			["mag",["200Rnd_65x39_cased_Box", "200Rnd_65x39_cased_Box_Tracer"], RANDOM_BETWEEN(7,10)],
			["mag","10Rnd_762x54_Mag", 10],
			["mag","20Rnd_762x51_Mag", 10],
			["mag",["150Rnd_762x54_Box","150Rnd_762x54_Box_Tracer"], 10],
			["mag","10Rnd_338_Mag", 10],
			["mag","130Rnd_338_Mag", 10], 
			["mag","7Rnd_408_Mag", 10],
			["mag","10Rnd_93x64_DMR_05_Mag", 10],
			["mag","150Rnd_93x64_Mag", 10], 
			["mag","10Rnd_127x54_Mag", 10], 
			["mag",["5Rnd_127x108_Mag","5Rnd_127x108_APDS_Mag"], RANDOM_BETWEEN(10,15)],
			["mag","SmokeShellyellow", RANDOM_BETWEEN(3,6)],
			["mag",["1Rnd_HE_Grenade_shell","1Rnd_Smoke_Grenade_shell","1Rnd_SmokePurple_Grenade_shell","1Rnd_SmokeBlue_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell","1Rnd_SmokeYellow_Grenade_shell","1Rnd_SmokeOrange_Grenade_shell","1Rnd_SmokeRed_Grenade_shell"], RANDOM_BETWEEN(8,10)],
			["mag",["3Rnd_HE_Grenade_shell","3Rnd_Smoke_Grenade_shell","3Rnd_SmokePurple_Grenade_shell","3Rnd_SmokeBlue_Grenade_shell", "3Rnd_SmokeGreen_Grenade_shell", "3Rnd_SmokeYellow_Grenade_shell","3Rnd_SmokeOrange_Grenade_shell","3Rnd_SmokeRed_Grenade_shell"], RANDOM_BETWEEN(8,10)],
			["mag",["UGL_FlareWhite_F", "UGL_FlareGreen_F","UGL_FlareYellow_F","UGL_FlareRed_F","UGL_FlareCIR_F", "3Rnd_UGL_FlareWhite_F", "3Rnd_UGL_FlareGreen_F","3Rnd_UGL_FlareYellow_F", "3Rnd_UGL_FlareRed_F","3Rnd_UGL_FlareCIR_F"], RANDOM_BETWEEN(10,15)]
		];	
	};
	case "special_mass":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep",[
					"launch_NLAW_F",
					["launch_RPG32_F", "launch_RPG32_ghex_F"],
					["launch_Titan_short_F", "launch_O_Titan_short_F", "launch_I_Titan_short_F", "launch_B_Titan_short_tna_F", "launch_O_Titan_short_ghex_F"],
					["launch_MRAWS_green_rail_F", "launch_MRAWS_olive_rail_F", "launch_MRAWS_sand_rail_F", "launch_MRAWS_green_F", "launch_MRAWS_olive_F", "launch_MRAWS_sand_F"],
					["launch_O_Vorona_brown_F", "launch_O_Vorona_green_F"]
					], RANDOM_BETWEEN(2,5), RANDOM_BETWEEN(1,3)],			
			["itm", ["H_CrewHelmetHeli_B"], RANDOM_BETWEEN(1,2)], //Gas Mask Blue
			["itm", ["H_CrewHelmetHeli_O"], RANDOM_BETWEEN(1,2)], //Gas Mask Red
			["itm", ["H_CrewHelmetHeli_I"], RANDOM_BETWEEN(1,2)], //Gas Mask Indi
			["itm", ["H_HelmetO_oucamo", "H_HelmetB_camo", "H_HelmetB_plain_blk", "H_Watchcap_blk", "H_Shemag_khk", "H_Booniehat_mcamo"], RANDOM_BETWEEN(2,4)], //Head Gear
			["itm", ["V_RebreatherB", "V_PlateCarrierIAGL_dgtl", "V_TacVest_camo", "V_TacVestIR_blk", "V_HarnessOSpec_gry"], RANDOM_BETWEEN(5,8)], //Vests
			["itm", ["B_Bergen_mcamo", "B_Kitbag_mcamo", "B_FieldPack_cbr", "B_Carryall_cbr"], RANDOM_BETWEEN(3,5)], //Backpack
			["itm", ["G_Diving", "G_Combat", "G_Sport_Blackred", "G_Tactical_Black", "G_Goggles_VR"], RANDOM_BETWEEN(1,3)], //Facewear
			["itm", ["NVGoggles", "Rangefinder", "ItemGPS", "Medikit", "ToolKit", "MineDetector", "Laserdesignator"], RANDOM_BETWEEN(8,12)], //Equipment
			["wep", ["arifle_SDAR_F", "arifle_MXM_Black_F", "arifle_MX_GL_F", "arifle_Katiba_F", "arifle_Mk20_plain_F", "arifle_TRG21_F", "arifle_Mk20_GL_plain_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(1,4)], //Rifles
			["wep", ["arifle_MXM_F", "srifle_DMR_01_F", "srifle_DMR_06_olive_F", "srifle_DMR_03_F", "srifle_DMR_02_F", "srifle_DMR_05_blk_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(1,4)], //Marksman Rifles
			["wep", ["srifle_LRR_SOS_F", "srifle_GM6_SOS_F", "srifle_DMR_04_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(1,4)], //Sniper Rifles
			["wep", ["MMG_02_black_F", "LMG_03_F", "LMG_Zafir_F", "LMG_Mk200_F", "arifle_MX_SW_Black_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(1,3)], //LMG
			["wep", ["hgun_Pistol_heavy_01_F", "hgun_Rook40_F", "hgun_ACPC2_F", "hgun_Pistol_heavy_02_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(2,4)], //Pistols
			["itm", ["optic_KHS_blk", "optic_LRPS", "optic_Nightstalker", "optic_Hamr", "optic_MRD"], RANDOM_BETWEEN(1,3)], //Optics
			["itm", ["bipod_01_F_blk", "muzzle_snds_H", "muzzle_snds_H_MG", "bipod_02_F_hex", "bipod_03_F_oli", "muzzle_snds_338_black", "muzzle_snds_B", "muzzle_snds_93mmg", "muzzle_snds_acp", "acc_flashlight"], RANDOM_BETWEEN(2,4)], //Accessories			
			["mag", ["HandGrenade", "APERSTripMine_Wire_Mag", "APERSBoundingMine_Range_Mag", "ClaymoreDirectionalMine_Remote_Mag", "SLAMDirectionalMine_Wire_Mag", "ATMine_Range_Mag", "DemoCharge_Remote_Mag", "SatchelCharge_Remote_Mag", "SmokeShellYellow"], RANDOM_BETWEEN(10,15)], //Throw/Place
			["mag", ["1Rnd_HE_Grenade_shell", "1Rnd_SmokeYellow_Grenade_shell", "UGL_FlareWhite_F", "MiniGrenade", "SmokeShell"], RANDOM_BETWEEN(5,8)], //GL
			["mag", ["11Rnd_45ACP_Mag", "9Rnd_45ACP_Mag", "6Rnd_45ACP_Cylinder", "30Rnd_9x21_Mag", "16Rnd_9x21_Mag", "30Rnd_45ACP_MAG_SMG_01"], RANDOM_BETWEEN(5,12)], //Pistol&SMG
			["mag", ["20Rnd_556x45_UW_mag", "30Rnd_556x45_Stanag", "30Rnd_65x39_caseless_mag", "100Rnd_65x39_caseless_mag", "200Rnd_65x39_cased_Box", "10Rnd_762x51_Mag", "20Rnd_762x51_Mag", "150Rnd_762x51_Box", "150Rnd_762x54_Box", "7Rnd_408_Mag", "5Rnd_127x108_APDS_Mag", "5Rnd_127x108_Mag"], RANDOM_BETWEEN(12,20)], //Rifle
			["mag", ["10Rnd_127x54_Mag", "10Rnd_338_Mag", "130Rnd_338_Mag", "10Rnd_93x64_DMR_05_Mag", "150Rnd_93x64_Mag"], RANDOM_BETWEEN(2,10)], //DLC
			["mag", ["1Rnd_SmokeYellow_Grenade_shell", "1Rnd_Smoke_Grenade_shell", "UGL_FlareWhite_F", "UGL_FlareRed_F", "UGL_FlareCIR_F"], RANDOM_BETWEEN(2,8)], //Grenade
			["mag", ["NLAW_F", "RPG32_F", "RPG32_HE_F", "RPG7_F", "Titan_AA", "Titan_AP", "Titan_AT", "MRAWS_HE_F", "MRAWS_HEAT_F", "Vorona_HE","Vorona_HEAT"], RANDOM_BETWEEN(2,5)] //Rockets		
		];
	};
};

[_box, _boxItems] call processItems;

if (["A3W_artilleryStrike"] call isConfigOn) then
{
	if (random 1.0 < ["A3W_artilleryCrateOdds", 1/10] call getPublicVar) then
	{
		_box setVariable ["artillery", 1, true];
	};
};
