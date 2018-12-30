function [ inCellArray ] = transformInputsToProjection( inCellArray, axesProjection, axesProjectionParams, skipInterval )
    if nargin < 4
        skipInterval = 2;
    end
    
    if ~isempty(axesProjection)
        ii = 1;
        while ii < numel(inCellArray)
            if isnumeric(inCellArray{ii}) && isnumeric(inCellArray{ii+1})
                [x, y] = axesProjection.transform( inCellArray{ii}, inCellArray{ii+1}, ...
                    axesProjectionParams{:} );
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