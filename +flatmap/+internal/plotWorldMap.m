function plotWorldMap( axesHandle )
    axesProjection = getappdata(axesHandle, 'gaeaFlatmapProjection');
    landColor = axesProjection.mapLandColor;
    waterColor = axesProjection.mapWaterColor;
    curPath = fileparts(mfilename('fullpath'));
    switch axesProjection.mapDetail_enum
        case flatmap.MapDetail.low
            boundaryPath = fullfile(curPath,'gshhg_crude.mat');
        case flatmap.MapDetail.high
            boundaryPath = fullfile(curPath, 'gshhg_low.mat');
    end
    load(boundaryPath)
    
    % Draw the land elements
    landHandles(numel(boundaryData.land)) = matlab.graphics.primitive.Patch();
    for ii = 1:numel(boundaryData.land)
        landHandles(ii) = flatmap.fill(axesHandle, ...
            boundaryData.land(ii).vertices(:,2), boundaryData.land(ii).vertices(:,1), ...
            landColor);
        if ii == 1
            axesHandle.NextPlot = 'add';
        end
    end
    [landHandles.HandleVisibility] = deal('off');
    [landHandles.PickableParts] = deal('none');
    axesProjection.mapLandHandles = landHandles;
    
    % Draw the border elements
    borderHandles(numel(boundaryData.borders)) = matlab.graphics.primitive.Line();
    for ii = 1:numel(boundaryData.borders)
        borderHandles(ii) =  flatmap.plot(axesHandle, ...
            boundaryData.borders(ii).vertices(:,2), boundaryData.borders(ii).vertices(:,1), ...
            'k');
    end
    [borderHandles.HandleVisibility] = deal('off');
    [borderHandles.PickableParts] = deal('none');
    axesProjection.mapBorderHandles = borderHandles;
    
    % Draw the water elements
    lakeHandles(100) = matlab.graphics.primitive.Patch();
    for ii = 1:100
        lakeHandles(ii) = flatmap.fill(axesHandle, ...
            boundaryData.lakes(ii).vertices(:,2), boundaryData.lakes(ii).vertices(:,1), ...
            waterColor);
    end
    [lakeHandles.HandleVisibility] = deal('off');
    [lakeHandles.PickableParts] = deal('none');
    axesProjection.mapLakeHandles = lakeHandles;
    
    % Draw the area river elements
    areaRiverHandles(numel(boundaryData.areaRivers)) = matlab.graphics.primitive.Patch();
    for ii = 1:numel(boundaryData.areaRivers)
        areaRiverHandles(ii) = flatmap.fill(axesHandle, ...
            boundaryData.areaRivers(ii).vertices(:,2), boundaryData.areaRivers(ii).vertices(:,1), ...
            waterColor);
    end
    [areaRiverHandles.HandleVisibility] = deal('off');
    [areaRiverHandles.PickableParts] = deal('none');
    axesProjection.mapAreaRiverHandles = areaRiverHandles;
    
    axesHandle.Color = waterColor;
    axis equal tight
    axesHandle.NextPlot = 'replacechildren';
    
    setappdata(axesHandle, 'gaeaFlatmapProjection', axesProjection)
end