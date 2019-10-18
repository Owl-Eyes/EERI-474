%#######################################################################
%#                                                                     #
%#         EERI 474 - Profile Extraction Function (Parallel)           #
%#                    by J. Koekemoer 26035170                         #
%#                                                                     #
%#######################################################################

% The function used to retrieve distance and elevation between coordinates,
% using a parallel processing techinque with the for loops
% IN: all key information
% OUT: path profile plot distance and elevation values

function [the_elev,the_dist] = ...
extractProfileParallel(tile_data,e,ref_mat,pointSet,latRange,longRange,...
stepSize,approxMethod,interpMethod)

%% Declare Vars

% the_dist = [];
% the_elev = [];     

radE = earthRadius('meters');

numPairs = length(pointSet(:,1));

%% Code Begins

%% Check Geo. Approx. Method & Get Distance

approxMethod = lower(approxMethod); %Text to lowercase for some error prevention

% "slice" pointSet
beginlat = pointSet(:,1);
beginlon = pointSet(:,2);
endlat = pointSet(:,3);
endlon = pointSet(:,4);

tic     % Parfor loop timer
%% Haversine

if (strcmp(approxMethod,'haversine') == 1)
    
    disp('Haversine Geographical Approximation Method');
    
    parfor i = 1:numPairs  
        
        % Clear temporary variables 
        r_dist = [];
        z_elev = [];
        currentBeginPair = [];
        currentEndPair = [];
    
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
        %[begindex, endex] = ltln2ind(tile_data,ref_mat,pointSet(i,:));

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
     
    parfor i = 1:numPairs 
        
        % Clear temporary variables  
        r_dist = [];
        z_elev = [];
        currentBeginPair = [];
        currentEndPair = [];
        
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
        %[begindex, endex] = ltln2ind(tile_data,ref_mat,pointSet(i,:));

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
    
    % Convert reference matrix to map equivalent
    R = maprasterref('RasterSize', ref_mat.RasterSize, ...
          'YWorldLimits', ref_mat.YIntrinsicLimits, 'ColumnsStartFrom',...
          ref_mat.ColumnsStartFrom,'XWorldLimits', ref_mat.XIntrinsicLimits);
    
    UTM = utmzone(lat_range,long_range);
    utmstruct = defaultm('utm');
    utmstruct.zone = UTM;
    utmstruct.geoid = e;
    utmstruct = defaultm(utmstruct);
          
    [Xi,Yi] = mfwdtran(utmstruct, beginlat, beginlon);
    [Xj,Yj] = mfwdtran(utmstruct, endlat, endlon);
    
    %parfor i = 1:(numPairs)
    for i = 1:numPairs 
        
        % Clear temporary variables 
        r_dist = [];
        z_elev = [];
        currentBeginPair = [];
        currentEndPair = [];
        
        % Current path coordinates
        currentBeginPair = [Xi(i), Yi(i)];
        currentEndPair = [Xj(i), Yj(i)]; 
    
        % Distance

%         % Latitude degrees to radians
%         phi1 = deg2rad(beginlat(i)); 
%         phi2 = deg2rad(endlat(i));
% 
%         % Longitudes
%         lam1 = beginlon(i);
%         lam2 = endlon(i);

        x = currentEndPair(1,1) - currentBeginPair(1,1);  % Change in x
        y = currentEndPair(1,2) - currentBeginPair(1,2);  % Change in y
        ms = sqrt((x)^2 + (y)^2);  % Distance
        kms = ms / 1000; 

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

        % Get Elevations
        %disp('Flat Earth Geographical Elevation Method \n');

        % Determine equation of line between points ( y = mx + c )
%         fx = [Xi(i) Xj(i)];
%         fy = [Yi(i) Yj(i)];
%         fv = [[1; 1]  fx(:)]\fy(:);  % Calculate parameter vector
%         grad_m = fv(2); % Gradient m
%         int_c = fv(1);  % Intercept c
        
          fv = polyfit([Xi(i), Xj(i)], [Yi(i), Yj(i)], 1);
          grad_m = fv(2); % Gradient m
          int_c = fv(1);  % Intercept c
          
          % Trigonometry for straight line vs xy-axes
          
%                    /|?`B
%                  /  |
%             hyp/    |o
%              /      |
%          A /_?`____|| 90`C
%                 a
          
          hyp = tempdist;   % Hypotenuse
          a = x;            % Adjacent side
          o = y;            % Opposite side
          A = acosd((hyp^2 + a^2 - o^2)/(2*hyp*a)); %Unknown angle A
          B = 90 - A;       % Unknown angle B (180` = 90` - A` // triangle)
          
          deltaX = stepSize*sind(B);    % Law of Sines
          
          tempX = Xi(i);    % Initial x value
          
        for ptLoop = 1:nlegs+1
            tempX = tempX + deltaX   % x = adjacent distance at sample
            %tempY = grad_m*tempX + int_c; % y = mx + c
            tempY = polyval(fv,tempX);
            tempPt = [tempX, tempY];      % waypoint (x, y)
            
            pts(ptLoop,1) = tempPt(1,1);         % save waypoints in array
            pts(ptLoop,2) = tempPt(1,2);         % save waypoints in array
        end

        z_elev = mapinterp(tile_data, R, pts(:,1), pts(:,2), interpMethod);

        % FINAL FLAT ELEVATION ARRAY 
        
        the_elev{i} = z_elev;    % Array of distances (multiple pointset)
        
    end
    
%% Invalid Method

else    % Not Haversine, Vincenty, or Flat
    
    ('Invalid Geographical Approximation Method');
    
end
TForLoop = toc  

