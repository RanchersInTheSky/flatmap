function saveBoundariesFromGshhg( gshhgPath )
    import flatmap.internal.*
    
    curPath = fileparts(which(mfilename));
    crudeBoundaryPath = fullfile(curPath,'gshhg_crude.mat');
    lowBoundaryPath = fullfile(curPath, 'gshhg_low.mat');
    
    boundaryData = loadBoundariesFromGshhg( 'crude', gshhgPath );
    save(crudeBoundaryPath, 'boundaryData');
    
    boundaryData = loadBoundariesFromGshhg( 'low', gshhgPath );
    save(lowBoundaryPath, 'boundaryData');
end