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

clear all % For memory freeing and repeatability analysis

%% Vars

 tile_name = 's15_e013_1arc_v3.tif'; % Lubango, Huila
% tile_name = 'W020S10.dem'; % Western SA + Namibia + S. Angola
%tileName = '9129CATD.ddf';


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
approxMethod = 'Haversine'; % Vincenty, Haversine, or Flat
fileType = 'tif';   % Currently unused


%% 'Main'

%% Example Problem - Placement of Receiving Tower

%                   RX?
%               360`| 0`
%        RX?        |        / RX?
%                   |      /d
%                   |    /
%                   |TX
%    RX? ---------- O ----------- RX?
%      270`         |           90`
%                   |
%                   |
%        RX?        |          RX?
%                   |180`
%                   RX?

TXCoords = [-14.1 13.48];  % Latitude and longitude of Transmitter
d = 2;           % Distance between Transmitter and Receiver (km)
degStart = 0;    % Starting degree (0` is positive x-axis relative to a 2D Cartesian plane)
degEnd = 180;    % Ending degree (anti-clockwise taken as positive, max 360`)
deltaDeg = 60;   % Change in degrees, moving anticlockise from beginning point

[deg, RXCoords] = getRXCoords(TXCoords,d,degStart,degEnd,deltaDeg);

for i = 1:length(deg)
    
    egPointSet(i,1) = TXCoords(1,1); % Constant beginning coordinates for next section
    egPointSet(i,2) = TXCoords(1,2);
    egPointSet(i,3) = RXCoords(i,1);
    egPointSet(i,4) = RXCoords(i,2);
    
end



%% PEPE Call
%tic;  % Start total timer

% Get profile data
%[distData, elevData] = ...
%               PEPE(tile_name,pointSet,stepSize,interpMethod,approxMethod);
[distData, elevData] = ...
    PEPE(tile_name,egPointSet,stepSize,interpMethod,approxMethod,deg);

% Plot results in a figure (optional)
%plotProfile(distData, elevData, pointSet, deg);

%toc;    % End total timer
%TotalDuration = toc


%% Misc
