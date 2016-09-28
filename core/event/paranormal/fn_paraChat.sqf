/*
	HVP Ghost Chat Paranormal Event
	Author: Sinbane
	Creates fake chat messages from players in global chat
*/
private ["_statement","_response","_players","_playerFound","_player1","_player2"];
//-----------------------------------
//-STATEMENTS

_statement = [
"OMG you suck!",
"I just wet myself",
"I FOUND A PENNY!",
"Anyone even playing?",
"I will now sing you a song about love, happiness and infinite cocaine",
"What a thought was a fart, just turned into one big accident. I am not happy",
"Come out come out whereever you areee",
"You just can't get the loot these days.."
];

//-----------------------------------
//-RESPONSES

_response = [
"lol",
"Shut up",
"Don't speak to me until you're better than me",
"Oh i love u",
"Cheers Obama",
"Don't make me come over there",
"I'M NOT GUNNA TAKE IT. NO! I AIN'T GUNNA TAKE IT!",
"QUIT YO JIBBA JABBA!"
];

//-----------------------------------

HVP_ghostChat = {
	private ["_player1","_statement","_player2","_reponse"];
	_player1 = _this select 0;
	_statement = _this select 1;
	_player2 = _this select 2;
	_response = _this select 3;
	
	_player1 globalChat _statement;
	sleep 12;
	_player2 globalChat _response;
};	

//-----------------------------------
//-GET PLAYER LIST

_players = [];

{
	if (isPlayer _x && side _x != sideLogic) then {
		_players pushBack _x;
	};
} forEach allUnits;

//-----------------------------------
//-MAIN

_playerFound = false;
while {!_playerFound} do {
	_player1 = selectRandom _players;
	if (side _player1 isEqualTo WEST && HVPGameType isEqualTo 1) then {
		_playerFound = true;
	};
	if (HVPGameType isEqualTo 2 || HVPGameType isEqualTo 3) then {
		_playerFound = true;
	};
};

_playerFound = false;
while {!_playerFound} do {
	_player2 = selectRandom _players;
	if (side _player2 isEqualTo EAST && HVPGameType isEqualTo 1) then {
		_playerFound = true;
	};
	if (HVPGameType isEqualTo 2 && _player2 != _player1 || HVPGameType isEqualTo 3 && _player2 != _player1) then {
		_playerFound = true;
	};
};
	
//-----------------------------------

if ((random 100) < 50) then {
	[_player1,(selectRandom _statement),_player2,(selectRandom _response)] remoteExec ["HVP_ghostChat", 0];
} else {
	[_player2,(selectRandom _statement),_player1,(selectRandom _response)] remoteExec ["HVP_ghostChat", 0];
};

//-----------------------------------