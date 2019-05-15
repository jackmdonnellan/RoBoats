close all; clear all; clc

%% set parameters
ny = 128;
nx = ny * 2;
params.A = 1; params.epsilon = 0.2; params.omega = 2*pi/10;

%% set x and y matricies
for ii = 1:ny
    x_mat(ii,:) = linspace(0,2,nx);
end
for ii = 1:nx
    y_mat(:,ii) = linspace(1,0,ny)';
end

x = linspace(0,2,nx); y = linspace(1,0,ny);
[xx,yy] = meshgrid(x,y);
X0 = [xx(:) yy(:)];

for t = 0:0.05:60
    loop = round(t/0.05)+1;
    vel = doublegyre(t,X0,params);
    u_mat(:,:,loop) = reshape(vel(:,1),ny,nx);
    v_mat(:,:,loop) = reshape(vel(:,2),ny,nx);
end

%% Saving
mkdir('dg_data')
cd('dg_data')
for ii = 1:9
    str = strcat('dg_000',int2str(ii),'.mat');
    obj = matfile(str,'Writable',true);
    obj.x = x_mat;
    obj.y = y_mat;
    obj.u = u_mat(:,:,ii);
    obj.v = v_mat(:,:,ii);
end
for ii = 10:99
    str = strcat('dg_00',int2str(ii),'.mat');
    obj = matfile(str,'Writable',true);
    obj.x = x_mat;
    obj.y = y_mat;
    obj.u = u_mat(:,:,ii);
    obj.v = v_mat(:,:,ii);
end
for ii = 100:999
    str = strcat('dg_0',int2str(ii),'.mat');
    obj = matfile(str,'Writable',true);
    obj.x = x_mat;
    obj.y = y_mat;
    obj.u = u_mat(:,:,ii);
    obj.v = v_mat(:,:,ii);
end
for ii = 1000:loop
    str = strcat('dg_',int2str(ii),'.mat');
    obj = matfile(str,'Writable',true);
    obj.x = x_mat;
    obj.y = y_mat;
    obj.u = u_mat(:,:,ii);
    obj.v = v_mat(:,:,ii);
end

