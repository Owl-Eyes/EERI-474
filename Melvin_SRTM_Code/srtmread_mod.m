function [y,refvec] = srtmread_mod(tile_name,tile_name_only,srtm_scale)
% Function srtm_read returns the srtm3 elevation tile for a 1 x 1 degree
% tile and the corresponding reference vector as used by matlab
% The tile dimensions depend on the srtm sample rate and is given by the
% srtm_scale parameter.
% The tile_lat and tile_lon parameters give the northwest corner (NW) of the
% tile coordinates - however srtm requires the southwest corner coordinates -
% so these parameters need to be modified
% NB - the value -32768 is assigned to void values - this will have to be
% handled by the function caller.
% NB The function returned is 1201 elements by 1201 elements -there is an
% overlap on all 4 sides of each tile - the grid spacing of 1200 / degree
% remains unaffected however!
% v1 - 22/04/2012
% v2 - 29/05/2012
%    - Fixed an error in the indexing - srtm tiles are read from North (row1) to South (row1201), but
%    the regular data grids in matlab are read from south (row 1) to north
%    (row 1201)
% v3 - 30/05/2012 
%    - Added errror handling for tile requests that are out of bounds 
% v4 - Changed the grid alignment value to 1,5 arc-seconds, instead of 3
%      arc-seconds
% v5 - added fucntionality to strip unneccessary rows and cols from tile
% before sending it back for processing. Also added code to prevent error
% messages from being displayed for tiles not surveyed!
% v6 - 23/02/2018 - Adapted for use for MEng of Hanco Buys. This entails
% change in logic and maths for working in the northern hemisphere.
% v7 - 23/10/2019 - General housekeeping & updating before shipping to Jess
% Error checking function for missing tile files still not perfect :(
% v_mod - 08/11/2019 - Function modified by J. Koekemoer for easier
% integration with the PEPE software.
if (nargin==3 && srtm_scale == 1201)

% Convert integer inputs to strings and correct NW to SW reference
%tile_lat_st = int2str(tile_lat+1) ;
%tile_lon_st = int2str(tile_lon) ;    
% Data path to SRTM tiles
%suffix = '.hgt' ;
%Data_path= strcat(pwd,'/srtmdump/');
%Data_path= strcat(Data_path,'S', tile_lat_st,'/S', tile_lat_st,'E0', tile_lon_st,'.hgt') ;

% E.g.   'S26E019.hgt'

% Get lat/lon from tile name (reverse process)
try
    % Longitudes
    try
        tile_lon = str2num(extractAfter(tile_name_only,'E'));
        rest = extractBefore(tile_name,'E');
        lonType = 'E';
    catch
        tile_lon = str2num(extractAfter(tile_name_only,'W'));
        rest = extractBefore(tile_name,'W');
        lonType = 'W';
    end
    % Latitudes
    try
        tile_lat = str2num(extractAfter(rest,'S'));
        latType = 'S';
    catch
        tile_lat = str2num(extractAfter(rest,'N'));
        latType = 'N';
    end
catch %File has non-conventional naming format
    error('File name does not follow convention, E.g. ''S26E019.hgt'', please rename.');
end


% Read in binary file - ensure signed 16 bit integer format (cast ouput to 16 bit)
% Pre-aalocate memory for srtm_array
[srtm_tile(1:srtm_scale,1:srtm_scale)] = 0 ;
% Cast srtm_tile to int16 - all that srtm data requires
srtm_tile = cast(srtm_tile,'int16') ;

% Open .hgt file - ensure big-endian byte order and read-only open!
fid = fopen(tile_name,'r','ieee-be');
% Fopen returns -1 if file not found - this means one of 2 things:
% The tile requested is not in the search path
% Build matrix to prevent message if tile is not in srtm set, and hence not
% in search path!
%% NB these bounds will need to be changed or as these bound only apply to South Africa
lat_bounds = [27 28 29 30 30 36 36 36 36 36 35 35 35 34 30 31 31 32 32 33 34 34 35 35 35 36 36 36 36 31 31 31 31 33 33 33 34 34 34 34 36] ;
lon_bounds = [33 33 33 32 33 18 19 20 21 22 17 26 27 28 15 31 16 31 16 30 28 29 28 27 26 17 23 24 25 31 32 15 16 16 30 31 28 29 30 16 26] ;
% The tile requested is in the sea
if fid == -1
    % Test if tile is actually missing or not sampled!
    a = tile_lat+1 == lat_bounds ;
    b = tile_lon == lon_bounds ;
    if any(a+b == 2)   
    % Do nothing!
    else
    %fprintf('srtm_read: Tile %s S %s E is not found, returning zeros tile \n',tile_lat_st,tile_lon_st) ;
    fprintf('srtm_read: Tile %s S %s E is not found, returning void tile \n',tile_lat_st,tile_lon_st) ;
    % Generate void tile - this is because we do not want the ocean values
    % to be used in the calculation - it skews the results - making the
    % tower higher than what it actually is.
    end
    % Either way return void tile if there is no tile!
    strm_tile = -32768 * ones(srtm_scale) ;
else    
    for i=1:1:srtm_scale
     % Read in one row at a time and cast values to 16 bit signed integer
     srtm_temp = fread(fid,srtm_scale,'*int16') ;
     % Write row to srtm_tile (start at row 1201 - top of tile (northern side) and work to row 1 - bottom (southern side))
     [srtm_tile((srtm_scale+1)-i,1:srtm_scale)] = srtm_temp(1:srtm_scale) ;
    end
    fclose(fid);
end

% Modify tile to remove erronous row. 
% Create 1200 x 1200 tile
srtm_tile_mod = zeros(srtm_scale-1,'int16') ;
% Remove last row and column (west column and south row!) - recall tile is
% already noq  matlab geostructure, column is ordered normally, BUT row 1
% is on southern edge!!!
srtm_tile_mod = srtm_tile(2:1201,1:1200) ;

% Write modified tile out to function handle
y = srtm_tile_mod ;

% Assemble refrence vector to refrence to the Norhwestern corner of tile
% Shift vector with 3 or 1.5 ? arcseconds to align grid with measurements
v = dms2degrees([0 0 1.5]) ;
lat = (-1 * tile_lat) - v  ;
lon = tile_lon - v ;
refvec = [srtm_scale-1 lat lon] ;

else
    error('srtmread: 3 input arguments required: N_tile_lat, W_tile_lon srtm_scale') ;
end