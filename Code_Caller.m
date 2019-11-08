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
% tile_name = 'W020S10.dem'; % Western ZA + Namibia + S. Angola
% tile_name = '9129CATD.ddf';
% tile_name = 'S26E019.hgt'; % SRTM, ZA

% pointSet = [-26.5 19.5 -26.6 19.6]; % SRTM points
 
% points      /```START```\/````END````\
 pointSet =   [-14.92 13.5 -14.93 13.49    % Town
               -14.25 13.25 -14.75 13.75]; % DiagoNal section
%             \ lat  long / \ lat long /

stepSize = 100; % Distance between samples (in meters)

interpMethod = 'cubic';
approxMethod = 'Vincenty'; % Vincenty, Haversine, or Flat

% Show Plot: [DEM  Profile], true or false?, (y/n)
plotChoice = [true true];

parallel = false;   % True for on, false for off

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
d = 2;         % Distance between Transmitter and Receiver (km)
degStart = 30;   % Starting degree (0` is positive x-axis relative to a 2D Cartesian plane)
degEnd = 90;    % Ending degree (anti-clockwise taken as positive, max 360`)
deltaDeg = 30;  % Change in degrees, moving anticlockise from beginning point

[deg, RXCoords] = getRXCoords(TXCoords,d,degStart,degEnd,deltaDeg);

for i = 1:length(deg)
    
    egPointSet(i,1) = TXCoords(1,1); % Constant beginning coordinates for next section
    egPointSet(i,2) = TXCoords(1,2);
    egPointSet(i,3) = RXCoords(i,1);
    egPointSet(i,4) = RXCoords(i,2);
    
end



%% PEPE Call
%tic;  % Start total timer

% Get profile data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%NORMAL

%[distData, elevData] = ...
%PEPE(tile_name,pointSet,stepSize,interpMethod,approxMethod,plotChoice,parallel);

%DEMONSTRATION

[distData, elevData] = ...
PEPE(tile_name,egPointSet,stepSize,interpMethod,approxMethod,plotChoice,parallel,deg);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot results in a figure (optional)
%plotProfile(distData, elevData, pointSet, deg);

%toc;    % End total timer
%TotalDuration = toc


%% Misc
