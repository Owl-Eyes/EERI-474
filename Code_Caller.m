%#######################################################################
%#                                                                     #
%#                       EERI 474 - Main Project Code                  #
%#                         by J. Koekemoer 26035170                    #
%#                                                                     #
%#######################################################################

% The main code for the Path/Elevation Profile Extraction project,
% which calls the various sub-functions and provides the profile data
% IN: All user inputs
% OUT: All program outputs


%% Vars

tile_name = 's15_e013_1arc_v3.tif'; % Lubango, Huila

% plon = [13 13.25 13.5 13.75 14]; % Across
% plat = [-15 -14.75 -14.5 -14.25 -14];

plat = [-14.91 -14.93]; % Town
plon = [13.5 13.48];

stepSize = 1000; % Distance between samples

interpMethod = 'bilinear';
approxMethod = 'gc'; % Great circle
fileType = 'tif';


%% 'Main'

% Get profile data
[distData, elevData] = PEPE(tile_name,plat,plon,stepSize,interpMethod,approxMethod,fileType);
% Plot results in a figure (optional)
%plotProfile(distData, elevData);


%% Misc