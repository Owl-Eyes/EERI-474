%#######################################################################
%#                                                                     #
%#                 EERI 474 - DEM Info Display Function                #
%#                     by J. Koekemoer 26035170                        #
%#                                                                     #
%#######################################################################

% The function used to display the DEM's latitude and longitude limits for
% the user, as well as various DEM statistics.
% IN: minimum and maximum elevations, reference matrix
% OUT: Lat and Long limits (simply updates a label in the GUI)

function [LatLims, LongLims] = dispDEMInfo(minElev, maxElev, refMatrix)

% Lat and Long value identification
minlat = int2str(refMatrix.LatitudeLimits(1,1));  % Move to getTileStats function?
maxlat = int2str(refMatrix.LatitudeLimits(1,2));

minlong = int2str(refMatrix.LongitudeLimits(1,1));
maxlong = int2str(refMatrix.LongitudeLimits(1,2));

LatLims = [refMatrix.LatitudeLimits(1,1),refMatrix.LatitudeLimits(1,2)];
LongLims = [refMatrix.LongitudeLimits(1,1),refMatrix.LongitudeLimits(1,2)];

end