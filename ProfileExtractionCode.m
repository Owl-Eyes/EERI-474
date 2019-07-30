%#######################################################################
%#                                                                     #
%#                       EERI 474 - Main Project Code                  #
%#                         by J. Koekemoer 26035170                    #
%#                                                                     #
%#######################################################################

% The main code for the Path/Elevation Profile Extraction project,
% which calls the various sub-functions and communicates with the API
% IN: All user inputs (indirectly)
% OUT: All program outputs (indirectly)

%% Variable Declarations

tile_name = '';         % the name of the DEM file
file_path = '';         % the file path of the tile
tile_data = [];         % the 2D array of DEM data
tile_info = [];         % DEM file metadata
ref_mat = [];           % DEM reference matrix
min_elev = 0;           % minimum elevation in DEM file
max_elev = 0;           % maximum elevation in DEM file

lat_range = [];         % the range limits for latitude points
long_range = [];        % the range limits for longitude points
plat = [];              % the user-defined latitude points
plon = [];              % the user-defined longitude points

z_elev = [];            % the array of profile elevation values
r_dist = [];            % the array of profile distance values
lat = [];               % the profile latitude values
lon = [];               % the profile longitude values

global dem_select_flag point_select_flag

dem_select_flag = 0;    % flag variable for DEM confirmation (1 = true)
point_select_flag = 0;  % flag variable for point confirmation (1 = true)


%% Temporary Variable Values

% tile_name = 's15_e013_1arc_v3.tif'; % Lubango, Huila

% plon = [13 13.25 13.5 13.75 14]; % Across
% plat = [-15 -14.75 -14.5 -14.25 -14];

plat = [-14.91 -14.92 -14.93]; % Town
plon = [13.5 13.49 13.48];


%% Main Program Begins

% Open demo GUI
%ProfilerApp1;

if dem_select_flag == 0
    
% Get GUI handle
guihandle = findobj('Tag','ProfilerApp');

% If GUI successfully found
if ~isempty(guihandle)
    % Get all associated handles
    hand = guidata(guihandle);
    
    demconfirm = findobj('Tag','btnConfirmDEM');
    %set(demconfirm,'UserData',0);
    
    fprintf('Waiting for DEM \n')
    uiwait(guihandle); 
    % waitfor(demconfirm,'UserData',1);   
    dem_select_flag = 1;
end

end

% Get tile name from GUI
[tile_name, file_path] = getTileName();
file_location = strcat(file_path,tile_name);

% Get tile info and data
[tile_data, tile_info, ref_mat] = getTileStuff(tile_name);

% Get tile stats
[min_elev, max_elev] = getTileStats(tile_data);

% Plot tile in figure
plotDEM(tile_data, ref_mat);

% Provide the user with DEM information
[lat_range, long_range] = dispDEMInfo(min_elev,max_elev,ref_mat);

if (point_select_flag == 0) && (dem_select_flag == 1)
    
% Wait for the user to enter coordinates
guihandle2 = findobj('Tag','ProfilerApp');

% If GUI successfully found
if ~isempty(guihandle2)
    % Get all associated handles
    hand2 = guidata(guihandle2);
    
    confirmpoints = findobj('Tag','btnConfirmPoints');
    %set(confirmpoints,'UserData',0);
    
    fprintf('Waiting for coordinates \n')
    uiwait(guihandle2);
%waitfor(confirmpoints,'UserData',1);
point_select_flag = 1;

end

end

% Obtain coordinates from GUI
[plat, plon] = getCoordinates(lat_range, long_range);

% Actual profile extraction
[z_elev,r_dist,lat,lon] = mapprofile(tile_data,ref_mat,plat,plon,'km','gc','bilinear');


% Plot path/elevation profile
plotProfile(r_dist,z_elev);
