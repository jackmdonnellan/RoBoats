%% File info, Parameters
dname = './mat_data/';
fname = 'cir_';
frame_indicies = [1 1051];
params.dt = 1/15; % note for rk4 dt -> dt/2 since rk uses half time step
params.num_snap_in_mem = 500;
params.interp = 'cubic';
integ_time = 7;
% dx = 4; % spacing grid particle
data_title = 'cir';
vid = VideoWriter('LCS_7s.mp4');
vid.FrameRate = 15;
open(vid)
for ii = 1:1:round(30./params.dt)+1
    vfdata2d(0,0,0,'clean')
    start_index = ii;
    final_index =  start_index + round(integ_time/params.dt);
    %% Snapshop list
    params.fnamelist = write_fnamelist(dname, fname, start_index, final_index);
    params.num_snap = length(params.fnamelist);

    %% Set up grid with particles (only 2 dimensions)
    load(params.fnamelist{1}); clear u v;
    %xx = test_x; yy = test_y;
    xx = x; yy = y;
    % dy = dx;
    % [xx yy] = meshgrid([min(min(x)):dx:max(max(x))], [min(min(y)):dy:max(max(y))]);
    [ny, nx] = size(xx);
    X0 = [xx(:), yy(:)];
    
    %% Integrate particles for specified time
    disp(['Integration interval: [0, ', num2str((params.num_snap-1)*params.dt),']'])
    h = 2*params.dt; % rk4 uses half time steps 
    n = floor((params.num_snap-1) / 2);
    t0 = 0; 
    Xe = rk4t(@(t,x) vfdata2d(t,x,params),X0,h,n,t0);

    %% Compute FTLE field
    T = n*h;
    lambda = ftle(X0,Xe,nx,ny,T);

    %% Plot FTLE field
    figure, pcolor(xx,yy,lambda), shading flat, colorbar
    title(['Forward FTLE field -- ', data_title])
    axis('equal')
    caxis([0 0.3])
    set(gca,'nextplot','replacechildren'); 
    %make mp4
    frame = getframe(gcf);
    writeVideo(vid,frame);
end
close(vid)
close all
% figure, pcolor(xx,yy,lambda), shading interp, colorbar
% title(['Forward FTLE field -- ', data_title])
% axis('equal')



