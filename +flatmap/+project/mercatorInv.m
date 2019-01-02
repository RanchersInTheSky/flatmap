function [ lat_deg, lon_deg ] = mercatorInv( x, y, lon0_deg, bodyRadius )
    lon0 = lon0_deg * pi/180;
    
    lon = lon0 + x/bodyRadius;
    lat = asin( tanh( y/bodyRadius ) );
%     lat = 2 * atan( exp( y/bodyRadius ) ) - pi/2;
    
    lat_deg = lat * 180/pi;
    lon_deg = lon * 180/pi;
    
    [lat_deg, lon_deg] = flatmap.internal.confineLatLon(lat_deg, lon_deg);
end

