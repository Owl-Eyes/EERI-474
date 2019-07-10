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

function [r_dist, z_elev] = PEPE(filePath, plat, plon, numSamples, interpMethod, approxMethod, fileType)


%% Variable Declarations

tile_data = [];         % the 2D array of DEM data
tile_info = [];         % DEM file metadata
ref_mat = [];           % DEM reference matrix
min_elev = 0;           % minimum elevation in DEM file
max_elev = 0;           % maximum elevation in DEM file

lat_range = [];         % the range limits for latitude points
long_range = [];        % the range limits for longitude points

z_elev = [];            % the array of profile elevation values
r_dist = [];            % the array of profile distance values
lat = [];               % the profile latitude values
lon = [];               % the profile longitude values


%% Main Program Begins

% Get file/path names
% [tile_name, file_path] = getTileName();
% file_location = strcat(file_path,tile_name);

% Get tile info and data
[tile_data, tile_info, ref_mat] = getTileStuff(filePath);

% Get tile stats
[min_elev, max_elev] = getTileStats(tile_data);

% Plot tile in figure
plotDEM(tile_data, ref_mat);

% Print DEM information
[lat_range, long_range] = dispDEMInfo(min_elev,max_elev,ref_mat)

% Obtain bounded coordinates
%[plat, plon] = getCoordinates(lat_range, long_range);

% Actual profile extraction
[z_elev,r_dist,lat,lon] = mapprofile(tile_data,ref_mat,plat,plon,'km',approxMethod,interpMethod);


% Plot path/elevation profile
plotProfile(r_dist,z_elev);









end