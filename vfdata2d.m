function v = vfdata2d(t,xx,params,varargin)
% params.fnamelist; % list with filenames
% params.dt % time between snapshots
% params.num_snap_in_mem % snapshots stored in memory
% param.interp  % interpolation method, see interp2
persistent init_flag_ grid_ snapshot_ loaded_snapshots_
persistent t_current_ t_loaded_

% clear persistent vars if keyword is 'clean'
if (nargin == 4 && strcmp(varargin{1},'clean'))
    clear all; return; 
end

% # snapshots loaded in memory
num_snap_in_mem = min(params.num_snap, params.num_snap_in_mem);

% During first call of this function: Load grid and first num_snap_in_mem snapshots
if isempty( init_flag_ )
    % load grid and store grid in mem
    load(params.fnamelist{1});
    grid_.x = x; grid_.y = y; 
    % load # snapshots in mem
    for i = 1:num_snap_in_mem
        load(params.fnamelist{i});
        snapshot_(i).u = u; snapshot_(i).v = v; 
    end
    % Keep track of snaps in mem
    loaded_snapshots_ = zeros(params.num_snap,3);
    loaded_snapshots_(:,1) = [1:params.num_snap]';
    for i = 1:num_snap_in_mem
        % snap #, loaded (bool), index in snapshot_       
        loaded_snapshots_(i,:) = [i 1 i]; 
    end
end

% Get current snapshot index corresponding to time t
%  assume snap #1:t=0, #2:t=dt, #3:t=2*dt, ...
current_index = 1 + abs(t) / params.dt; % t starts at 0
current_index = uint16(current_index);

if loaded_snapshots_(current_index,2) == 1
%         disp('snap loaded')
else
    % load snapshot
    old_index = current_index - num_snap_in_mem;
    snap_index = loaded_snapshots_(old_index,3);
	loaded_snapshots_(old_index,2:3) = [0 0];        
    load(params.fnamelist{current_index});
    % overwrite old snapshot
    snapshot_(snap_index).u = u; snapshot_(snap_index).v = v; 
    % update loaded snap info
    loaded_snapshots_(current_index,:) = [current_index 1 snap_index];
end

% Interpolate velocity field at given (x, y) points
v = [interp2(grid_.x,grid_.y,...
            snapshot_(loaded_snapshots_(current_index,3)).u,...
            xx(:,1),xx(:,2),...
            params.interp,0), ...
    interp2(grid_.x,grid_.y,...
            snapshot_(loaded_snapshots_(current_index,3)).v,...
            xx(:,1),xx(:,2),...
            params.interp,0)]; % outside domain set vals to 0
        
init_flag_ = false;

% t
% current_index
% loaded_snapshots_
end
