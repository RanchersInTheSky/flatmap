function [ varargout ] = plot( varargin )
    % Check for valid number of outputs (0 or 1).
    if nargout <= 1
        varargout = cell(1, nargout);
    else
        error('flatmap.plot:NumOutput', 'flatmap.plot only supports zero or one output');
    end

    % Check if first argument is an axes handle
    if isscalar(varargin{1}) && ishandle(varargin{1})
        axesHandle = varargin{1};
        varargin = varargin(2:end);
    else
        axesHandle = gca;
    end
    
    % Find the 'MapProjection' option
    mapProjectionIndex = find(strcmpi('MapProjection', varargin), 1);
    if isempty(mapProjectionIndex)
        inputProjection = flatmap.Projections.empty();
    else
        inputProjection = varargin{mapProjectionIndex+1};
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
        
        varargin([mapProjectionIndex mapProjectionIndex+1]) = [];
    end
    
    % If the axes do not have a projection set, set it to the
    % 'MapProjection' parameter, or if a 'MapProjection' has been
    % specified, overwrite the axes projection.
    axesProjection = getappdata(axesHandle, 'gaeaFlatmapProjection');
    axesProjectionParams = getappdata(axesHandle, 'gaeaFlatmapProjectionParams');
    if ~isa(axesProjection, 'flatmap.Projections') || ~isempty(inputProjection)
        axesProjection = inputProjection;
        axesProjectionParams = axesProjection.defaults;
        setappdata(axesHandle, 'gaeaFlatmapProjection', axesProjection);
    elseif isempty(axesProjectionParams) || ~iscell(axesProjectionParams)
        axesProjectionParams = {};
    end
    setappdata(axesHandle, 'gaeaFlatmapProjectionParams', axesProjectionParams);

    % Transfor latitude and longitude data
    if ~isempty(axesProjection)
        for ii = 1:numel(varargin)-1
            if isnumeric(varargin{ii}) && isnumeric(varargin{ii+1})
                [x, y] = axesProjection.transform( varargin{ii}, varargin{ii+1}, ...
                    axesProjectionParams{:} );
                varargin{ii} = x;
                varargin{ii+1} = y;
            end
        end
    else
        for ii = 1:numel(varargin)-1
            if isnumeric(varargin{ii}) && isnumeric(varargin{ii+1})
                lat_deg = varargin{ii};
                lon_deg = varargin{ii+1};
                varargin{ii} = lon_deg;
                varargin{ii+1} = lat_deg;
            end
        end
    end
    
    % plot to axes
    if nargout > 0
        varargout{1} = plot(axesHandle, varargin{:});
    else
        plot(axesHandle, varargin{:});
    end
end

