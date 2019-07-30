%#######################################################################
%#                                                                     #
%#               EERI 474 - Profile Extraction Function                #
%#                    by J. Koekemoer 26035170                         #
%#                                                                     #
%#######################################################################

% The function used to retrieve distance and elevation between coordinates
% IN: all key information
% OUT: path profile plot distance and elevation values

%function [z_elev,r_dist] = extractProfile(tile_data,ref_mat,pointSet,latRange,longRange,stepSize,approxMethod,interpMethod)

%% Temp Vars
% pointSet = [  -14.9100   13.5000
%              -14.9300   13.4800];

filePath = 's15_e013_1arc_v3.tif'; % Lubango, Huila

stepSize = 1000; % Distance between samples

interpMethod = 'bilinear';

% approxMethod = 'haversine'; % Great circle
% approxMethod = 'Vincenty'; % ellipsoidal
 approxMethod = 'Flat'; % Flat Earth

fileType = 'tif';

% points      /```START```\/````END````\
pointSet = [-14.91 13.5 -14.93 13.48]; % Town
%pointSet = [37 -76 67 -76]; %Test values in help function

plats = [pointSet(1,1) pointSet(1,3)];
plons = [pointSet(1,2) pointSet(1,4)];

R = earthRadius('meters');

numPairs = length(pointSet(:,1))

currentBeginPair = [];
currentEndPair = [];

%% Code Begins
% Get tile info and data
[tile_data, tile_info, ref_mat] = getTileStuff(filePath);




%% Check Geo. Approx. Method & Get Distance

approxMethod = lower(approxMethod); %Text to lowercase for some error prevention

for i = 1:numPairs
    
        currentBeginPair = [pointSet(i,1), pointSet(i,2)]
        currentEndPair = [pointSet(i,3), pointSet(i,4)]

        if (strcmp(approxMethod,'flat') == 1)
            
                disp('Flat Earth Geographical Approximation Method \n');
               
                % Latitude degrees to radians
                phi1 = deg2rad(pointSet(i,1)); 
                phi2 = deg2rad(pointSet(i,3));
                
                % Longitudes
                lam1 = pointSet(i,2);
                lam2 = pointSet(i,4);
                
                x = (lam2 - lam1) * cos((phi1+phi2)/2);  % Change in x
                y = (phi2 - phi1);                       % Change in y
                arclen = sqrt((x)^2 + (y)^2) * R        % Distance
            
        elseif (strcmp(approxMethod,'haversine') == 1)
            
                disp('Haversine Geographical Approximation Method');

                [arclen, azimuth] = distance(currentBeginPair, currentEndPair)
                kms = deg2km(arclen)    % to kilometers
                
        elseif (strcmp(approxMethod,'vincenty') == 1)
            
                disp('Vincenty Geographical Approximation Method');
                
                e = referenceEllipsoid(tile_info.Ellipsoid);
                [arclen, azimuth] = distance(currentBeginPair, currentEndPair, e)
                kms = deg2km(arclen)    % to kilometers
            
        else
            
                disp('Invalid Geographical Approximation Method');
            
        end
        
          
end


%% Get Start/End Data "Cells"

[begindex, endex] = ltln2ind(tile_data,ref_mat,pointSet);

%% Get Elevations



