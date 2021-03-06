%#######################################################################
%#                                                                     #
%#                 EERI 474 - Coordinate Index Function                #
%#                       by J. Koekemoer 26035170                      #
%#                                                                     #
%#######################################################################

% The function used to retrieve the matrix indices of the begin and end
% lat/lon coordinates
% IN: Matrix of coordinates, Tile data, and Reference matrix
% OUT: Two Matrix indices

function [begindex,endex] = ltln2ind(map,mapref,pointSet)
% tic;

% Indices of beginning lat/lon
[brow,bcol] = setpostn(map,mapref,pointSet(1,1),pointSet(1,2));
begindex = [brow,bcol];

% Indices of ending lat/lon
[erow,ecol] = setpostn(map,mapref,pointSet(1,3),pointSet(1,4));
endex = [erow,ecol];

% ltlnT = toc;
end