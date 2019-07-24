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
pointSet = [  -14.9100   13.5000
             -14.9300   13.4800];


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
        [begindex, endex] = ltln2ind(map,ref,pointSet)
        disp('Haversine Geographical Approximation Method');
        
        [arclen, azimuth] = distance(pointSet(1,:), pointSet(2,:));
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

%% Get Elevations

