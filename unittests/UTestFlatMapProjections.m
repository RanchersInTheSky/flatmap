classdef UTestFlatMapProjections < matlab.unittest.TestCase
    
    properties ( TestParameter )
        latitude_deg = {0, 0, 0, 0, 90, -90};
        longitude_deg = {-180, -90, 0, 90, 0, 0};
        xMercator = {-180, -90, 0, 90, 0, 0};
        yMercator = {0, 0, 0, 0, Inf, -Inf};
    end
    
    methods ( Test, ParameterCombination='sequential' )
        function testGeo2Mercator(testCase, latitude_deg, longitude_deg, ...
                xMercator, yMercator)
            longitudeZero = 0;
            radius = 180/pi;
            
            [x, y] = flatmap.project.geo2mercator(latitude_deg, longitude_deg, ...
                longitudeZero, radius);
            
            testCase.verifyEqual(x, xMercator);
            testCase.verifyEqual(y, yMercator);
        end
        
        function testMercator2Geo(testCase, latitude_deg, longitude_deg, ...
                xMercator, yMercator)
            longitudeZero = 0;
            radius = 180/pi;
            
            [lat, lon] = flatmap.project.mercator2geo(xMercator, yMercator, ...
                longitudeZero, radius);
            
            testCase.verifyEqual(lat, latitude_deg);
            testCase.verifyEqual(lon, longitude_deg);
        end
    end
    
end

