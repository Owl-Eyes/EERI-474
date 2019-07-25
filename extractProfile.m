%#######################################################################
%#                                                                     #
%#               EERI 474 - Profile Extraction Function                #
%#                    by J. Koekemoer 26035170                         #
%#                                                                     #
%#######################################################################

% The function used to retrieve distance and elevation between coordinates
% IN: all key information
% OUT: path profile plot distance and elevation values

function [z_elev,r_dist] = extractProfile(tile_data,ref_mat,pointSet,latRange,longRange,stepSize,approxMethod,interpMethod)

%% Temp Vars
% pointSet = [  -14.9100   13.5000
%              -14.9300   13.4800];

% points      /```START```\/````END````\
% pointSet = [-14.91 13.5 -14.93 13.48]; % Town

plats = [pointSet(1,:) pointSet(3,:)];
plons = [pointSet(2,:) pointSet(4,:)];

%% Code Begins

%% Check Geo. Approx. Method & Get Distance

approxMethod = lower(approxMethod); %Text to lowercase for some error prevention

if approxMethod == 'flat'
    {
        disp('This Geographical Approximation Method Is Not Yet Supported \n');
        % arclen = sqrt((x1-x0)^2 + (y1-y069)^2);
    }
elseif approxMethod == 'haversine'
    {
        disp('Haversine Geographical Approximation Method');
        
        [arclen, azimuth] = distance(plats(1,:), plons(1,:));
    }
elseif approxMethod == 'vincenty'
    {
        disp('This Geographical Approximation Method Is Not Yet Supported \n');
        %[arclen, azimuth] = distance(pointSet(1,:),
        %pointSet(2,:),ellipsoid); % Add ellipsoid
    }
else
    {
        disp('Invalid Geographical Approximation Method');
    }
end


%% Get Start/End Data "Cells"

[begindex, endex] = ltln2ind(map,ref,pointSet);

%% Get Elevations



