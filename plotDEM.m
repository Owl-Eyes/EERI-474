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
hold on

title('Texture Map of the Selected Region')          % Plot labels
xlabel('Latitude')
ylabel('Longitude')

geoshow(tile,refMat,'DisplayType','surface');  % the DEM texturemap
demcmap(tile);
cbar = colorbar
title(cbar,'Height w.r.t. Sea Level (m)')

daspectm('m',5)
 view(3)       % for 3D visualization
% axis normal
% tightmap

%plotDEMStart = tic;
%axis off
%plotDEMT_Find = toc(plotDEMStart)

end