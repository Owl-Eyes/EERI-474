%#######################################################################
%#                                                                     #
%#                    EERI 474 - Coordinate Function                   #
%#                       by J. Koekemoer 26035170                      #
%#                                                                     #
%#######################################################################

% The function used to retrieve the user-defined coordinates from the GUI
% IN: user input via edit boxes
% OUT: user-defined latitude and longitude points

function [Lats, Longs] = getCoordinates(LatLims, LongLims)

% Get GUI handle
h = findobj('Tag','ProfilerApp');

% If GUI successfully found
if ~isempty(h)
    % Get all associated handles
    appdata = guidata(h);
    
    %uiwait;
      
    % GUI coordinates
    Lat1 = str2double(get(appdata.edALat,'String'));
    Lat2 = str2double(get(appdata.edBLat,'String'));
    Long1 = str2double(get(appdata.edALong,'String'));
    Long2 = str2double(get(appdata.edBLong,'String'));
%     
%     % Check if inputs are within limits
%     if (LatLims(1,1) <= Lat1) && (Lat1 <= LatLims(1,2))...
%         && (LatLims(1,1) <= Lat2) && (Lat2 <= LatLims(1,2))
%     
%         if (LongLims(1,1) <= Long1) && (Long1 <= LongLims(1,2))...
%             && (LongLims(1,1) <= Long2) && (Long2 <= LongLims(1,2))
%             % No input errors
            Lats = [Lat1, Lat2];
            Longs = [Long1, Long2];
%     
%         else
%             errordlg('Longitude out of bounds','Input Error');
%         end
%     else
%         errordlg('Latitude out of bounds','Input Error');
%     end
%     
% end

end