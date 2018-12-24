classdef UTestMapProjections < matlab.unittest.TestCase
    % UTESTMAPPROJECTIONS - An abstract class to provide common tests
    % against map projection transformations and their inverse
    % transformations.
    %
    % To test a map projection transformation, create a child class of
    % UTESTMAPPROJECTIONS. Specify the test coordinates in the
    % latitude_deg, longitude_deg, rectX and rectY properties. Set the
    % projection and inverseProjection properties to the function handles
    % for the forward and inverse projections, respectively. Set the
    % projectionParameters property to a cell array of any additional
    % inputs for the function handles (the forward & inverse must have the
    % same additional inputs, in the same order). Set the tolerance
    % properties as desired. If no tolerances are set, exact equality will
    % be tested.
    
    properties ( Abstract, TestParameter )
        latitude_deg % cell array of latitudes for test points
        longitude_deg % cell array of longitudes for test points
        rectX % cell array of projection x coords for test points
        rectY % cell array of projection y coords for test points
    end
    
    properties ( Abstract )
        projection % projection transformation function handle
        inverseProjection % inverse projection transformation function handle
        projectionParameters % additional input parameters for both function handles
        
        projAbsTol
        projRelTol
        
        invProjAbsTol
        invProjRelTol
    end
    
    methods ( TestClassSetup )
        function assertProjectionTolerances( testCase )
            isTolSetupCorrect = ( isempty(testCase.projAbsTol) & isempty(testCase.projRelTol) ) ...
                | ( ~isempty(testCase.projAbsTol) & ~isempty(testCase.projRelTol) );
            
            testCase.assertTrue(isTolSetupCorrect, ...
                'Class properties projAbsTol & projRelTol must both be set or empty, not mixed set and empty.');
        end
        
        function assertInverseProjectionTolerances( testCase )
            isTolSetupCorrect = ( isempty(testCase.invProjAbsTol) & isempty(testCase.invProjRelTol) ) ...
                | ( ~isempty(testCase.invProjAbsTol) & ~isempty(testCase.invProjRelTol) );
            
            testCase.assertTrue(isTolSetupCorrect, ...
                'Class properties invProjAbsTol & invProjRelTol must both be set or empty, not mixed set and empty.');
        end
    end
    
    methods ( Test )
        function testProjectionVectorization( testCase )
            import matlab.unittest.constraints.IsEqualTo
            import matlab.unittest.constraints.AbsoluteTolerance
            import matlab.unittest.constraints.RelativeTolerance
            
            % Put all of the parameterizations into arrays and test the
            % projection with vector inputs and outputs.
            allLatitude_deg = [testCase.latitude_deg{:}];
            allLongitude_deg = [testCase.longitude_deg{:}];
            allRectX = [testCase.rectX{:}];
            allRectY = [testCase.rectY{:}];
            
            [ x, y ] = testCase.projection(allLatitude_deg, allLongitude_deg, ...
                testCase.projectionParameters{:} );
            
            % Verify first x
            if abs(allRectX(1)) == Inf
                testCase.verifyEqual(x(1), allRectX(1));
            elseif isnan(allRectX(1))
                testCase.verifyTrue(isnan(x(1)));
            else
                if isempty(testCase.projAbsTol) && isempty(testCase.projRelTol)
                    testCase.verifyEqual(x(1), allRectX(1));
                else
                    testCase.verifyThat(x(1), IsEqualTo(allRectX(1), 'Within', ...
                        AbsoluteTolerance(testCase.projAbsTol) ...
                        & RelativeTolerance(testCase.projRelTol)));
                end
            end
            
            % Verify first y
            if abs(allRectY) == Inf
                testCase.verifyEqual(y(1), allRectY(1));
            elseif isnan(allRectY(1))
                testCase.verifyTrue(isnan(y(1)));
            else
                if isempty(testCase.projAbsTol) && isempty(testCase.projRelTol)
                    testCase.verifyEqual(y(1), allRectY(1));
                else
                    testCase.verifyThat(y(1), IsEqualTo(allRectY(1), 'Within', ...
                        AbsoluteTolerance(testCase.projAbsTol) ...
                        & RelativeTolerance(testCase.projRelTol)));
                end
            end
        end
        
        function testProjectionInverseVectorization( testCase )
            import matlab.unittest.constraints.IsEqualTo
            import matlab.unittest.constraints.AbsoluteTolerance
            import matlab.unittest.constraints.RelativeTolerance
            
            % Put all of the parameterizations into arrays and test the
            % inverse projection with vector inputs and outputs.
            allLatitude_deg = [testCase.latitude_deg{:}];
            allLongitude_deg = [testCase.longitude_deg{:}];
            allRectX = [testCase.rectX{:}];
            allRectY = [testCase.rectY{:}];
            
            [ lat_deg, lon_deg ] = testCase.inverseProjection( allRectX, allRectY, ...
                testCase.projectionParameters{:} );
            
            % Verify first lat_deg
            if isnan(allLatitude_deg(1))
                testCase.verifyTrue(isnan(lat_deg(1)));
            else
                if isempty(testCase.invProjAbsTol) && isempty(testCase.invProjRelTol)
                    testCase.verifyEqual(lat_deg(1), allLatitude_deg(1));
                else
                    testCase.verifyThat(lat_deg(1), IsEqualTo(allLatitude_deg(1), 'Within', ...
                        AbsoluteTolerance(testCase.invProjAbsTol) ...
                        & RelativeTolerance(testCase.invProjRelTol)));
                end
            end
            
            % Verify first lon_deg
            if isnan(allLongitude_deg(1))
                testCase.verifyTrue(isnan(lon_deg(1)));
            else
                if isempty(testCase.invProjAbsTol) && isempty(testCase.invProjRelTol)
                    testCase.verifyEqual(lon_deg(1), allLongitude_deg(1));
                else
                    testCase.verifyThat(lon_deg(1), IsEqualTo(allLongitude_deg(1), 'Within', ...
                        AbsoluteTolerance(testCase.invProjAbsTol) ...
                        & RelativeTolerance(testCase.invProjRelTol)));
                end
            end
        end
    end
    
    methods ( Test, ParameterCombination='sequential' )
        function testProjection( testCase, latitude_deg, longitude_deg, ...
                rectX, rectY )
            import matlab.unittest.constraints.IsEqualTo
            import matlab.unittest.constraints.AbsoluteTolerance
            import matlab.unittest.constraints.RelativeTolerance
            
            [ x, y ] = testCase.projection( latitude_deg, longitude_deg, ...
                testCase.projectionParameters{:} );
            
            % Verify x
            if abs(rectX) == Inf % If expected is infinity, actual must be infinity.
                testCase.verifyEqual(x, rectX);
            elseif isnan(rectX) % If the expected is not-a-number, actual must be not-a-number.
                testCase.verifyTrue(isnan(x));
            else
                if isempty(testCase.projAbsTol) && isempty(testCase.projRelTol)
                    testCase.verifyEqual(x, rectX);
                else
                    testCase.verifyThat(x, IsEqualTo(rectX, 'Within', ...
                        AbsoluteTolerance(testCase.projAbsTol) ...
                        & RelativeTolerance(testCase.projRelTol)));
                end
            end
            
            % Verify y
            if abs(rectY) == Inf % If expected is infinity, actual must be infinity.
                testCase.verifyEqual(y, rectY);
            elseif isnan(rectY) % If the expected is not-a-number, actual must be not-a-number.
                testCase.verifyTrue(isnan(y));
            else
                if isempty(testCase.projAbsTol) && isempty(testCase.projRelTol)
                    testCase.verifyEqual(y, rectY);
                else
                    testCase.verifyThat(y, IsEqualTo(rectY, 'Within', ...
                        AbsoluteTolerance(testCase.projAbsTol) ...
                        & RelativeTolerance(testCase.projRelTol)));
                end
            end
        end
        
        function testProjectionInverse( testCase, latitude_deg, longitude_deg, ...
                rectX, rectY )
            import matlab.unittest.constraints.IsEqualTo
            import matlab.unittest.constraints.AbsoluteTolerance
            import matlab.unittest.constraints.RelativeTolerance
            [ lat_deg, lon_deg ] = testCase.inverseProjection( rectX, rectY, ...
                testCase.projectionParameters{:} );
            
            % Verify lat_deg
            if isnan(latitude_deg) % If the expected is not-a-number, actual must be not-a-number.
                testCase.verifyTrue(isnan(lat_deg));
            else
                if isempty(testCase.invProjAbsTol) && isempty(testCase.invProjRelTol)
                    testCase.verifyEqual(lat_deg, latitude_deg);
                else
                    testCase.verifyThat(lat_deg, IsEqualTo(latitude_deg, 'Within', ...
                        AbsoluteTolerance(testCase.invProjAbsTol) ...
                        & RelativeTolerance(testCase.invProjRelTol)));
                end
            end
            
            % Verify lon_deg
            if isnan(longitude_deg) % If the expected is not-a-number, actual must be not-a-number.
                testCase.verifyTrue(isnan(lon_deg));
            else
                if isempty(testCase.invProjAbsTol) && isempty(testCase.invProjRelTol)
                    testCase.verifyEqual(lon_deg, longitude_deg);
                else
                    testCase.verifyThat(lon_deg, IsEqualTo(longitude_deg, 'Within', ...
                        AbsoluteTolerance(testCase.invProjAbsTol) ...
                        & RelativeTolerance(testCase.invProjRelTol)));
                end
            end
        end
    end
end