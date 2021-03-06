params ["_client"];

_ally = false;
if (_client in playableUnits && _client getVariable "INF_Client_Team" == player getVariable "INF_Client_Team") then {
     _ally = true;   
};


if ( _client != player) then { //(_ally || _client in INFS_Lists_Graves) &&
        
        _texture = _client getVariable ["INF_Icons_Texture",""];
        _color = _client getVariable ["INF_Icons_Color",[0,1,1,1]];
        _alpha = linearConversion[5, 10, player distance _client, 1, 0, true];
        _text = _client getVariable["INF_Icons_Text",""];
        _sizeEx = linearConversion[5,10, player distance _client, .03, .015, true];
        _pos = (visiblePosition _client);
        _pos set [2,(_pos select 2) + 2];
        
        drawIcon3D [
                _texture, //Texture
                [_color select 0, _color select 1, _color select 2, _alpha], //Color
                _pos, //DrawPosition
                0.5, //Texture width
                0.5, //Texture Height
                0, //Texture Angle
                _text, //Icon Text
                2, // Nothing = 0, Shadow = 1, Outline = 2
                _sizeEx, // text size
                "PuristaBold", // Text Font
                "CENTER", // Text Align
                false // Draw screen edge arrows
        ];
};