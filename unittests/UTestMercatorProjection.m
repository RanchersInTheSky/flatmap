classdef UTestMercatorProjection < UTestMapProjections
    
    properties ( TestParameter )
        latitude_deg = {0, 0, 0, 0, 90, -90};
        longitude_deg = {-180, -90, 0, 90, 0, 0};
        rectX = {-180, -90, 0, 90, 0, 0};
        rectY = {0, 0, 0, 0, Inf, -Inf};
    end
    
    properties
        projection = @flatmap.project.mercator;
        inverseProjection = @flatmap.project.mercatorInv;
        projectionParameters = {0, 180/pi};
        
        projAbsTol
        projRelTol
        
        invProjAbsTol
        invProjRelTol
    end
    
end

