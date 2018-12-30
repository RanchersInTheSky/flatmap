function [ inputProjection, inputCellArray ] = extractMapProjectionFromInputs( inputCellArray )
    % Find the 'MapProjection' option
    mapProjectionIndex = find(strcmpi('MapProjection', inputCellArray), 1);
    if isempty(mapProjectionIndex)
        inputProjection = flatmap.Projections.empty();
    else
        inputProjection = inputCellArray{mapProjectionIndex+1};
        if ischar(inputProjection)
            try
                inputProjection = flatmap.Projections(inputProjection);
            catch err
                if strcmp(err.identifier, 'MATLAB:class:CannotConvert')
                    error('flatmap:InvalidMapProjection', ...
                        ['MapProjection parameter ''' inputProjection ''' is not a supported projection.']);
                else
                    rethrow(err)
                end
            end
        elseif ~isa(inputProjection, 'flatmap.Projections')
            error('flatmap:InvalidMapProjection', ...
                ['MapProjection parameter ''' inputProjection ''' is not a supported projection.']);
        end
        
        inputCellArray([mapProjectionIndex mapProjectionIndex+1]) = [];
    end

end