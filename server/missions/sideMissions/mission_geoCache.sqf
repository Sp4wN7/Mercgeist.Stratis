// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_geoCache.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev, edit by CRE4MPIE & LouD;
//	@file Created: 08/12/2012 15:19
//	@file Edit: 27/04/2018 by [509th] Coyote Rogue

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_geoPos", "_geoCache", "_cash", "_marker1", "_minesToDelete", "_boxes1", "_box1", "_para", "_smoke"];

_setupVars =
{
	_missionType = "GeoCache";
	_locationsArray = [ForestMissionMarkers, MissionSpawnMarkers] select (ForestMissionMarkers isEqualTo []);	
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	
	//delete existing base parts and vehicles at location
	_baseToDelete = nearestObjects [_missionPos, ["All"], 100];
	{ deleteVehicle _x } forEach _baseToDelete;	
	
	_geoPos = _missionPos vectorAdd ([[25 + random 20, 0, 0], random 360] call BIS_fnc_rotateVector2D);
	_geoCache = createVehicle ["Land_SatellitePhone_F",[(_geoPos select 0), (_geoPos select 1),0],[], 0, "NONE"];
	
	// Create minefield	
		for "_i" from 1 to 300 do
		{
			_mine = createMine ["APERSMine", _geoPos, [], 50];		
		};

		for "_i" from 1 to 100 do
		{
			_mineAT = createMine ["ATMine", _geoPos, [], 50];		
		};

		_marker1 = createMarker ["Minefield", _missionPos];
		_marker1 setMarkerShape "ELLIPSE";
		_marker1 setMarkerSize [100,100];	
		_marker1 setMarkerBrush "FDiagonal";
		_marker1 setMarkerColor "colorOPFOR";
	
	_missionHintText = format ["There is a satellite phone hidden near the marker. Find it and a reward will be delivered by air!<br/><br/><t color='%1'>BEWARE OF THE MINEFIELD!</t>", "#fcc362"];
};

_ignoreAiDeaths = true;
_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;
_waitUntilSuccessCondition = {{isPlayer _x && _x distance _geoPos < 5} count playableUnits > 0};

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_GeoCache];
	// Delete minefield
	_minesToDelete = (_geoPos nearObjects ["MineBase", 100]);	
	{ deleteVehicle _x } forEach _minesToDelete;
	deleteMarker "Minefield"; 	
};

// Mission completed

_successExec =
{
	{ deleteVehicle _x } forEach [_GeoCache];

	// Delete minefield
	_minesToDelete = (_geoPos nearObjects ["MineBase", 100]);	
	{ deleteVehicle _x } forEach _minesToDelete;
	deleteMarker "Minefield"; 		
	
	_boxes1 = selectRandom ["I_supplyCrate_F", "B_CargoNet_01_ammo_F", "c_IDAP_supplyCrate_F", "c_supplyCrate_F"];
	_box1 = createVehicle [_boxes1,[(_missionPos select 0), (_missionPos select 1),200],[], 0, "NONE"];
	_box1 setDir random 360;
	[_box1, "special_mass"] call fn_refillbox; //Special large box	
	_box1 allowDamage false;
	
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1];
	
	playSound3D [call currMissionDir + "media\airdrop.ogg", _box1, false, _box1, 1, 1, 1500];

	_para = createVehicle [format ["I_parachute_02_F"], [0,0,999999], [], 0, "NONE"];

	_para setDir getDir _box1;
	_para setPosATL getPosATL _box1;

	_para attachTo [_box1, [0, 0, 0]];
	uiSleep 2;

	detach _para;
	_box1 attachTo [_para, [0, 0, 0]];

	while {(getPos _box1) select 2 > 3 && attachedTo _box1 == _para} do
	{
		_para setVectorUp [0,0,1];
		_para setVelocity [0, 0, (velocity _para) select 2];
		uiSleep 0.1;
	};

	detach _box1;
	
	_smoke = "SmokeShellGreen" createVehicle getPos _para;

	//Money
		
	for "_x" from 1 to 5 do
	{
		_cash = "Land_Money_F" createVehicle markerPos _marker;
		_cash setPos ((markerPos _marker) vectorAdd ([[2 + random 2,4,6], random 360] call BIS_fnc_rotateVector2D));
		_cash setDir random 360;
		_cash setVariable["cmoney",10000,true];
		_cash setVariable["owner","world",true];
	};
	
	_successHintMessage = "You survived the minefield! The GeoCache supplies and cash have been delivered by parachute!";
};

_this call sideMissionProcessor;
