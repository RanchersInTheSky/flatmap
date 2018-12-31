function [ inCellArray ] = transformInputsToProjection( inCellArray, axesProjection, skipInterval )
    if nargin < 3
        skipInterval = 2;
    end
    
    if ~isempty(axesProjection.projection)
        ii = 1;
        while ii < numel(inCellArray)
            if isnumeric(inCellArray{ii}) && isnumeric(inCellArray{ii+1})
                [x, y] = axesProjection.projection.transform( ...
                    inCellArray{ii}, ...
                    inCellArray{ii+1}, ...
                    axesProjection.parameters{:} );
                inCellArray{ii} = x;
                inCellArray{ii+1} = y;
                ii = ii + skipInterval;
            else
                ii = ii + 1;
            end
        end
    else
        ii = 1;
        while ii < numel(inCellArray)
            if isnumeric(inCellArray{ii}) && isnumeric(inCellArray{ii+1})
                lat_deg = inCellArray{ii};
                lon_deg = inCellArray{ii+1};
                inCellArray{ii} = lon_deg;
                inCellArray{ii+1} = lat_deg;
                ii = ii + skipInterval;
            else
                ii = ii + 1;
            end
        end
    end
end