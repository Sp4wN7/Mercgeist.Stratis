// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: storeOwners.sqf
//	@file Author: AgentRev, JoSchaap, His_Shadow

// Notes: Gun and general stores have position of spawned crate, vehicle stores have an extra air spawn direction
//
// Array contents are as follows:
// Name, Building Position, Desk Direction (or [Desk Direction, Front Offset]), Excluded Buttons
storeOwnerConfig = compileFinal str
[
	["GenStore1", 1, 270, []],
	["GenStore2", 4, 310, []],
	["GenStore3", 5, 80, []],
	["GenStore4", 5, 80, []],
	["GenStore5", -1, 245, []],

	["GunStore1", 1, 175, []],
	["GunStore2", 1, 130, []],
	["GunStore3", 5, 70, []],
	["GunStore4", 1, 118, []],
	["ArmsDealer1", 1, 60, []],
	["ArmsDealer2", 2, 280, []],

	// Buttons you can disable: "Land", "Armored", "Tanks", "Helicopters", "Boats", "Planes"
	["VehStore1", 0, 195, ["Planes"]],
	["VehStore2", 2, 285, ["Boats"]],
	["VehStore3", 1, 245, ["Planes"]],
	["VehStore4", 5, 240, ["Boats", "Planes"]],
	["VehStore5", -1, [], ["Land", "Armored", "Tanks"]]
];

// Outfits for store owners
storeOwnerConfigAppearance = compileFinal str
[
	["GenStore1", [["weapon", ""], ["uniform", "U_IG_Guerilla2_2"]]],
	["GenStore2", [["weapon", ""], ["uniform", "U_IG_Guerilla2_3"]]],
	["GenStore3", [["weapon", ""], ["uniform", "U_IG_Guerilla3_1"]]],

	["GunStore1", [["weapon", ""], ["uniform", "U_B_SpecopsUniform_sgg"]]],
	["GunStore2", [["weapon", ""], ["uniform", "U_O_SpecopsUniform_blk"]]],
	["GunStore3", [["weapon", ""], ["uniform", "U_I_CombatUniform_tshirt"]]],
	["GunStore4", [["weapon", ""], ["uniform", "U_IG_Guerilla1_1"]]],
	["ArmsDealer1", [["weapon", ""], ["uniform", "U_BG_leader"]]],
	["ArmsDealer2", [["weapon", ""], ["uniform", "U_BG_leader"]]],

	["VehStore1", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore2", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore3", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore4", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore5", [["weapon", ""], ["uniform", "U_I_pilotCoveralls"]]]
];
