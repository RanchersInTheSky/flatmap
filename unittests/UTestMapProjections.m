classdef UTestMapProjections < matlab.unittest.TestCase
    
    properties ( Abstract, TestParameter )
        latitude_deg
        longitude_deg
        rectX
        rectY
    end
    
    properties ( Abstract )
        projection
        inverseProjection
        projectionParameters
        
        projAbsTol
        projRelTol
        
        geodAbsTol
        geodRelTol
    end
    
    methods ( Test )
        function testProjectionVectorization( testCase )
            allLatitude_deg = [testCase.latitude_deg{:}];
            allLongitude_deg = [testCase.longitude_deg{:}];
            allRectX = [testCase.rectX{:}];
            allRectY = [testCase.rectY{:}];
            
            [ x, y ] = testCase.projection(allLatitude_deg, allLongitude_deg, ...
                testCase.projectionParameters{:} );
            
            % Verify x
            if abs(allRectX(1)) == Inf
                testCase.verifyEqual(x(1), allRectX(1));
            elseif isnan(allRectX(1))
                testCase.verifyTrue(isnan(x(1)));
            else
                if ~isempty(testCase.projAbsTol)
                    testCase.verifyLessThan(abs(x(1)-allRectX(1)), testCase.projAbsTol);
                end
                
                if ~isempty(testCase.projRelTol)
                    testCase.verifyLessThan(abs(x(1)-allRectX(1))/allRectX(1), testCase.projRelTol);
                end
                
                if isempty(testCase.projAbsTol) && isempty(testCase.projRelTol)
                    testCase.verifyEqual(x(1), allRectX(1));
                end
            end
            
            % Verify y
            if abs(allRectY) == Inf
                testCase.verifyEqual(y(1), allRectY(1));
            elseif isnan(allRectY(1))
                testCase.verifyTrue(isnan(y(1)));
            else
                if ~isempty(testCase.projAbsTol)
                    testCase.verifyLessThan(abs(y(1)-allRectY(1)), testCase.projAbsTol);
                end
                
                if ~isempty(testCase.projRelTol)
                    testCase.verifyLessThan(abs(y(1)-allRectY(1))/allRectY(1), testCase.projRelTol);
                end
                
                if isempty(testCase.projAbsTol) && isempty(testCase.projRelTol)
                    testCase.verifyEqual(y(1), allRectY(1));
                end
            end
        end
        
        function testProjectionInverseVectorization( testCase )
            allLatitude_deg = [testCase.latitude_deg{:}];
            allLongitude_deg = [testCase.longitude_deg{:}];
            allRectX = [testCase.rectX{:}];
            allRectY = [testCase.rectY{:}];
            
            [ lat_deg, lon_deg ] = testCase.inverseProjection( allRectX, allRectY, ...
                testCase.projectionParameters{:} );
            
            % Verify lat_deg
            if isnan(allLatitude_deg(1))
                testCase.verifyTrue(isnan(lat_deg(1)));
            else
                if ~isempty(testCase.geodAbsTol)
                    testCase.verifyLessThan(abs(lat_deg(1)-allLatitude_deg(1)), testCase.geodAbsTol);
                end
                
                if ~isempty(testCase.geodRelTol)
                    testCase.verifyLessThan(abs(lat_deg(1)-allLatitude_deg(1))/allLatitude_deg(1), testCase.geodRelTol);
                end
                
                if isempty(testCase.geodAbsTol) && isempty(testCase.geodRelTol)
                    testCase.verifyEqual(lat_deg(1), allLatitude_deg(1));
                end
            end
            
            % Verify lon_deg
            if isnan(allLongitude_deg(1))
                testCase.verifyTrue(isnan(lon_deg(1)));
            else
                if ~isempty(testCase.geodAbsTol)
                    testCase.verifyLessThan(abs(lon_deg(1)-allLongitude_deg(1)), testCase.geodAbsTol);
                end
                
                if ~isempty(testCase.geodRelTol)
                    testCase.verifyLessThan(abs(lon_deg(1)-allLongitude_deg(1))/allLongitude_deg(1), testCase.geodRelTol);
                end
                
                if isempty(testCase.geodAbsTol) && isempty(testCase.geodRelTol)
                    testCase.verifyEqual(lon_deg(1), allLongitude_deg(1));
                end
            end
        end
    end
    
    methods ( Test, ParameterCombination='sequential' )
        function testProjection( testCase, latitude_deg, longitude_deg, ...
                rectX, rectY )
            [ x, y ] = testCase.projection( latitude_deg, longitude_deg, ...
                testCase.projectionParameters{:} );
            
            % Verify x
            if abs(rectX) == Inf
                testCase.verifyEqual(x, rectX);
            elseif isnan(rectX)
                testCase.verifyTrue(isnan(x));
            else
                if ~isempty(testCase.projAbsTol)
                    testCase.verifyLessThan(abs(x-rectX), testCase.projAbsTol);
                end
                
                if ~isempty(testCase.projRelTol)
                    testCase.verifyLessThan(abs(x-rectX)/rectX, testCase.projRelTol);
                end
                
                if isempty(testCase.projAbsTol) && isempty(testCase.projRelTol)
                    testCase.verifyEqual(x, rectX);
                end
            end
            
            % Verify y
            if abs(rectY) == Inf
                testCase.verifyEqual(y, rectY);
            elseif isnan(rectY)
                testCase.verifyTrue(isnan(y));
            else
                if ~isempty(testCase.projAbsTol)
                    testCase.verifyLessThan(abs(y-rectY), testCase.projAbsTol);
                end
                
                if ~isempty(testCase.projRelTol)
                    testCase.verifyLessThan(abs(y-rectY)/rectY, testCase.projRelTol);
                end
                
                if isempty(testCase.projAbsTol) && isempty(testCase.projRelTol)
                    testCase.verifyEqual(y, rectY);
                end
            end
        end
        
        function testProjectionInverse( testCase, latitude_deg, longitude_deg, ...
                rectX, rectY )
            [ lat_deg, lon_deg ] = testCase.inverseProjection( rectX, rectY, ...
                testCase.projectionParameters{:} );
            
            % Verify lat_deg
            if isnan(latitude_deg)
                testCase.verifyTrue(isnan(lat_deg));
            else
                if ~isempty(testCase.geodAbsTol)
                    testCase.verifyLessThan(abs(lat_deg-latitude_deg), testCase.geodAbsTol);
                end
                
                if ~isempty(testCase.geodRelTol)
                    testCase.verifyLessThan(abs(lat_deg-latitude_deg)/latitude_deg, testCase.geodRelTol);
                end
                
                if isempty(testCase.geodAbsTol) && isempty(testCase.geodRelTol)
                    testCase.verifyEqual(lat_deg, latitude_deg);
                end
            end
            
            % Verify lon_deg
            if isnan(longitude_deg)
                testCase.verifyTrue(isnan(lon_deg));
            else
                if ~isempty(testCase.geodAbsTol)
                    testCase.verifyLessThan(abs(lon_deg-longitude_deg), testCase.geodAbsTol);
                end
                
                if ~isempty(testCase.geodRelTol)
                    testCase.verifyLessThan(abs(lon_deg-longitude_deg)/longitude_deg, testCase.geodRelTol);
                end
                
                if isempty(testCase.geodAbsTol) && isempty(testCase.geodRelTol)
                    testCase.verifyEqual(lon_deg, longitude_deg);
                end
            end
        end
    end
end