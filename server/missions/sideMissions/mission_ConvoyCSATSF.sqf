// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_ConvoyCSATSF.sqf
//	@file Author: JoSchaap, AgentRev, LouD
//	@file Edit: 27/04/2018 by [509th] Coyote Rogue

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf";

private ["_convoyVeh","_veh1","_createVehicle","_pos","_rad","_vehiclePosArray","_vehicles","_leader","_speedMode","_waypoint","_vehicleName","_numWaypoints","_box1"];

_setupVars =
{
	_missionType = "Rogue SFT";
	_locationsArray = nil;
};

_setupObjects =
{
//	_town = (call cityList) call BIS_fnc_selectRandom;
//	_missionPos = markerPos (_town select 0);

	_veh1 =	selectRandom ["O_T_LSV_02_armed_F", "O_T_LSV_02_AT_F", "B_T_LSV_01_armed_F", "B_T_LSV_01_AT_F"]; // Quilin Minigun, Qilin AT, Prowler HMG, Prowler AT
	
	_createVehicle = {
		private ["_type","_position","_direction","_vehicle","_soldier"];
		
		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_vehicle = [_type, _position, .25, 2, 0] call createMissionVehicle;//[Class, Position, Fuel, Ammo, Damage, Special]		
		[_vehicle] call vehicleSetup;

		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;

		_soldier = [_aiGroup, _position] call createCSATSFDriver;
		_soldier moveInDriver _vehicle;
		_soldier triggerDynamicSimulation true;
		_soldier = [_aiGroup, _position] call createCSATSFGunner;
		_soldier moveInGunner _vehicle;
		_soldier = [_aiGroup, _position] call createCSATSFCommander;
		_soldier moveInCommander _vehicle;
		_soldier = [_aiGroup, _position] call createCSATSFAA;
		_soldier moveInCargo _vehicle;
		_soldier = [_aiGroup, _position] call createCSATSFMedic;
		_soldier moveInCargo _vehicle;		

		_vehicle setVariable ["R3F_LOG_disabled", true, true]; // force vehicles to be locked
		[_vehicle, _aiGroup] spawn checkMissionVehicleLock; // force vehicles to be locked

		_vehicle
	};
//**************************************************************
    // TOWN SKIP AND PLAYER PROXIMITY CHECK

    _skippedTowns = // get the list from -> \mapConfig\towns.sqf
    [
        "Town_12", // Camp Maxwell Marker Name
        "Town_14", // Pythos Island Marker Name		
        "Town_15", // Baldy Barracks Marker Name		
        "Town_16", // ol-Keiros Marker Name		
        "Town_17" // Tsoukalia Marker Name
    ];

    _town = ""; _missionPos = [0,0,0]; _radius = 0;
    _townOK = false;
    while {!_townOK} do
    {
        _town = selectRandom (call cityList); // initially select a random town for the mission.
        _missionPos = markerPos (_town select 0); // the town position.
        _radius = (_town select 1); // the town radius.
        _anyPlayersAround = (nearestObjects [_missionPos,["MAN"],_radius]) select {isPlayer _x}; // search the area for players only.
        if (((count _anyPlayersAround) isEqualTo 0) && !((_town select 0) in _skippedTowns)) exitWith // if there are no players around and the town marker is not in the skip list, set _townOK to true (exit loop).
        {
            _townOK = true;
        };
        sleep 0.1; // sleep between loops.
    };
//*************************************************************
	_aiGroup = createGroup CIVILIAN;
	
	_rad = _town select 1;
	_vehiclePosArray = [_missionPos,_rad,_rad + 50,5,0,0,0] call findSafePos;	
	
	_vehicles =
	[
		[_veh1, _vehiclePosArray, 0] call _createVehicle
	];

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";	
	_aiGroup setCombatMode "RED"; // GREEN = Hold fire, Defend only; YELLOW = Fire at will;  RED = Fire at will, engage at will
	_aiGroup setBehaviour "COMBAT"; // SAFE = Defend only; AWARE = (default) Take action when enemy is noted; COMBAT = Always alert
	_aiGroup setFormation "COLUMN"; //COLUMN - Line up single file behind unit 1; STAG COLUMN - Two columns offset, left column leads; FILE - Same as COLUMN, except tighter.

	_speedMode = if (missionDifficultyHard) then { "FULL" } else { "NORMAL" }; //"LIMITED" (half speed); "NORMAL" (full speed, maintain formation); "FULL" (do not wait for any other units in formation)
	_aiGroup setSpeedMode _speedMode;

	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "RED"; // GREEN = Hold fire, Defend only; YELLOW = Fire at will;  RED = Fire at will, engage at will
		_waypoint setWaypointBehaviour "COMBAT"; // SAFE = Defend only; AWARE = (default) Take action when enemy is noted; COMBAT = Always alert
		_waypoint setWaypointFormation "COLUMN"; //COLUMN - Line up single file behind unit 1; STAG COLUMN - Two columns offset, left column leads; FILE - Same as COLUMN, except tighter.
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh1 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh1 >> "displayName");
	
	_missionHintText = format ["There is a rogue Special Forces Team driving a <t color='%2'>%1</t> transporting a weapon crate and equipped with a special purpose helmet. Stop them!", _vehicleName, sideMissionColor];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome
_drop_item = 
{
	private["_item", "_pos"];
	_item = _this select 0;
	_pos = _this select 1;

	if (isNil "_item" || {typeName _item != typeName [] || {count(_item) != 2}}) exitWith {};
	if (isNil "_pos" || {typeName _pos != typeName [] || {count(_pos) != 3}}) exitWith {};

	private["_id", "_class"];
	_id = _item select 0;
	_class = _item select 1;

	private["_obj"];
	_obj = createVehicle [_class, _pos, [], 5, "None"];
	_obj setPos ([_pos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
	_obj setVariable ["mf_item_id", _id, true];
};

// Mission completed

	_successExec =
	{

		//Crates
					
		_boxes1 = selectRandom ["Box_NATO_Wps_F","Box_East_Wps_F","Box_IND_Wps_F", "Box_IND_Ammo_F","Box_IND_AmmoOrd_F","Box_IND_Grenades_F","Box_IND_Support_F","Box_IND_WpsLaunch_F","Box_IND_WpsSpecial_F"];
		_box1 = createVehicle [_boxes1, _lastPos, [], 5, "NONE"];
		_box1 setDir random 360;
		_box1 call randomCrateLoadOut; // Randomly fills box with equipment
		_box1 allowDamage false;
		
		//Crate Behavior	
		
		{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1];	//Allows crates to be picked up and carried	

		//Message
		
		_successHintMessage = "The Special Forces have been killed! The weapon crates and vehicles are now yours to take.";

	};

_this call sideMissionProcessor;