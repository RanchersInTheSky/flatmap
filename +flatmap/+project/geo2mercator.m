function [x, y] = geo2mercator(lat_deg, lon_deg, lon0_deg, bodyRadius)
    lat  = lat_deg * pi/180;
    lon  = lon_deg * pi/180;
    lon0 = lon0_deg * pi/180;
    
    x = bodyRadius * (lon - lon0);
    y = bodyRadius * atanh( sin(lat) );
%     y = bodyRadius * log(tan(pi/4 + lat/2));
end