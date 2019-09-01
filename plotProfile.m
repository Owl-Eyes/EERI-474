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

numPlots = length(ri(1,:));

for i = 1:numPlots
    
    % Fetch current distance and elevation from cell arrays
    ri_now = ri{1,i};
    zi_now = zi{1,i};

    % Plot variables
    pathOrelev = 'Path';
    titlevar = ' the Selected Area';
    xlabelvar = 'Surface Distance';
    ylabelvar = 'Elevation';
    unitvar = ' (km)';

    % Complete titles
    xlabelvar = strcat(xlabelvar,unitvar);
    ylabelvar = strcat(ylabelvar,unitvar);
    titlevar = strcat(pathOrelev,' Profile of ',titlevar,' ',int2str(i));

    figure
    hold on
    title(titlevar)          % Plot labels
    xlabel(xlabelvar)
    ylabel(ylabelvar)
    pbaspect auto;
    plot(deg2km(ri_now),zi_now/1000,'Color',[0,0.7,0.9]);
    %daspect([ 1 1/1000 1 ]); % Choose 1/1 for display without exaggeration

end
%axis off

end