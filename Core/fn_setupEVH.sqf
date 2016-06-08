params["_client"];


{_client removeAllEventHandlers _x;} forEach ["Fired","HandleDamage"];
{_client removeAllMPEventHandlers _x;} forEach ["MPHit","MPRespawn","MPKilled"];
  
/* Respawn */
_client addMPEventHandler["MPRespawn",{
    params ["_client","_corpse"];

    _team = _client getVariable "INF_Client_Team";
    _client setVariable ["INF_Client_ItemDropped",false,true];
    _client setVariable ["INF_Client_Attackers",[],true];
    
    if !(missionNamespace getVariable ["INF_Round_InProgress",false]) then {
        _client call INF_fnc_initSurvivor;
        _client call INF_fnc_spawnPlayer;
    } else {
        
        if ( _team == "SURVIVOR") then {
            
        };
        
        if (_team == "ZOMBIE") then {
            _client call INF_fnc_spawnPlayer;
        };
         
        _client call INF_fnc_initZombie;
    };
        
}]; 

_client addMPEventhandler ["MPHit",{
        params ["_victim","_source"];

        _allAssists = _victim getVariable ["INF_Client_Attackers",[]];

        if !(_source in _allAssists && _victim != _source) then {
            _allAssists = _allAssists + [_source];
            _victim setVariable ["INF_Client_Attackers", _allAssists, true];                         
        };
}];

_client addEventhandler ["Fired",{
        params ["_client"];

        [_client,"ENGAGED"] spawn INF_fnc_modIcon;
}];
 
_client addEventHandler["HandleDamage",{
    params ["_client"];
    _team = _client getVariable "INF_Client_Team";

    if (_team == "SURVIVOR") then {
        _this call INF_fnc_handleSurvDamage;
    };
    if (_team == "ZOMBIE") then {
        _this call INF_fnc_zombieDmg;
    };
0
}];

_client addMPEventHandler["MPKilled",{
    params ["_victim","_killer"];  
    
    /* Manage Kills */
    if (_killer != _victim && _killer != objNull && local _killer) then {
        [_killer, "INF_Stats_Kills"] call INF_fnc_incStat;
        [_killer,"KILL"] spawn INF_fnc_modIcon;
    };


    /* Manage Assists */
    _attackers = _victim getVariable "INF_Stats_Attackers";
    if (_killer in _attackers) then {
        _attackers = _attackers - [_killer];
    };
    {
        [_x,"INF_Stats_Assists"] call INF_fnc_incStat; 
        [[_victim,_x],"INF_fnc_updateStats"] remoteExec ["BIS_fnc_Spawn",_x,false];
    } forEach _attackers;


    /* Manage Deaths */
    if (local _victim) then {
        [_victim, "INF_Stats_Deaths"] call INF_fnc_incStat;
        _victim call INF_fnc_saveStats;
    };


    /* Show On-Screen Stats */ 
    _killer spawn INF_fnc_updateStats;


    /* Strip Dead Body  */
    _victim removeAllEventHandlers "HandleDamage"; 
}];

/* Draw Icons On Players */
addMissionEventHandler ["EachFrame",{
    
    INF_Icons_DisplayList = playableUnits; //INFS_Lists_Graves;      
    {
        //_x call INF_fnc_drawIcon;      
    } forEach INF_Icons_DisplayList;
}];
