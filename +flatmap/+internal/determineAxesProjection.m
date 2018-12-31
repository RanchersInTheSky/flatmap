function [ axesProjection ] = determineAxesProjection( axesHandle, inputProjection )
    % If the axes do not have a projection set, set it to the
    % 'MapProjection' parameter, or if a 'MapProjection' has been
    % specified, overwrite the axes projection.
    axesProjection = getappdata(axesHandle, 'gaeaFlatmapProjection');
    if ~isa(axesProjection, 'flatmap.internal.ProjectionSettings') || ~isempty(inputProjection.projection)
        axesProjection = inputProjection;
        setappdata(axesHandle, 'gaeaFlatmapProjection', axesProjection);
    end
end