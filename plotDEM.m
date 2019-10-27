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

function [] = plotDEM(tile, refMat, fileType)

figure('Color','white')  % New figure

worldAxes = worldmap(tile,refMat);  % Lat/long axes

% Orientation    
if strcmp(fileType,'tif')
    set(gca,'YDir','reverse');
end  


hold on

title('Texture Map of the Selected Region')    % Plot labels
xlabel('Latitude')
ylabel('Longitude')

geoshow(tile,refMat,'DisplayType','surface');  % DEM texture map
demcmap(tile);

cbar = colorbar; % Illustrates elevation
title(cbar,'Height w.r.t. Sea Level (m)')

daspectm('m',5)
view(3)       % for 3D visualization

%plotDEMStart = tic;
%axis off
%plotDEMT_Find = toc(plotDEMStart)

end