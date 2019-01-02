function [ lat_deg, lon_deg ] = confineLatLon( lat_deg, lon_deg )
    if any( lon_deg <= -180 | lon_deg > 180 )
        lon_deg = mod(lon_deg, 360);
        lon180to360 = lon_deg > 180;
        lon_deg(lon180to360) = lon_deg(lon180to360) - 360;
    end
    
    if any( lat_deg < -90 | lat_deg > 90 )
        lat_deg = mod(lat_deg, 360);
        lat180to360 = lat_deg > 360;
        lat_deg(lat180to360) = lat_deg(lat180to360) - 360;
        
        if any( lat_deg < -90 )
            latLessNeg90 = lat_deg < -90;
            lat_deg(latLessNeg90) = -( lat_deg(latLessNeg90) + 180 );
            lonLess0 = lon_deg <= 0;
            lonGreater0 = lon_deg > 0;
            lon_deg(latLessNeg90 &lonLess0) = lon_deg(latLessNeg90 & lonLess0) + 180;
            lon_deg(latLessNeg90 &lonGreater0) = lon_deg(latLessNeg90 & lonGreater0) - 180;
        elseif any( lat_deg > 90 )
            latGreater90 = lat_deg > 90;
            lat_deg(latGreater90) = -( lat_deg(latGreater90) - 180 );
            lon_deg(latGreater90) = lon_deg(latGreater90) + 180;
            lon_deg(latGreater90 &lonLess0) = lon_deg(latGreater90 & lonLess0) + 180;
            lon_deg(latGreater90 &lonGreater0) = lon_deg(latGreater90 & lonGreater0) - 180;
        end
    end
    
end