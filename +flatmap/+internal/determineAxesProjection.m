function [ axesProjection, axesProjectionParams ] = determineAxesProjection( axesHandle, inputProjection )
    % If the axes do not have a projection set, set it to the
    % 'MapProjection' parameter, or if a 'MapProjection' has been
    % specified, overwrite the axes projection.
    axesProjection = getappdata(axesHandle, 'gaeaFlatmapProjection');
    axesProjectionParams = getappdata(axesHandle, 'gaeaFlatmapProjectionParams');
    if ~isa(axesProjection, 'flatmap.Projections') || ~isempty(inputProjection)
        axesProjection = inputProjection;
        if isempty(inputProjection)
            axesProjectionParams = {};
        else
            axesProjectionParams = axesProjection.defaults;
        end
        setappdata(axesHandle, 'gaeaFlatmapProjection', axesProjection);
    elseif isempty(axesProjectionParams) || ~iscell(axesProjectionParams)
        axesProjectionParams = {};
    end
    setappdata(axesHandle, 'gaeaFlatmapProjectionParams', axesProjectionParams);
end