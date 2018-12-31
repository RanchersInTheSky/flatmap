function [ shapes ] = loadBoundaries( detailLevel )
    switch detailLevel
        case 'c'
            coastlineFile = 'C:\Users\jerem\Documents\MATLAB\gshhg\GSHHS_shp\c\GSHHS_c_L1.shp';
            lakesFile = 'C:\Users\jerem\Documents\MATLAB\gshhg\GSHHS_shp\c\GSHHS_c_L2.shp';
            antarcticaFile = 'C:\Users\jerem\Documents\MATLAB\gshhg\GSHHS_shp\c\GSHHS_c_L5.shp';
            rivers1File = 'C:\Users\jerem\Documents\MATLAB\gshhg\WDBII_shp\c\WDBII_river_c_L01.shp';
            rivers2File = 'C:\Users\jerem\Documents\MATLAB\gshhg\WDBII_shp\c\WDBII_river_c_L02.shp';
            bordersFile = 'C:\Users\jerem\Documents\MATLAB\gshhg\WDBII_shp\c\WDBII_border_c_L1.shp';
        case 'l'
            coastlineFile = 'C:\Users\jerem\Documents\MATLAB\gshhg\GSHHS_shp\l\GSHHS_l_L1.shp';
            lakesFile = 'C:\Users\jerem\Documents\MATLAB\gshhg\GSHHS_shp\l\GSHHS_l_L2.shp';
            antarcticaFile = 'C:\Users\jerem\Documents\MATLAB\gshhg\GSHHS_shp\l\GSHHS_l_L5.shp';
            rivers1File = 'C:\Users\jerem\Documents\MATLAB\gshhg\WDBII_shp\l\WDBII_river_l_L01.shp';
            rivers2File = 'C:\Users\jerem\Documents\MATLAB\gshhg\WDBII_shp\l\WDBII_river_l_L02.shp';
            bordersFile = 'C:\Users\jerem\Documents\MATLAB\gshhg\WDBII_shp\l\WDBII_border_l_L1.shp';
        otherwise
            error('Flatmap:Boundaries:InvalidDetailLevel', ...
                ['Boundary detail level ''' detailLevel ''' is invalid.']);
    end
    
%     shapes = shapefile.load(coastlineFile);
%     shapes(end+1) = shapefile.load(lakesFile);
%     shapes(end+1) = shapefile.load(antarcticaFile);
%     shapes(end+1) = shapefile.load(rivers1File);
%     shapes(end+1) = shapefile.load(rivers2File);
%     shapes(end+1) = shapefile.load(bordersFile);

    thisShapefile = shapefile.load(coastlineFile);
    landShapes = thisShapefile.shapeData;
    
    thisShapefile = shapefile.load(lakesFile);
    waterShapes = thisShapefile.shapeData;
    
%     thisShapefile = shapefile.load(antarcticaFile);
%     landShapes = [landShapes; thisShapefile.shapeData];
%     
%     thisShapefile = shapefile.load(rivers1File);
%     waterShapes = [waterShapes; thisShapefile.shapeData];
%     
%     thisShapefile = shapefile.load(rivers2File);
%     lineShapes = thisShapefile.shapeData;
    
    thisShapefile = shapefile.load(bordersFile);
    lineShapes = thisShapefile.shapeData;
%     lineShapes = [lineShapes; thisShapefile.shapeData];
    
    shapes.land = landShapes;
    shapes.water = waterShapes;
    shapes.lines = lineShapes;
end