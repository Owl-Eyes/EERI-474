%#######################################################################
%#                                                                     #
%#                 EERI 474 - Profile Plotting Function                #
%#                       by J. Koekemoer 26035170                      #
%#                                                                     #
%#######################################################################

% The function used to plot the path/elevation profile; the objective 
% of the project.
% IN: profile distance and elevation
% OUT: void (simply plots path/elevation profile)

function [] = plotProfile(ri, zi)

% Plot variables
pathOrelev = 'Path';
titlevar = ' the Selected Area';
xlabelvar = 'Surface Distance';
ylabelvar = 'Elevation';
unitvar = ' (km)';

% Complete titles
xlabelvar = strcat(xlabelvar,unitvar);
ylabelvar = strcat(ylabelvar,unitvar);
titlevar = strcat(pathOrelev,' Profile of ',titlevar);

figure
hold on
title(titlevar)          % Plot labels
xlabel(xlabelvar)
ylabel(ylabelvar)
pbaspect auto;
plot(deg2km(ri),zi/1000,'Color',[0,0.7,0.9]);
%daspect([ 1 1/1000 1 ]); % Choose 1/1 for display without exaggeration


%axis off

end