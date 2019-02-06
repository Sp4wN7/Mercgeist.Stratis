_host = _this select 0;
_caller = _this select 1;
_id = _this select 2;
_params = _this select 3;
_typehalo = _params select 0;//true for all group, false for player only.
_althalo = _params select 1;//altitude of halo jump
_altchute = _params select 2;//altitude for autochute deployment

if (not alive _host) exitwith {
hint "Halo Not Available"; 
_host removeaction _id;
};

#define PRICE 1500

_message = format ["The cost is $%1 to HALO. Confirm?", PRICE call fn_numbersText];

if !([_message, "Confirm", true, true] call BIS_fnc_guiMessage) exitWith {};

_showInsufficientFundsError =
{
	hint "Not enough money";
	playSound 'FD_Finish_F';
};

_money = player getVariable ["cmoney", 0];

// Ensure the player has enough money
if (PRICE > _money) exitWith
{
  call _showInsufficientFundsError;
};

//Deduct
player setVariable ["cmoney", _money - PRICE, true];

if (vehicle _caller == _caller) then {

	private ["_pos"];
	
	_caller groupchat "Click on the map where you want to jump";

	openMap true;

	mapclick = false;

	onMapSingleClick "clickpos = _pos; mapclick = true; onMapSingleClick """";true;";

	waituntil {mapclick or !(visiblemap)};
	
	if (!visibleMap) exitwith {
		_caller groupchat "Not gonna jump today?!";
	};
	_pos = clickpos;

openMap false;	
	
	if (_typehalo) then {
	
		_grp1 = group _caller;
		{
			_x setpos [_pos select 0, _pos select 1, _althalo];
			_x spawn fn_emergencyEject;
		} foreach units _grp1;

	} else {
	
		_caller setpos [_pos select 0, _pos select 1, _althalo];
		_caller spawn fn_emergencyEject;

	};

} else {
//Unit(s) in aircraft
	
	if (_typehalo) then {
	
		_grp1 = group _caller;
		
		{
			_x allowdamage false;
			unassignVehicle (_x);
			(_x) action ["EJECT", vehicle _x];
			_x spawn fn_emergencyEject;
			sleep 0.5;
			_x allowdamage true;
		} foreach units _grp1;

	} else {

		_caller allowdamage false;
		unassignVehicle (_caller);
		(_caller) action ["EJECT", vehicle _caller];
		_caller spawn fn_emergencyEject;
		sleep 0.5;
		_caller allowdamage true;

	};
};