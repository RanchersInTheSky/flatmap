function [ inputProjection, inputCellArray ] = extractMapProjectionFromInputs( inputCellArray )
    import flatmap.internal.*
    % Find the 'MapProjection' option
    mapProjectionIndex = find(strcmpi('MapProjection', inputCellArray), 1);
    mapProjectionParamsIndex = find(strcmpi('MapProjectionParams', inputCellArray), 1);
    if isempty(mapProjectionIndex)
        inputProjection = ProjectionSettings();
    else
        thisProjection = inputCellArray{mapProjectionIndex+1};
        if ischar(thisProjection)
            try
                thisProjection = ...
                    flatmap.Projections(thisProjection);
            catch err
                if strcmp(err.identifier, 'MATLAB:class:CannotConvert')
                    error('flatmap:InvalidMapProjection', ...
                        ['MapProjection parameter ''' thisProjection ''' is not a supported projection.']);
                else
                    rethrow(err)
                end
            end
        elseif ~isa(thisProjection, 'flatmap.Projections')
            error('flatmap:InvalidMapProjection', ...
                ['''MapProjection'' parameter ''' thisProjection ''' is not a supported projection.']);
        end
        
        if isempty(mapProjectionParamsIndex)
            theseParameters = thisProjection.defaults;
        elseif iscell(inputCellArray{mapProjectionParamsIndex+1})
            theseParameters = inputCellArray{mapProjectionParamsIndex+1};
        else
            error('flatmap:InvalidMapProjectionParams', ...
                '''MapProjectionParams'' must have a value that is a cell array of the projection parameters.'); 
        end
        
        deleteIndices = [mapProjectionIndex mapProjectionIndex+1 mapProjectionParamsIndex mapProjectionParamsIndex+1];
        inputCellArray(deleteIndices) = [];
        
        inputProjection = ProjectionSettings(thisProjection, theseParameters);
    end

end