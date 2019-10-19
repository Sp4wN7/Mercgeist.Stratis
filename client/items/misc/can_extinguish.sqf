// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Name: can_extinguish.sqf
//@file Created: 21/7/2013 16:00
//@file Description: Check if you can extinguish a fire on the nearest vehicle


#define RANGE 18
#define ERR_NO_VEHICLE "You are not close enough to a vehicle that has been destroyed"
#define ERR_IN_VEHICLE "You can't do this while in a vehicle."
#define ERR_ALIVE "The vehicle has not been destroyed"
#define ERR_NO_EXTINGUISHERS_KITS "You have no fire extinguishers"
#define ITEM_COUNT(ITEMID) ITEMID call mf_inventory_count

/* #define ERR_NO_VEHICLE "You are not close enough to a vehicle that is on fire"
#define ERR_IN_VEHICLE "Fire Extinguisher Failed! You can't do that in a vehicle"
#define ERR_ALIVE "The vehicle is not on fire"
#define ERR_TOO_FAR_AWAY "Extinguish Fire failed! You moved too far away from the vehicle"
#define ERR_CANCELLED "Extinguish Fire cancelled!" */

private ["_vehicle", "_hitPoints", "_error"];
_vehicle = objNull;
if (count _this == 0) then { // if array empty
	_vehicle = call mf_repair_nearest_vehicle;
} else {
	_vehicle = _this select 0;
};

_error = "";
switch (true) do {
	case (isNull _vehicle): {_error = ERR_NO_VEHICLE};
	case (vehicle player != player):{_error = ERR_IN_VEHICLE};
	case (player distance _vehicle > RANGE): {_error = ERR_NO_VEHICLE};
	case (alive _vehicle): {_error = ERR_ALIVE};
	//case (ITEM_COUNT(MF_ITEMS_EXTINGUISHER) <= 0): {_error = ERR_NO_EXTINGUISHERS};
};
_error;
