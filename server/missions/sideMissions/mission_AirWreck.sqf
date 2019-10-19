// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_AirWreck.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev
//	@file Created: 08/12/2012 15:19
//	@file Edit: 27/04/2018 by [509th] Coyote Rogue

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_wreckPos", "_wreck", "_boxes1", "_boxes2", "_box1", "_box2", "_fire", "_drop_item", "_drugpilerandomizer", "_drugpile"];

_setupVars =
{
	_missionType = "Aircraft Wreck";
	_locationsArray = [ForestMissionMarkers, MissionSpawnMarkers] select (ForestMissionMarkers isEqualTo []);
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;

	//delete existing base parts and vehicles at location
	_baseToDelete = nearestObjects [_missionPos, ["All"], 25];
	{ deleteVehicle _x } forEach _baseToDelete;
	
	_wreckPos = _missionPos vectorAdd ([[25 + random 20, 0, 0], random 360] call BIS_fnc_rotateVector2D);

	// Create wreck 
	_aircraft = selectRandom ["B_Heli_Light_01_F", "O_Heli_Light_02_unarmed_F", "B_CTRG_Heli_Transport_01_sand_F", "C_Heli_Light_01_civil_F", "C_Plane_Civil_01_F"];
	_wreck = [_aircraft, _wreckPos, .25, 0, .9] call createMissionVehicle;//[Class, Position, Fuel, Ammo, Damage, Special]
	_wreck allowDamage false;//Allows wreck to stick around longer
	_fire = "test_EmptyObjectForFireBig" createVehicle (getPos _wreck); //Creates fire at wreck 
	_fire attachTo [_wreck,[0,1,0]];

	//Create reward boxes at wreck site
	_boxes1 = selectRandom ["Box_NATO_Wps_F","Box_East_Wps_F","Box_IND_Wps_F", "Box_IND_Ammo_F","Box_IND_AmmoOrd_F","Box_IND_Grenades_F","Box_IND_Support_F","Box_IND_WpsLaunch_F","Box_IND_WpsSpecial_F"];
	_box1 = createVehicle [_boxes1, _wreckPos, [], 5, "NONE"];
	_box1 setDir random 360;
	_box1 call randomCrateLoadOut; // Randomly fills box with equipment
	_box1 allowDamage false;

	_boxes2 = selectRandom ["Box_NATO_Wps_F","Box_East_Wps_F","Box_IND_Wps_F", "Box_IND_Ammo_F","Box_IND_AmmoOrd_F","Box_IND_Grenades_F","Box_IND_Support_F","Box_IND_WpsLaunch_F","Box_IND_WpsSpecial_F"];
	_box2 = createVehicle [_boxes2, _wreckPos, [], 5, "NONE"];
	_box2 setDir random 360;
	_box2 call randomCrateLoadOut; // Randomly fills box with equipment
	_box2 allowDamage false;

	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_box1, _box2];

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, _nbUnits] call createCustomGroup4;

	_missionPicture = getText (configFile >> "CfgVehicles" >> typeOf _wreck >> "picture");
	_missionHintText = "A narco aircraft has come down carrying arms and drugs! Cartel are attempting to recover it! Go get it!";
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2, _fire, _wreck];
};

// Mission completed

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

	_successExec =
	{
		//Wreck Destroyed (comment out and uncomment out lines below to keep wreck as a reward)
		_wreck setDamage 1;
		deleteVehicle _fire;				

/*		//Wreck as reward (comment out both lines above)		
		deleteVehicle _fire;
		_wreck allowDamage true;
		[_wreck, 1] call A3W_fnc_setLockState; // Unlock	
*/		

		//Crates	
		
		{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2, _wreck];	//Allows crates to be picked up and carried

		
		//Drugs
		
		_drugpilerandomizer = [6,8,10];
		_drugpile = _drugpilerandomizer call BIS_fnc_SelectRandom;
	
		for "_i" from 1 to _drugpile do 
		{
			private["_item"];
			_item = [
					["lsd", "Land_WaterPurificationTablets_F"],
					["marijuana", "Land_VitaminBottle_F"],
					["cocaine","Land_PowderedMilk_F"],
					["heroin", "Land_PainKillers_F"]
				] call BIS_fnc_selectRandom;
			[_item, _lastPos] call _drop_item;
		};
		
		//Message
		
		_successHintMessage = "Great job! Check the area for weapons and narcotics.";

	};

_this call sideMissionProcessor;