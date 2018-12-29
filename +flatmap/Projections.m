classdef Projections
    
    enumeration
        mercator ( @flatmap.project.mercator, ...
            @flatmap.project.mercatorInv, ...
            {0, 180/pi} )
        azimuthalEquidistant ( @flatmap.project.azimuthalEquidistant, ...
            @flatmap.project.azimuthalEquidistantInv, ...
            {90, 0, 180/pi} )
    end
    
    properties
        transform function_handle
        inverseTransform function_handle
        defaults cell
    end
    
    methods
        function obj = Projections(transform, inverseTransform, defaults)
            obj.transform = transform;
            obj.inverseTransform = inverseTransform;
            obj.defaults = defaults;
        end
    end
    
end

