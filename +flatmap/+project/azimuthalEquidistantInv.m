function [ lat_deg, lon_deg ] = azimuthalEquidistantInv( x, y, lat0_deg, lon0_deg, bodyRadius )
    % Reference: Snyder, John P. (1987). Azimuthal Equidistant projection.
    % Map Projects: A Working Manual (pp.195-197). U.S. Geological Survey
    % Professional Paper 1395.
    % Retrieved from https://pubs.er.usgs.gov/publication/pp1395
    
    % Convert degrees to radians
    lat0 = lat0_deg * pi/180;
    lon0 = lon0_deg * pi/180;
    
    % Calc rho and c per eq. (20-18) & (25-15) on p. 196.
    rho = hypot(x, y);
    c = rho / bodyRadius;
    
    % Calc lat per eq. (20-14) and set lat to lat0 if rho == 0 per the
    % paragraph on p.196 between eq. (20-14) & (20-15).
    lat = asin( cos(c).*sin(lat0) + y.*sin(c).*cos(lat0)./rho );
    lat(rho == 0) = lat0;
    
    % Calc lon per eq. (20-15) and set lon to lon0 if rho == 0 per the
    % paragraph on p.196 between eq. (20-14) & (20-15).
    lon = lon0 + atan2( x.*sin(c), rho.*cos(lat0).*cos(c) - y.*sin(lat0).*sin(c) );
    lon(rho == 0) = lon0;
    
    % Convert radians to degrees
    lat_deg = lat * 180/pi;
    lon_deg = lon * 180/pi;
    
    [lat_deg, lon_deg] = flatmap.internal.confineLatLon(lat_deg, lon_deg);
end

