sleep 10;
[] spawn {
		waitUntil{player == player};
		_worldName = switch(toLower worldName)do{
                case "altis"             :{"Altis"};
                case "bornholm"             :{"Bornholm"};
                case "chernarus"             :{"Chernarus"};
                default{worldName};
        };
        [[format["Welcome to MERCGEIST", _worldName],"", format["We shall see you in Valhalla, %1", name player],"","","","",""," ","","","",""], -.5, .85] call BIS_fnc_typeText;
        //sleep 2;
        [["On the web at","mercgeist.com","","and","mercgeist.teamspeak3.com","",""], .5, .85] call BIS_fnc_typeText;
};
