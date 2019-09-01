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
% tile_name = 'W020S10.dem'; % Western SA + Namibia + S. Angola

% plon = [13 13.25 13.5 13.75 14]; % Across
% plat = [-15 -14.75 -14.5 -14.25 -14];

% points   /```START```\/````END````\ 
%pointSet = [-14.91 13.5 -14.93 13.48]; % Town
%          \ lat  long / \ lat long /

% points      /```START```\/````END````\
pointSet =   [-14.91 13.5 -14.93 13.48 %]   % Town
              -14.25 13.25 -14.75 13.75]; % DiagoNal section
%             \ lat  long / \ lat long /

stepSize = 100; % Distance between samples (in meters)

interpMethod = 'Linear';
approxMethod = 'Vincenty'; % Great circle
fileType = 'tif';   % Currently unused


%% 'Main'

%tic;  % Start total timer

% Get profile data
[distData, elevData] = ...
 PEPE(tile_name,pointSet,stepSize,interpMethod,approxMethod,fileType);
% Plot results in a figure (optional)
%plotProfile(distData, elevData);

%toc;    % End total timer
%TotalDuration = toc


%% Misc
