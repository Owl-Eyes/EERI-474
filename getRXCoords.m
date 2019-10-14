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

% Create generic reference ellipsoid
E = wgs84Ellipsoid('km');

% Convert input to 360` max
if degStart > 360 || degStart < 0
    degStart = wrapTo360(degStart);
end
if degEnd > 360 || degEnd < 0
    degEnd = wrapTo360(degEnd);
end

if degStart <= degEnd % check that correct sector is being used
    totalDegrees = degEnd - degStart;
elseif degStart > degEnd % similar to negative angles
    totalDegrees = (360 - degStart) + degEnd;
end

numSlices = round(totalDegrees/deltaDeg);

for j = 1:numSlices+1
      
    % Degree value for the current loop
    degNow = degStart + (j-1)*deltaDeg; 
    
    if degNow > 360
        degNow = 360 - degNow;  % Limit to circular 360`
    end

    % RX coordinate for the current loop
    RXNow = reckon(TXLat,TXLong,d,degNow,E); 
    
    % Save variables
    deg(j,1) = degNow;
    RXCoords(j,1) = RXNow(1,1);
    RXCoords(j,2) = RXNow(1,2);

end

