params ["_client"];

if (player getVariable "INF_Client_Ready") then {
    _infected = name _client;

    terminate INF_Settings_CurrentMessage;
    _handle = [
        [
            [_infected +" is the Alpha Zombie","<t align = 'center' shadow = '1' size = '1'>%1</t>",15]
        ], 0, safeZoneY + (.1 * (safeZoneY + safeZoneH))
    ] spawn BIS_fnc_typeText;
    INF_Settings_CurrentMessage = _handle;
};