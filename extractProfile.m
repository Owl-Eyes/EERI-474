%#######################################################################
%#                                                                     #
%#               EERI 474 - Profile Extraction Function                #
%#                    by J. Koekemoer 26035170                         #
%#                                                                     #
%#######################################################################

% The function used to retrieve distance and elevation between coordinates
% IN: all key information
% OUT: path profile plot distance and elevation values

function [the_elev,the_dist] = ...
extractProfile(tile_data,e,ref_mat,pointSet,latRange,longRange,stepSize,...
approxMethod,interpMethod)

%% Declare Vars
% pointSet = [  -14.9100   13.5000
%              -14.9300   13.4800];

% points      /```START```\/````END````\
%pointSet = [-14.91 13.5 -14.93 13.48]; % Town
%pointSet = [37 -76 67 -76]; %Test values in help function

% r_dist = [];
% z_elev = [];
% 
% the_dist = [];
% the_elev = [];

% plats = [pointSet(:,1) pointSet(:,3)];
% plons = [pointSet(:,2) pointSet(:,4)];

R = earthRadius('meters');

numPairs = length(pointSet(:,1));

% currentBeginPair = [];
% currentEndPair = [];

% UTM = utmzone(latRange,longRange);

%% Code Begins
% Get tile info and data
%[tile_data, tile_info, ref_mat, ref_mat_g] = getTileStuff(filePath);




%% Check Geo. Approx. Method & Get Distance

approxMethod = lower(approxMethod); %Text to lowercase for some error prevention

% "slice" pointSet
beginlat = pointSet(:,1);
beginlon = pointSet(:,2);
endlat = pointSet(:,3);
endlon = pointSet(:,4);

tic
%% Haversine

if (strcmp(approxMethod,'haversine') == 1)
    
    disp('Haversine Geographical Approximation Method');
    
    %for i = 1:(numPairs)
    parfor i = 1:numPairs  
    
        % Current path coordinates
        currentBeginPair = [beginlat(i), beginlon(i)];
        currentEndPair = [endlat(i), endlon(i)];        
        
        % Distance        
        [arclen, azimuth] = distance(currentBeginPair, currentEndPair);
        kms = deg2km(arclen);   % to meters
        ms = kms * 1000;
        
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
          
        the_dist{i} = r_dist; % Array of distances (multiple pointset)
        
        % Get Start/End Data "Cells"
        [begindex, endex] = ltln2ind(tile_data,ref_mat,pointSet(i,:));

        % Get Elevations           
        %disp('Haversine Geographical Elevation Method');
        
        pts = gcwaypts(currentBeginPair(1,1),currentBeginPair(1,2), ...
              currentEndPair(1,1),currentEndPair(1,2),nlegs);
              
        z_elev = geointerp(tile_data, ref_mat, pts(:,1), pts(:,2), interpMethod);
        
        % FINAL HAVERSINE ELEVATION ARRAY
        
        the_elev{i} = z_elev;    % Array of distances (multiple pointset)
   
    end

        
%% Vincenty

elseif (strcmp(approxMethod,'vincenty') == 1) % Ellipsoidal Elevation
    
    disp('Vincenty Geographical Approximation Method');
     
    %for i = 1:(numPairs)
    parfor i = 1:numPairs 
        
        % Current path coordinates
        currentBeginPair = [beginlat(i), beginlon(i)];
        currentEndPair = [endlat(i), endlon(i)]; 
    
        % Distance
        [arclen, azimuth] = distance(currentBeginPair, currentEndPair, e);
        ms = arclen;   % already meters
        kms = ms / 1000;

        % FINAL VINCENTY DISTANCE ARRAY
        
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
          
        the_dist{i} = r_dist; % Array of distances (multiple pointset)
        
        % Get Start/End Data "Cells"

        [begindex, endex] = ltln2ind(tile_data,ref_mat,pointSet(i,:));

        % Get Elevations
        %disp('Vincenty Geographical Elevation Method');

        pts = track2(currentBeginPair(1,1),currentBeginPair(1,2), ...
              currentEndPair(1,1),currentEndPair(1,2),e,'degrees',nlegs+1);

        z_elev = geointerp(tile_data, ref_mat, pts(:,1), pts(:,2), interpMethod);  

        % FINAL VINCENTY ELEVATION ARRAY
        
        the_elev{i} = z_elev;    % Array of distances (multiple pointset)
    end
    
                          
%% Flat

elseif (strcmp(approxMethod,'flat') == 1)
            
    disp('Flat Earth Geographical Approximation Method \n');
    
    %for i = 1:(numPairs)
    parfor i = 1:numPairs 
        
        % Current path coordinates
        currentBeginPair = [beginlat(i), beginlon(i)];
        currentEndPair = [endlat(i), endlon(i)]; 
    
        % Distance
        %projax = axesm('MapProjection','mercator','MapLatLimit',...
        %               lat_range,'MapLonLimit',long_range);


        % Data for axesm?

        %getm(h,'aspect')

        % Latitude degrees to radians
        phi1 = deg2rad(beginlat(i)); 
        phi2 = deg2rad(endlat(i));

        % Longitudes
        lam1 = beginlon(i);
        lam2 = endlon(i);

        x = (lam2 - lam1) * cos((phi1+phi2)/2);  % Change in x
        y = (phi2 - phi1);                       % Change in y
        kms = deg2km(sqrt((x)^2 + (y)^2) * R) ;  % Distance
        ms = kms * 1000; 



        % FINAL FLAT DISTANCE ARRAY
        
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
          
        the_dist{i} = r_dist; % Array of distances (multiple pointset)
        
        % Get Start/End Data "Cells"

        [begindex, endex] = ltln2ind(tile_data,ref_mat,pointSet(i,:));
        
        % Get Elevations
        %disp('Flat Earth Geographical Elevation Method Not Yet Supported\n'); % Flat Elevation
          
        %z_elev(inGrid) = geointerp(tile_data, ref_mat, plats(inGrid), plons(inGrid), interpMethod);

        % FINAL FLAT ELEVATION ARRAY 
        
        the_elev{i} = z_elev;    % Array of distances (multiple pointset)
        
    end
    
%% Invalid Method

else    % Not Haversine, Vincenty, or Flat
    
    ('Invalid Geographical Approximation Method');
    
end
TForLoop = toc  

