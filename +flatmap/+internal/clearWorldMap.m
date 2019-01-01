function clearWorldMap( axesHandle )
    axesProjection = getappdata(axesHandle, 'gaeaFlatmapProjection');
    
    if ~isempty(axesProjection)
        if ~isempty(axesProjection.mapLandHandles)
        axesProjection.mapLandHandles.delete();
        axesProjection.mapLandHandles = matlab.graphics.primitive.Patch.empty();
        end
        
        if ~isempty(axesProjection.mapLakeHandles)
        axesProjection.mapLakeHandles.delete();
        axesProjection.mapLakeHandles = matlab.graphics.primitive.Patch.empty();
        end
        
        if ~isempty(axesProjection.mapAreaRiverHandles)
        axesProjection.mapAreaRiverHandles.delete();
        axesProjection.mapAreaRiverHandles = matlab.graphics.primitive.Patch.empty();
        end
        
        if ~isempty(axesProjection.mapBorderHandles)
        axesProjection.mapBorderHandles.delete();
        axesProjection.mapBorderHandles = matlab.graphics.chart.primitive.Line.empty();
        end
        
        setappdata(axesHandle, 'gaeaFlatmapProjection', axesProjection)
    end
end