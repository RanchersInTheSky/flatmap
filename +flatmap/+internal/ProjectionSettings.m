classdef ProjectionSettings
    
    properties
        projection flatmap.Projections
        parameters cell
        
        mapOn_l = true;
        mapDetail_enum = flatmap.MapDetail.low;
        mapLandColor = [ 1 0.9 0.5 ];
        mapWaterColor = [ 0.9 0.93 1.0 ];
        mapLandHandles matlab.graphics.primitive.Patch
        mapLakeHandles matlab.graphics.primitive.Patch
        mapAreaRiverHandles matlab.graphics.primitive.Patch
        mapBorderHandles matlab.graphics.chart.primitive.Line
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