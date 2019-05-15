function df = diff_y(y,f,nx,ny)

%% rectangular uniform grid
yy = reshape(y,ny,nx); ff = reshape(f,ny,nx);
dy = yy(2,1) - yy(1,1);

%% Approximate df / dx with finite differences
df = (1. / (2.*dy)) * ...
      [2*(ff(2,:)-ff(1,:)); ff(3:ny,:)-ff(1:ny-2,:); 2*(ff(ny,:)-ff(ny-1,:))];
%df = df(:);