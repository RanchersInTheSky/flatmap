classdef UTestAzimuthalEquidistantProjection < UTestMapProjections
    
    properties ( TestParameter )
        latitude_deg = {80, 80, 70, 60, 50, 40, 30, 20, 10, 0};
        longitude_deg = {0, 10, 20, 30, 40, 50, 60, 70, 80, 90};
        rectX = {0, 0.04281, 0.15362, 0.31145, 0.50127, ...
            0.71195, 0.93436, 1.15965, 1.37704, 1.57080};
        rectY = {1.39626, 1.39829, 1.23407, 1.07891, 0.92938, ...
            0.77984, 0.62291, 0.44916, 0.24656, 0};
    end
    
    properties
        projection = @flatmap.project.geo2azimuthalEquidistant;
        inverseProjection = @flatmap.project.azimuthalEquidistant2geo;
        projectionParameters = {0, 0, 1};
        
        projAbsTol = 5e-5;
        projRelTol
        
        geodAbsTol = 9e-4;
        geodRelTol
    end
    
end

