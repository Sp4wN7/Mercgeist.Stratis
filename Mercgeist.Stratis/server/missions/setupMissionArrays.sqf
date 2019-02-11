// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: setupMissionArrays.sqf
//	@file Author: AgentRev
//  @file Edit: 11/02/2019 by [iM3RC] Sp4wN7

if (!isServer) exitWith {};

MainMissions =
[
	// Mission filename, weight
	["mission_ArmedDiversquad", 0.5],
	["mission_Arty", 0.5],
	["mission_Coastal_Convoy", 0.5],
	["mission_Convoy", 1],
	["mission_HostileHeliFormation", 0.5],
	["mission_HostileJetFormation", 0.5],
	["mission_APC", 1],
	["mission_MBT", 1],
	["mission_LightArmVeh", 1],
	["mission_ArmedHeli", 1],
	["mission_AbandonedJet", 0.5],
	["mission_VehicleCapture", 1],
	["mission_tankRush", 0.5],
	["mission_CivHeli", 1]
];

SideMissions =
[
	["mission_HostileHelicopter", 0.5],
	["mission_HostileJet", 0.5],
	["mission_AirWreck", 1],
	["mission_MiniConvoy", 1],
	["mission_drugsRunners", 1],
	["mission_HostageRescue", 1],
	["mission_WepCache", 1],
	["mission_SunkenSupplies", 0.5],
	["mission_TownInvasion", 1],
	["mission_Outpost", 1],
	["mission_geoCache", 1],
	["mission_Sniper", 1],
	["mission_Smugglers", 0.5],
	["mission_Roadblock", 1],
	["mission_ConvoyCSATSF", 1],
	["mission_Truck", 1]
];

MoneyMissions =
[
	//["mission_Hackers", 0.2],
	["mission_MoneyShipment", 1],
	["mission_altisPatrol", 1],
	["mission_SunkenTreasure", 0.5]
];

MissionSpawnMarkers = (allMapMarkers select {["Mission_", _x] call fn_startsWith}) apply {[_x, false]};
ForestMissionMarkers = (allMapMarkers select {["ForestMission_", _x] call fn_startsWith}) apply {[_x, false]};
SunkenMissionMarkers = (allMapMarkers select {["SunkenMission_", _x] call fn_startsWith}) apply {[_x, false]};
RoadblockMissionMarkers = (allMapMarkers select {["RoadBlock_", _x] call fn_startsWith}) apply {[_x, false]};

if !(ForestMissionMarkers isEqualTo []) then
{
	SideMissions append
	[
		["mission_AirWreck", 3],
		["mission_WepCache", 3]
	];
};

LandConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\landConvoysList.sqf") apply {[_x, false]};
CoastalConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\coastalConvoysList.sqf") apply {[_x, false]};
RushConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\rushConvoysList.sqf") apply {[_x, false]};

MainMissions = [MainMissions, [["A3W_heliPatrolMissions", ["mission_Coastal_Convoy", "mission_HostileHeliFormation"]], ["A3W_underWaterMissions", ["mission_ArmedDiversquad"]]]] call removeDisabledMissions;
SideMissions = [SideMissions, [["A3W_heliPatrolMissions", ["mission_HostileHelicopter"]], ["A3W_underWaterMissions", ["mission_SunkenSupplies"]]]] call removeDisabledMissions;
MoneyMissions = [MoneyMissions, [["A3W_underWaterMissions", ["mission_SunkenTreasure"]]]] call removeDisabledMissions;

{ _x set [2, false] } forEach MainMissions;
{ _x set [2, false] } forEach SideMissions;
{ _x set [2, false] } forEach MoneyMissions;
