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

function [] = plotProfile(ri, zi, pointSet, deg)

numPlots = length(ri(1,:));

% Check use case
switch nargin
    case 3
        titlevar2 = ' of the Selected Area, Path: ';
    case 4
        titlevar2 = ' in a Line to the Receiver at Degree: ';
    otherwise
        dislay('Incorrect number of inputs to plotProfile function!')            
end


for i = 1:numPlots
    
    % Fetch current distance and elevation from cell arrays
    ri_now = ri{1,i};
    zi_now = zi{1,i};
    
    % Current coordinates  
    beginCoordvar = strcat(num2str(pointSet(i,1),4),',',num2str(pointSet(i,2),4));
    endCoordvar = strcat(num2str(pointSet(i,3),4),',',num2str(pointSet(i,4),4));
    coordvar = strcat('` (',beginCoordvar,'` to` ',endCoordvar,')');
    
    % Plot variables
    pathOrelev = 'Path';
    xlabelvar = 'Surface Distance';
    ylabelvar = 'Elevation';
    unitvar = ' (km)';
    
    % Get varaible for row/entry reference
    switch nargin
        case 3
            numericalvar = strcat(' `',int2str(i));
        case 4
            numericalvar = strcat(' `',num2str(deg(i,1)));
    end

    % Complete titles
    xlabelvar = strcat(xlabelvar,unitvar);
    ylabelvar = strcat(ylabelvar,unitvar);
    titlevar = strcat(pathOrelev,' Profile ',titlevar2,numericalvar,coordvar);

    % Actual plot
    figure('Color','white')
    hold on
    title(titlevar)          % Plot labels
    xlabel(xlabelvar)
    ylabel(ylabelvar)
    pbaspect auto;
    plot(ri_now/1000,zi_now/1000,'Color',[0.3,0,0.4],'LineWidth',1.5); % to kms
    
    %ax = axis;
    %newAxMin = min(ax(3),0); % If y-axis min is positive, make it 0
    %ylim([newAxMin inf]);
    
    %daspect([ 1 1/1000 1 ]); % Choose 1/1 for display without exaggeration  
    
end

end