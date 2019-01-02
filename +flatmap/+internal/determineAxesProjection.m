function [ axesProjection ] = determineAxesProjection( axesHandle, inputProjection )
    % If the axes do not have a projection set, set it to the
    % 'MapProjection' parameter, or if a 'MapProjection' has been
    % specified, overwrite the axes projection.
    import flatmap.internal.*
    
    axesProjection = getappdata(axesHandle, 'gaeaFlatmapProjection');
    if ~isa(axesProjection, 'flatmap.internal.ProjectionSettings') || ~isempty(inputProjection.projection)
        axesProjection = inputProjection;
        
        % Get the original inputs for the axes children.
        axesChildren = axesHandle.Children;
        for ii = 1:numel(axesChildren)
            origInputs(ii) = getappdata(axesChildren(ii), 'gaeaFlatmapOrigInputs');
        end
        axesChildren.delete()
        
        clearWorldMap(axesHandle);
        setappdata(axesHandle, 'gaeaFlatmapProjection', axesProjection);
        
        % Set the Data Cursor update function
        figureHandle = axesHandle.Parent;
        dataCursorHandle = datacursormode(figureHandle);
        dataCursorHandle.UpdateFcn = @flatmap.internal.dataCursorUpdate;
        
        if axesProjection.mapOn_l
            plotWorldMap(axesHandle);
        end
        
        for ii = 1:numel(axesChildren)
            origInputs(ii).function(origInputs(ii).inputArray{:})
        end
    end
end