// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Name: extinguish.sqf
//@file Created: 23/7/2013 16:00
//@file Description: Extinguish the fire on a vehicle

#define DURATION 8
#define RANGE 18
#define ANIMATION "AinvPknlMstpSlayWrflDnon_medic"
#define ERR_NO_VEHICLE "You are not close enough to a vehicle that is on fire"
#define ERR_IN_VEHICLE "Fire Extinguisher Failed! You can't do that in a vehicle"
#define ERR_ALIVE "The vehicle is not on fire"
#define ERR_TOO_FAR_AWAY "Extinguish Fire failed! You moved too far away from the vehicle"
#define ERR_CANCELLED "Extinguish Fire canceled!"

private ["_vehicle", "_checks", "_success"];
_vehicle = call mf_repair_nearest_vehicle;

_checks = {
	private ["_progress","_failed", "_text"];
	_progress = _this select 0;
	_vehicle = _this select 1;
	_text = "";
	_failed = true;
	switch (true) do {
		case (!alive player): {}; // player is dead, no need for a notification
		case (vehicle player != player): {_text = ERR_IN_VEHICLE};
		case (player distance _vehicle > RANGE): {_text = ERR_TOO_FAR_AWAY};
		case (alive _vehicle): {_text = ERR_ALIVE};
		case (doCancelAction): {_text = ERR_CANCELLED; doCancelAction = false;};
		default {
			_text = format["Extinguishing %1%2 Complete", round(100 * _progress), "%"];
			_failed = false;
		};
	};
	[_failed, _text];
};

playSound3D [call currMissionDir + "media\extinguisher.ogg", player, false, getPosASL player, 1, 1, 500];

_success = [DURATION, ANIMATION, _checks, [_vehicle]] call a3w_actions_start;

if (_success) then {
	[netId _vehicle] remoteExec ["mf_remote_extinguish", _vehicle];
	["Fire has been extinguished", 5] call mf_notify_client;
};
_success;
