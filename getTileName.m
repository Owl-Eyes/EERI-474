%#######################################################################
%#                                                                     #
%#                 EERI 474 - Tile Name & Path Function                #
%#                       by J. Koekemoer 26035170                      #
%#                                                                     #
%#######################################################################

% The function used to retrieve the file name and its path from the GUI
% IN: user input via edit box
% OUT: DEM file name and path

function [tileName, pathName] = getTileName()

% Get GUI handle
h = findobj('Tag','ProfilerApp');

% If GUI successfully found
if ~isempty(h)
    % Get all associated handles
    appdata = guidata(h);
    
    % DEM file
    tileName = get(appdata.lblDEMFile,'String');
    pathName = get(appdata.lblDEMFile,'UserData');
    
end

end