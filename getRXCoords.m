%#######################################################################
%#                                                                     #
%#                 EERI 474 - Receiver Corrdinate Function             #
%#                     by J. Koekemoer 26035170                        #
%#                                                                     #
%#######################################################################

% The function used to determine the coordinates of possible receiver
% locations a set distance (d) in km from the transmitter
% IN: TX coordinates, distance, start and end degrees, change in degrees
% for each step (clockise from start to end).
% OUT: matrix of degrees and relative possible reciever coordinates

function [deg, RXCoords] = getRXCoords(TXCoords,d,degStart,degEnd,deltaDeg);

TXLat = TXCoords(1,1);
TXLong = TXCoords(1,2);

%d = 1000*d; %to km

E = wgs84Ellipsoid('km');

if degStart <= degEnd % check that correct sector is being used
    totalDegrees = degEnd - degStart;
elseif degStart > degEnd % similar to negative angles
    totalDegrees = (360 - degStart) + degEnd;
end

numSlices = round(totalDegrees/deltaDeg);

for j = 1:numSlices+1
           
    degNow = degStart + (j-1)*deltaDeg; % Degree value for the current loop
    
    if degNow > 360
        degNow = 360 - degNow;  % Limit to circular 360`
    end

    % RX coordinate for the current loop
    RXNow = reckon(TXLat,TXLong,d,degNow,E); 
    
    deg(j,1) = degNow;
    RXCoords(j,1) = RXNow(1,1);
    RXCoords(j,2) = RXNow(1,2);

end

