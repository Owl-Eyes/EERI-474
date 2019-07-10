%#######################################################################
%#                                                                     #
%#                   EERI 474 - DEM Plotting Function                  #
%#                       by J. Koekemoer 26035170                      #
%#                                                                     #
%#######################################################################

% The function used to plot the DEM using a colorscale applicable to
% DEM imagery.
% IN: DEM data matrix, reference matrix
% OUT: void (simply plots the geographical image)

function [] = plotDEM(tile, refMat)

figure  % New figure

worldAxes = worldmap(tile,refMat);  % Lat/long axes
geoshow(tile,refMat,'DisplayType','texturemap');  % the DEM texturemap
daspect([ 1 1 1 ]);
demcmap(tile);

axis off

end