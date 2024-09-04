function rec = inverse(object, time, medium, sensor, sensor_data)
%INVERSE     reconstructs object from sensor_data.
%
% DESCRIPTION:
%       
%
% USAGE:
%       rec = inverse(object, time, medium, sensor, sensor_data)

% INPUTS:
%       object          -
%       time            -
%       medium          -
%       sensor          -
%       sensor_data     -
%
% OUTPUTS:
%       rec     - 
%
% ABOUT:
%       author          - Manojit Pramanik
%       date            - 25th Aug 2012
%       last update     - 25th Aug 2012
%     

dx = object.x/object.Nx;              % grid point spacing in the x direction [m]
dy = object.y/object.Ny;              % grid point spacing in the y direction [m]
kgrid_rec = makeGrid(object.Nx, dx, object.Ny, dy);

% reset the initial pressure
source.p0 = 0;

kgrid_rec.t_array=0:1:time.length-1;
kgrid_rec.t_array=kgrid_rec.t_array*time.dt;

% set the input options
input_args = {'Smooth', false, 'PMLInside', false, 'PlotPML', false};

% assign the time reversal data
sensor.time_reversal_boundary_data = sensor_data;

% run the simulation
rec = kspaceFirstOrder2D(kgrid_rec, medium, source, sensor, input_args{:});
