/* 
 * This file contains parameters to config and function call to start an instance of
 * traffic in the mission. The file is edited by the mission developer.
 *
 * See file addons\Engima\Traffic\Documentation.txt for documentation and a full reference of 
 * how to customize and use Engima's Traffic.
 */
 
 private ["_parameters"];

// Set traffic parameters.
_parameters = [
	["SIDE", civilian],
	["VEHICLES", 
		[
		"C_Offroad_01_F",
		"C_Quadbike_01_F", 
		"C_Hatchback_01_F", 
		"C_Hatchback_01_sport_F", 
		"C_SUV_01_F", 
		"C_Van_01_transport_F", 
		"C_Van_01_box_F", 
		"C_Van_01_fuel_F",
		"C_Offroad_02_unarmed_F",
		"C_Van_02_vehicle_F",
		"C_Van_02_medevac_F",
		"B_T_LSV_01_unarmed_F",
		"O_T_LSV_02_unarmed_F",
		"B_G_Offroad_01_F"		
		]
	],
	["VEHICLES_COUNT", 2],
	["MIN_SPAWN_DISTANCE", 800],
	["MAX_SPAWN_DISTANCE", 1200],
	["MIN_SKILL", 0.8],
	["MAX_SKILL", 0.9],
	["DEBUG", false]
];

// Start an instance of the traffic
_parameters spawn ENGIMA_TRAFFIC_StartTraffic;
