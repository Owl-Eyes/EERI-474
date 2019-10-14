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
% plotChoice - does the user want the DEM or path profiles to plot?
%              boolean ([true false] <- [DEMPlot plotProfile]) 
% parallel - does the user wish to use parallel processing?
%            boolean (true or false)
% deg - list of degrees form the demonstration program
%       doubles

function [r_dist, z_elev] = ...
PEPE(filePath, pointSet, stepSize, interpMethod, approxMethod, plotChoice, ...
parallel, deg)

%% Start-up Performance Timer

tStart = tic;

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

%% Check user preferences
plotChoice1 = plotChoice(1,1);
plotChoice2 = plotChoice(1,2);

if (islogical(plotChoice1) + islogical(plotChoice2)) ~= 2
    warning('Variable plotChoice was not Boolean or Logical. Plots will not be shown.');
    plotChoice1 = 0
    plotChoice2 = 0
end

if islogical(parallel) == 0
    warning('Variable parallel not Boolean. Parallel processing Will be used.');
    parallel = 1;
end

%% Get tile info and data
tic;
[tile_data, ellip, ref_mat, lat_range, long_range] = getTileStuff(filePath);
TileStuffT = toc

%% Get tile stats
tic;
[min_elev, max_elev] = getTileStats(tile_data);
TileStatsT = toc

%% Plot tile in figure

if plotChoice1 == 1
    
    tic;
    plotDEM(tile_data, ref_mat); % Optional
    plotDEMT = toc
    
end

%% Actual profile extraction

if parallel == 1 
    % Parallel Processing:
    tic
    [z_elev,r_dist] = extractProfileParallel(tile_data,ellip,ref_mat,pointSet,lat_range,long_range,stepSize,approxMethod,interpMethod);
    ProfileT = toc
else
    % Normal:
    tic
    [z_elev,r_dist] = extractProfile(tile_data,ellip,ref_mat,pointSet,lat_range,long_range,stepSize,approxMethod,interpMethod);
    ProfileT = toc
end

% Temporary function:
%[z_elev,r_dist,lat,lon] = mapprofile(tile_data,ref_mat,plat,plon,'km',approxMethod,interpMethod);


%% Plot path/elevation profile

if plotChoice2 == 1
  
    if nargin == 7
        tic;
        plotProfile(r_dist,z_elev, pointSet);
        PlotProfileT = toc
    elseif nargin == 8
        tic;
        plotProfile(r_dist,z_elev, pointSet, deg);
        PlotProfileT = toc
    end
    
end   

%% Temp Tests
% tic;
% [begindex, endex] = ltln2ind(tile_data,ref_mat,pointSet)
% ltlnT = toc

%% End Performance Timer

TotalDuration = toc(tStart)

end