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
    
    for ii = 1:numel(boundaryData.land)
        flatmap.fill(axesHandle, ...
            boundaryData.land(ii).vertices(:,2), boundaryData.land(ii).vertices(:,1), ...
            landColor);
        if ii == 1
            hold on
        end
    end
    
    for ii = 1:100
        flatmap.fill(axesHandle, ...
            boundaryData.lakes(ii).vertices(:,2), boundaryData.lakes(ii).vertices(:,1), ...
            waterColor);
    end
    
    for ii = 1:numel(boundaryData.areaRivers)
        flatmap.fill(axesHandle, ...
            boundaryData.areaRivers(ii).vertices(:,2), boundaryData.areaRivers(ii).vertices(:,1), ...
            waterColor);
    end
    
    for ii = 1:numel(boundaryData.borders)
        flatmap.plot(axesHandle, ...
            boundaryData.borders(ii).vertices(:,2), boundaryData.borders(ii).vertices(:,1), ...
            'k');
    end
    
    axesHandle.Color = waterColor;
    axis equal tight
end