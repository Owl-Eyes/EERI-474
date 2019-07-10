%#######################################################################
%#                                                                     #
%#                      EERI 474 - Tile Stats Function                 #
%#                         by J. Koekemoer 26035170                    #
%#                                                                     #
%#######################################################################

% This function finds statistics about the tile data, and stores all
% useful information and data in a format usable by the main code and 
% other sub-functions.
% IN: DEM data matrix
% OUT: minimum and maximum elevations

function [minElev, maxElev] = getTileStats(tile)

minElev = min(tile(:)); % minimum elevation and position
maxElev = max(tile(:)); % maximum elevation and position

end