params ["_client"];

_team = _client getVariable "INF_Client_Team";

removeHeadgear _client;
removeGoggles _client;
removeVest _client;
removeBackpack _client;
removeUniform _client;
removeAllWeapons _client;
removeAllAssignedItems _client;

switch (_team) do {
        case "SURVIVOR": { 
                switch (playerSide) do {
                        case west: { _client adduniform "U_B_CTRG_Soldier_F";};
                        case east: { _client addUniform "U_O_CombatUniform_ocamo";};
                        case independent: { _client addUniform "U_BG_Guerilla1_1";};
                        case civilian: { };
                        default { };
                };              
        };
        case "ZOMBIE": {
                switch (playerSide) do {
                        case west: {_client adduniform "U_B_T_FullGhillie_tna_F";};
                        case east: { _client addUniform "U_O_GhillieSuit";};
                        case independent: { _client addUniform "U_I_GhillieSuit";};
                        case civilian: { };
                        default { };
                };       
         };
        default { };
};
