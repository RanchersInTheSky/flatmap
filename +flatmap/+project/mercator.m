function [x, y] = mercator(lat_deg, lon_deg, lon0_deg, bodyRadius)
    lat = lat_deg * pi/180;
    lon_deg = lon_deg - lon0_deg;
    lonOutOfBounds = lon_deg < -180 | lon_deg > 180;
    lon_deg(lonOutOfBounds) = mod(lon_deg(lonOutOfBounds), 360);
    lon_deg(lon_deg > 180) = lon_deg(lon_deg > 180) - 360;
    lon = lon_deg * pi/180;
    
    x = bodyRadius * (lon);
    y = bodyRadius * atanh( sin(lat) );
%     y = bodyRadius * log(tan(pi/4 + lat/2));
end