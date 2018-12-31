function [ axesProjection ] = determineAxesProjection( axesHandle, inputProjection )
    % If the axes do not have a projection set, set it to the
    % 'MapProjection' parameter, or if a 'MapProjection' has been
    % specified, overwrite the axes projection.
    import flatmap.internal.*
    
    axesProjection = getappdata(axesHandle, 'gaeaFlatmapProjection');
    if ~isa(axesProjection, 'flatmap.internal.ProjectionSettings') || ~isempty(inputProjection.projection)
        axesProjection = inputProjection;
        cla(axesHandle, 'reset');
        setappdata(axesHandle, 'gaeaFlatmapProjection', axesProjection);
        
        if axesProjection.mapOn_l
            plotWorldMap(axesHandle);
        end
    end
end