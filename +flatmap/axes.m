function [ varargout ] = axes( varargin )
    import flatmap.internal.*
    
    % Check for valid number of outputs (0 or 1).
    if nargout <= 1
        varargout = cell(1, nargout);
    else
        error('flatmap:axes:NumOutput', 'flatmap.axes only supports zero or one output');
    end
    
    [ inputProjection, varargin ] = extractMapProjectionFromInputs( varargin );
    
    if ~isempty( varargin ) && ishandle( varargin{1} )
        axes( varargin{:} );
        axesHandle = gca();
    else
        axesHandle = axes( varargin{:} );
    end
    
    determineAxesProjection( axesHandle, inputProjection );
    
    if nargout > 0
        varargout{1} = axesHandle;
    end
end