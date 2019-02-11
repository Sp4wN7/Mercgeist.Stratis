// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: rushConvoy_3.sqf (near Vikos)
//	@file Author: [GoT] JoSchaap, [404] Del1te, AgentRev, LouD
//	@file Created: 13/02/2014 22:52

// starting positions for this route
_starts =
[
	[2546.7417, 1184.3505],
	[2532.4895, 1177.6466],
	[2515.7581, 1174.0854],
	[2501.9333, 1172.5739],
	[2488.0505, 1168.1071],
	[2476.6843, 1163.9016],
	[2465.7485, 1158.4225],
	[2453.9238, 1154.4995],
	[2442.5823, 1149.2985],
	[2430.3403, 1145.3647]
];

// starting directions in which the vehicles are spawned on this route
_startDirs =
[
	6,
	6,
	6,
	6,
	6,
	6,
	6,
	6,
	6,
	6
];

// the route
_waypoints =
[
	[3071.0684, 2148.3408],	//Start
	[3755.1472, 3050.8818],
	[4277.918, 3702.5718],
	[5333.7949, 4961.2275],
	[5236.6069, 5812.5894],
	[3239.2629, 5869.0908],
	[2156.771, 5808.9351],
	[2060.364, 5353.7998],
	[1729.1283, 5407.4854],
	[1795.7456, 5723.1182],
	[2834.8635, 5926.6646],
	[4453.0508, 4265.8892],
	[5333.7949, 4961.2275],	//Loop
	[5236.6069, 5812.5894],
	[3239.2629, 5869.0908],
	[2156.771, 5808.9351],
	[2060.364, 5353.7998],
	[1729.1283, 5407.4854],
	[1795.7456, 5723.1182],
	[2834.8635, 5926.6646],
	[4453.0508, 4265.8892],
	[5333.7949, 4961.2275],	//Loop
	[5236.6069, 5812.5894],
	[3239.2629, 5869.0908],
	[2156.771, 5808.9351],
	[2060.364, 5353.7998],
	[1729.1283, 5407.4854],
	[1795.7456, 5723.1182],
	[2834.8635, 5926.6646],
	[4453.0508, 4265.8892],
	[5333.7949, 4961.2275],	//Loop
	[5236.6069, 5812.5894],
	[3239.2629, 5869.0908],
	[2156.771, 5808.9351],
	[2060.364, 5353.7998],
	[1729.1283, 5407.4854],
	[1795.7456, 5723.1182],
	[2834.8635, 5926.6646],
	[4453.0508, 4265.8892],
	[5333.7949, 4961.2275],	//Loop
	[5236.6069, 5812.5894],
	[3239.2629, 5869.0908],
	[2156.771, 5808.9351],
	[2060.364, 5353.7998],
	[1729.1283, 5407.4854],
	[1795.7456, 5723.1182],
	[2834.8635, 5926.6646],
	[4453.0508, 4265.8892],
	[5333.7949, 4961.2275],	//Loop
	[5236.6069, 5812.5894],
	[3239.2629, 5869.0908],
	[2156.771, 5808.9351],
	[2060.364, 5353.7998],
	[1729.1283, 5407.4854],
	[1795.7456, 5723.1182],
	[2834.8635, 5926.6646],
	[4453.0508, 4265.8892],
	[5333.7949, 4961.2275],	//Loop
	[5236.6069, 5812.5894],
	[3239.2629, 5869.0908],
	[2156.771, 5808.9351],
	[2060.364, 5353.7998],
	[1729.1283, 5407.4854],
	[1795.7456, 5723.1182],
	[2834.8635, 5926.6646],
	[4453.0508, 4265.8892],
	[5333.7949, 4961.2275],	//Loop
	[5236.6069, 5812.5894],
	[3239.2629, 5869.0908],
	[2156.771, 5808.9351],
	[2060.364, 5353.7998],
	[1729.1283, 5407.4854],
	[1795.7456, 5723.1182],
	[2834.8635, 5926.6646],
	[4453.0508, 4265.8892],
	[5333.7949, 4961.2275],	//Loop
	[5236.6069, 5812.5894],
	[3239.2629, 5869.0908],
	[2156.771, 5808.9351],
	[2060.364, 5353.7998],
	[1729.1283, 5407.4854],
	[1795.7456, 5723.1182],
	[2834.8635, 5926.6646],
	[4453.0508, 4265.8892],
	[5333.7949, 4961.2275],	//Loop
	[5236.6069, 5812.5894],
	[3239.2629, 5869.0908],
	[2156.771, 5808.9351],
	[2060.364, 5353.7998],
	[1729.1283, 5407.4854],
	[1795.7456, 5723.1182],
	[2834.8635, 5926.6646],
	[4453.0508, 4265.8892],
	[5333.7949, 4961.2275],	//Loop
	[5236.6069, 5812.5894],
	[3239.2629, 5869.0908],
	[2156.771, 5808.9351],
	[2060.364, 5353.7998],
	[1729.1283, 5407.4854],
	[1795.7456, 5723.1182],
	[2834.8635, 5926.6646],
	[4453.0508, 4265.8892],
	[5333.7949, 4961.2275],	//Loop
	[5236.6069, 5812.5894],
	[3239.2629, 5869.0908],
	[2156.771, 5808.9351],
	[2060.364, 5353.7998],
	[1729.1283, 5407.4854],
	[1795.7456, 5723.1182],
	[2834.8635, 5926.6646],
	[4453.0508, 4265.8892],
	[5333.7949, 4961.2275],	//Loop
	[5236.6069, 5812.5894],
	[3239.2629, 5869.0908],
	[2156.771, 5808.9351],
	[2060.364, 5353.7998],
	[1729.1283, 5407.4854],
	[1795.7456, 5723.1182],
	[2834.8635, 5926.6646],
	[4453.0508, 4265.8892],
	[5333.7949, 4961.2275],	//Loop
	[5236.6069, 5812.5894],
	[3239.2629, 5869.0908],
	[2156.771, 5808.9351],
	[2060.364, 5353.7998],
	[1729.1283, 5407.4854],
	[1795.7456, 5723.1182],
	[2834.8635, 5926.6646],
	[4453.0508, 4265.8892],
	[5333.7949, 4961.2275],	//Loop
	[5236.6069, 5812.5894],
	[3239.2629, 5869.0908],
	[2156.771, 5808.9351],
	[2060.364, 5353.7998],
	[1729.1283, 5407.4854],
	[1795.7456, 5723.1182],
	[2834.8635, 5926.6646],
	[4453.0508, 4265.8892]	//End
];