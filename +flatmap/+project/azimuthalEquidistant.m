function [ x, y ] = azimuthalEquidistant( lat_deg, lon_deg, lat0_deg, lon0_deg, bodyRadius )
    % Reference: Snyder, John P. (1987). Azimuthal Equidistant projection.
    % Map Projects: A Working Manual (pp.195-197). U.S. Geological Survey
    % Professional Paper 1395.
    % Retrieved from https://pubs.er.usgs.gov/publication/pp1395
    
    % Convert degrees to radians
    lat = lat_deg * pi/180;
    lon = lon_deg * pi/180;
    lat0 = lat0_deg * pi/180;
    lon0 = lon0_deg * pi/180;
    
    % Calc the central angle between the lat, lon point and the center
    % point (lat0, lon0), per eq. (5-3) & (25-2) on p. 195.
    cosC = sin(lat0).*sin(lat) + cos(lat0).*cos(lat).*cos(lon-lon0);
    c = acos( cosC );
    
    % Calc the kprime per eq (25-2) and the following paragraph on p. 195.
    kprime = c ./ sin(c);
    kprime(cosC == 1) = 1;
    kprime(cosC == -1) = nan;
    kprime(abs(cosC) > 1) = nan;
    
    % Calc the x & y terms according to eq. (22-4) & (22-5) on p. 195.
    x = bodyRadius * kprime .* cos(lat) .* sin(lon-lon0);
    y = bodyRadius * kprime .* ( cos(lat0).*sin(lat) - sin(lat0).*cos(lat).*cos(lon-lon0) );
end

