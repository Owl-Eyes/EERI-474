%#######################################################################
%#                                                                     #
%#                       EERI 474 - Main Project Code                  #
%#                         by J. Koekemoer 26035170                    #
%#                                                                     #
%#######################################################################

% The main code for the Path/Elevation Profile Extraction project,
% which calls the various sub-functions and provides the user with the
% profile plot data
% IN: All user inputs (indirectly)
% OUT: All program outputs (indirectly)

% INPUT INFO AND FORMATS:
% filePath - file path of data
%            Drive:\...\...\file.extension
% pointSet - matrix of begin/end pairs in lat and long
%            [start1_lat start1_lon end1_lat end1_lon
%             ...
%             startn_lat startn_lon endn_lat endn_lon]
% stepSize - distance between samples in meters
%            int or double
% interpMethod - interpolation method for calculating the line between
%                points
%                'Nearest','Linear', or 'Cubic', case-insensitive
% approxMethod - geograhic approximation method for modelling the planet
%               'Flat','Haversine', or 'Vincenty', case-insensitive
% fileType - the file extension of the data   ( CURRENTLY UNUSED )
%            'tif','tiff', or 'ddf'

function [r_dist, z_elev] = PEPE(filePath, pointSet, stepSize, interpMethod, approxMethod, deg)
tStart = tic;
%% Start-up Performance Improvement

% Likely parallel processing functions:

% parpool(name, size, ...);
% parfor(loopVar, ...) %For the different point set rows?

%% Variable Declarations

tile_data = [];         % the 2D array of DEM data
ellip = [];             % DEM file reference ellipsoid
ref_matp = [];          % DEM reference matrix (geo postings)
ref_mat = [];           % DEM reference matrix (geo cells)
min_elev = 0;           % minimum elevation in DEM file
max_elev = 0;           % maximum elevation in DEM file

lat_range = [];         % the range limits for latitude points
long_range = [];        % the range limits for longitude points

z_elev = [];            % the array of profile elevation values
r_dist = [];            % the array of profile distance values
lat = [];               % the profile latitude values
lon = [];               % the profile longitude values

%pointSet = [];          % the matrix containing points as lat/lon pairs


%% Main Program Begins

%% Get file/path names
% [tile_name, file_path] = getTileName();
% file_location = strcat(file_path,tile_name);

%% Get tile info and data
tic;
[tile_data, ellip, ref_mat, lat_range, long_range] = getTileStuff(filePath);
TileStuffT = toc

%% Get tile stats
tic;
[min_elev, max_elev] = getTileStats(tile_data);
TileStatsT = toc

%% Plot tile in figure
% tic
plotDEM(tile_data, ref_mat); % Optional
% plotDEMT = toc

 %% Find DEM information
% tic;
% [lat_range, long_range] = dispDEMInfo(ref_mat);
% DEMInfoT = toc

% Obtain bounded coordinates
%[plat, plon] = getCoordinates(lat_range, long_range);

% points      /```START```\/````END````\
% pointSet = [-14.91 13.5 -14.93 13.48]; % Town

% plat = [pointSet(:,1) pointSet(:,3)];
% plon = [pointSet(:,2) pointSet(:,4)];

%% Actual profile extraction
tic
[z_elev,r_dist] = extractProfile(tile_data,ellip,ref_mat,pointSet,lat_range,long_range,stepSize,approxMethod,interpMethod);
ProfileT = toc
% Temporary function:
%[z_elev,r_dist,lat,lon] = mapprofile(tile_data,ref_mat,plat,plon,'km',approxMethod,interpMethod);


%% Plot path/elevation profile
tic;
plotProfile(r_dist,z_elev, pointSet, deg);
PlotProfileT = toc

%% Temp Tests
% 
% [begindex, endex] = ltln2ind(tile_data,ref_mat,pointSet)
% 
TotalDuration = toc(tStart)
end