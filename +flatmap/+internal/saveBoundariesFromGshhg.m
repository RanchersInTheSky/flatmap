function saveBoundariesFromGshhg( gshhgPath )
    import flatmap.internal.*
    
    curPath = fileparts(which(mfilename));
    crudeBoundaryPath = fullfile(curPath,'gshhg_crude.mat');
    lowBoundaryPath = fullfile(curPath, 'gshhg_low.mat');
    
    boundaryDataCrude = loadBoundariesFromGshhg( 'crude', gshhgPath );
    save(crudeBoundaryPath, 'boundaryDataCrude');
    clear boundaryDataCrude
    
    boundaryDataLow = loadBoundariesFromGshhg( 'low', gshhgPath );
    save(lowBoundaryPath, 'boundaryDataLow');
end