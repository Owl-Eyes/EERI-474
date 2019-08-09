%#######################################################################
%#                                                                     #
%#               EERI 474 - Profile Extraction Function                #
%#                    by J. Koekemoer 26035170                         #
%#                                                                     #
%#######################################################################

% The function used to retrieve distance and elevation between coordinates
% IN: all key information
% OUT: path profile plot distance and elevation values

function [z_elev,r_dist] = ...
extractProfile(tile_data,tile_info,ref_mat,pointSet,latRange,longRange,stepSize,...
approxMethod,interpMethod)

%% Declare Vars
% pointSet = [  -14.9100   13.5000
%              -14.9300   13.4800];

% points      /```START```\/````END````\
pointSet = [-14.91 13.5 -14.93 13.48]; % Town
%pointSet = [37 -76 67 -76]; %Test values in help function

r_dist = [];
z_elev = [];

plats = [pointSet(:,1) pointSet(:,3)];
plons = [pointSet(:,2) pointSet(:,4)];

R = earthRadius('meters');

numPairs = length(pointSet(:,1));

currentBeginPair = [];
currentEndPair = [];


%% Code Begins
% Get tile info and data
%[tile_data, tile_info, ref_mat, ref_mat_g] = getTileStuff(filePath);




%% Check Geo. Approx. Method & Get Distance

approxMethod = lower(approxMethod); %Text to lowercase for some error prevention

for i = 1:numPairs
    
        currentBeginPair = [pointSet(i,1), pointSet(i,2)];
        currentEndPair = [pointSet(i,3), pointSet(i,4)];

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
                ms = deg2km(sqrt((x)^2 + (y)^2) * R) * 1000 ;  % Distance
            
        elseif (strcmp(approxMethod,'haversine') == 1)
            
                disp('Haversine Geographical Approximation Method');

                [arclen, azimuth] = distance(currentBeginPair, currentEndPair)
                ms = deg2km(arclen) * 1000;   % to meters
                
        elseif (strcmp(approxMethod,'vincenty') == 1)
            
                disp('Vincenty Geographical Approximation Method');
                
                e = referenceEllipsoid(tile_info.Ellipsoid);
                [arclen, azimuth] = distance(currentBeginPair, currentEndPair, e)
                ms = arclen;   % already meters
            
        else
            
                disp('Invalid Geographical Approximation Method');
            
        end
        
        % FINAL DISTANCE ARRAY
        
        % Determine number of "legs" between points along path
        nlegs = round(ms/stepSize); %improve round into fraction?
        
        % Declare distance array
        r_dist = zeros(nlegs+1,1);
        
        % Populate distance array
        tempdist = 0;
        
        for j = 1:nlegs+1
            
            r_dist(j,1) = tempdist;
            tempdist = tempdist + stepSize;
            
        end
          
end


%% Get Start/End Data "Cells"

[begindex, endex] = ltln2ind(tile_data,ref_mat,pointSet);

%% Get Elevations

% Declare elevation array
z_elev = zeros(nlegs+1,1);

% Get elevation acc. to type
if (strcmp(approxMethod,'flat') == 1)
            
    disp('Flat Earth Geographical Elevation Method Not Yet Supported\n'); % Flat Elevation
          
    %z_elev(inGrid) = geointerp(tile_data, ref_mat, plats(inGrid), plons(inGrid), interpMethod);


    elseif (strcmp(approxMethod,'haversine') == 1)  % Great Circle Elevation

            disp('Haversine Geographical Elevation Method');
            
            pts = gcwaypts(currentBeginPair(1,1),currentBeginPair(1,2), ...
                  currentEndPair(1,1),currentEndPair(1,2),nlegs);
              
            z_elev = geointerp(tile_data, ref_mat, pts(:,1), pts(:,2), interpMethod);  

    elseif (strcmp(approxMethod,'vincenty') == 1) % Ellipsoidal Elevation

            disp('Vincenty Geographical Approximation Method');

            pts = track2(currentBeginPair(1,1),currentBeginPair(1,2), ...
                  currentEndPair(1,1),currentEndPair(1,2),e,'degrees',nlegs+1);
            
            z_elev = geointerp(tile_data, ref_mat, pts(:,1), pts(:,2), interpMethod);  

    else

            disp('Invalid Elevation Extraction Method');

end

