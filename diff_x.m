function df = diff_x(x,f,nx,ny)

%% rectangular uniform grid
xx = reshape(x,ny,nx); ff = reshape(f,ny,nx);
dx = xx(1,2) - xx(1,1);

%% Approximate df / dx with finite differences
df = (1. / (2.*dx)) * ...
  [2*(ff(:,2)-ff(:,1)), ff(:,3:nx)-ff(:,1:nx-2), 2*(ff(:,nx)-ff(:,nx-1))];
%df = df(:);