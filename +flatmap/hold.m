function hold( varargin )
    if nargin == 0
        axesHandle = gca;
        holdSwitch = '';
    elseif nargin == 1
        if any(ishandle(varargin{1})) && isscalar(varargin{1}) ...
                && strcmp(get(varargin{1}, 'Type'), 'axes')
            axesHandle = varargin{1};
            holdSwitch = '';
        elseif ischar(varargin{1})
            axesHandle = gca;
            holdSwitch = varargin{1};
        else
            error( 'Flatmap:InvalidInput', ...
                'A single input for flatmap.hold must be an axes handle or the string ''on'' or ''off''.');
        end
    elseif nargin == 2
        if any(ishandle(varargin{1})) && isscalar(varargin{1}) ...
                && strcmp(get(varargin{1}, 'Type'), 'axes') ...
                && ischar(varargin{2})
            axesHandle = varargin{1};
            holdSwitch = varargin{2};
        else
            error( 'Flatmap:InvalidInput', ...
                'With 2 inputs to flatmap.hold, the first must be an axes handle and the second must be the string ''on'' or ''off''.');
        end
    else
        error( 'Flatmap:InvalidInput', ...
            'flatmap.hold supports 0, 1 or 2 inputs.');
        
    end
    
    switch holdSwitch
        case 'on'
            axesHandle.NextPlot = 'add';
        case 'off'
            axesHandle.NextPlot = 'replacechildren';
        case ''
            if strcmp(axesHandle.NextPlot, 'add')
                axesHandle.NextPlot = 'replacechildren';
            else
                axesHandle.NextPlot = 'add';
            end
        otherwise
            error( 'Flatmap:InvalidInput', ...
                'A character array input for flatmap.hold must be the string ''on'' or ''off''.');
            
    end
end