%#######################################################################
%#                                                                     #
%#                 EERI 474 - DEM Info Display Function                #
%#                     by J. Koekemoer 26035170                        #
%#                                                                     #
%#######################################################################

% The function used to display or simply fetch the DEM's latitude and 
% longitude limits for the user, as well as various DEM statistics.
% IN: Reference matrix
% OUT: Lat and Long limits (simply displays)

function [LatLims, LongLims, e] = dispDEMInfo(refMatrix)

% Lat and Long value identification
minlat = int2str(refMatrix.LatitudeLimits(1,1));  % Move to getTileStats function?
maxlat = int2str(refMatrix.LatitudeLimits(1,2));

minlong = int2str(refMatrix.LongitudeLimits(1,1));
maxlong = int2str(refMatrix.LongitudeLimits(1,2));

LatLims = [refMatrix.LatitudeLimits(1,1),refMatrix.LatitudeLimits(1,2)];
LongLims = [refMatrix.LongitudeLimits(1,1),refMatrix.LongitudeLimits(1,2)];

% Calculate the reference ellipsoid
    UTM = utmzone(LatLims,LongLims);
    [ellip,ellipName] = utmgeoid(UTM);
    e = referenceEllipsoid(ellipName);

end