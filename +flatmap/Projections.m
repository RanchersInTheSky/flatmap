classdef Projections
    
    enumeration
        mercator ( @flatmap.project.mercator, ...
            @flatmap.project.mercatorInv, ...
            function_handle.empty(), ...
            {0, 180/pi} )
        azimuthalEquidistant ( @flatmap.project.azimuthalEquidistant, ...
            @flatmap.project.azimuthalEquidistantInv, ...
            function_handle.empty(), ...
            {90, 0, 180/pi} )
    end
    
    properties
        transform function_handle
        inverseTransform function_handle
        boundaryTest function_handle
        defaults cell
    end
    
    methods
        function obj = Projections(transform, inverseTransform, boundaryTest, defaults)
            obj.transform = transform;
            obj.inverseTransform = inverseTransform;
            obj.boundaryTest = boundaryTest;
            obj.defaults = defaults;
        end
    end
    
end

