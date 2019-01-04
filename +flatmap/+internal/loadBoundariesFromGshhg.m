function [ shapes ] = loadBoundariesFromGshhg( detailLevel, gshhgPath )
    switch detailLevel
        case 'crude'
            coastlineFile = fullfile(gshhgPath,'GSHHS_shp','c','GSHHS_c_L1.shp');
            lakesFile = fullfile(gshhgPath,'GSHHS_shp','c','GSHHS_c_L2.shp');
            antarcticaFile = fullfile(gshhgPath,'GSHHS_shp','c','GSHHS_c_L5.shp');
            rivers1File = fullfile(gshhgPath,'WDBII_shp','c','WDBII_river_c_L01.shp');
            bordersFile = fullfile(gshhgPath,'WDBII_shp','i','WDBII_border_i_L1.shp');
        case 'low'
            coastlineFile = fullfile(gshhgPath,'GSHHS_shp','l','GSHHS_l_L1.shp');
            lakesFile = fullfile(gshhgPath,'GSHHS_shp','l','GSHHS_l_L2.shp');
            antarcticaFile = fullfile(gshhgPath,'GSHHS_shp','l','GSHHS_l_L5.shp');
            rivers1File = fullfile(gshhgPath,'WDBII_shp','l','WDBII_river_l_L01.shp');
            bordersFile = fullfile(gshhgPath,'WDBII_shp','h','WDBII_border_h_L1.shp');
        otherwise
            error('Flatmap:Boundaries:InvalidDetailLevel', ...
                ['Boundary detail level ''' detailLevel ''' is invalid.']);
    end

    thisShapefile = shapefile.load(coastlineFile);
    landShapes(numel(thisShapefile.shapeData),1) = struct(thisShapefile.shapeData);
    for ii = 1:numel(thisShapefile.shapeData)
        landShapes(ii) = struct(thisShapefile.shapeData(ii));
        landShapes(ii).shapeType = char(landShapes(ii).shapeType);
        landShapes(ii).partType = char(landShapes(ii).partType);
    end
    
    thisShapefile = shapefile.load(lakesFile);
    lakeShapes(numel(thisShapefile.shapeData),1) = struct(thisShapefile.shapeData);
    for ii = 1:numel(thisShapefile.shapeData)
        lakeShapes(ii) = struct(thisShapefile.shapeData(ii));
        lakeShapes(ii).shapeType = char(lakeShapes(ii).shapeType);
        lakeShapes(ii).partType = char(lakeShapes(ii).partType);
    end
    
    thisShapefile = shapefile.load(antarcticaFile);
    antarcticaShapes(numel(thisShapefile.shapeData),1) = struct(thisShapefile.shapeData);
    for ii = 1:numel(thisShapefile.shapeData)
        antarcticaShapes(ii) = struct(thisShapefile.shapeData(ii));
        antarcticaShapes(ii).shapeType = char(antarcticaShapes(ii).shapeType);
        antarcticaShapes(ii).partType = char(antarcticaShapes(ii).partType);
    end
    
    thisShapefile = shapefile.load(rivers1File);
    areaRiverShapes(numel(thisShapefile.shapeData),1) = struct(thisShapefile.shapeData);
    for ii = 1:numel(thisShapefile.shapeData)
        areaRiverShapes(ii) = struct(thisShapefile.shapeData(ii));
        areaRiverShapes(ii).shapeType = char(areaRiverShapes(ii).shapeType);
        areaRiverShapes(ii).partType = char(areaRiverShapes(ii).partType);
    end
    
    thisShapefile = shapefile.load(bordersFile);
    borderShapes(numel(thisShapefile.shapeData),1) = struct(thisShapefile.shapeData);
    for ii = 1:numel(thisShapefile.shapeData)
        borderShapes(ii) = struct(thisShapefile.shapeData(ii));
        borderShapes(ii).shapeType = char(borderShapes(ii).shapeType);
        borderShapes(ii).partType = char(borderShapes(ii).partType);
    end
    
    shapes.land = landShapes;
    shapes.lakes = lakeShapes;
    shapes.areaRivers = areaRiverShapes;
    shapes.borders = borderShapes;
    shapes.antarctica = antarcticaShapes;
end