function [ outputText ] = dataCursorUpdate( obj, eventObj )
    pos = get(eventObj, 'Position');
    target = get(eventObj, 'Target');
    axesHandle = target.Parent;
    axesProjection = getappdata(axesHandle, 'gaeaFlatmapProjection');
    if ~isempty(axesProjection)
        [lat_deg, lon_deg] = axesProjection.projection.inverseTransform( ...
            pos(1), pos(2), axesProjection.parameters{:} );
    else
        lat_deg = pos(1);
        lon_deg = pos(2);
    end
    
    outputText = { ['Lat: ' num2str(lat_deg,4) ' deg'], ...
        ['Lon: ' num2str(lon_deg,4) ' deg'] };
end