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
    landShapes = thisShapefile.shapeData;
    
    thisShapefile = shapefile.load(lakesFile);
    lakeShapes = thisShapefile.shapeData;
    
    thisShapefile = shapefile.load(antarcticaFile);
    antarcticaShapes = thisShapefile.shapeData;
    
    thisShapefile = shapefile.load(rivers1File);
    areaRiverShapes = thisShapefile.shapeData;
    
    thisShapefile = shapefile.load(bordersFile);
    borderShapes = thisShapefile.shapeData;
    
    shapes.land = landShapes;
    shapes.lakes = lakeShapes;
    shapes.areaRivers = areaRiverShapes;
    shapes.borders = borderShapes;
    shapes.antarctica = antarcticaShapes;
end