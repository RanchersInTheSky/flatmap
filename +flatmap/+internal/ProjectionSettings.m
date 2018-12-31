classdef ProjectionSettings
    
    properties
        projection flatmap.Projections
        parameters cell
    end
    
    methods
        function obj = ProjectionSettings( thisProjection, projectionParameters )
            if nargin == 0
                return
            elseif nargin == 1
                obj.projection = thisProjection;
                obj.parameters = thisProjection.defaults;
            else
                obj.projection = thisProjection;
                obj.parameters = projectionParameters;
            end
        end
    end
end