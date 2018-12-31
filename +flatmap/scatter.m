function [ varargout ] = scatter( varargin )
    import flatmap.internal.*
    
    % Check for valid number of outputs (0 or 1).
    if nargout <= 1
        varargout = cell(1, nargout);
    else
        error('flatmap:plot:NumOutput', 'flatmap.plot only supports zero or one output');
    end

    % Check if first argument is an axes handle
    if isscalar(varargin{1}) && ishandle(varargin{1})
        axesHandle = varargin{1};
        varargin = varargin(2:end);
    else
        axesHandle = gca();
    end
    
    [ inputProjection, varargin ] = extractMapProjectionFromInputs( varargin );
    
    axesProjection = determineAxesProjection( axesHandle, inputProjection );

    % Transform latitude and longitude data
    varargin = transformInputsToProjection( ...
        varargin, axesProjection, 4 );
    
    % plot to axes
    if nargout > 0
        varargout{1} = scatter(axesHandle, varargin{:});
    else
        scatter(axesHandle, varargin{:});
    end
end
