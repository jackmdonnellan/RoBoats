function lambda = ftle(X0,Xe,nx,ny,T)


%% Approximate flow map Jacobian dphi_i / dx_j with finite differences
dphi1dx1 = diff_x(X0(:,1),Xe(:,1),nx,ny);
dphi1dx2 = diff_y(X0(:,2),Xe(:,1),nx,ny);
dphi2dx1 = diff_x(X0(:,1),Xe(:,2),nx,ny);
dphi2dx2 = diff_y(X0(:,2),Xe(:,2),nx,ny);


%% Compute FTLE field from approximate Jacobian  
lambda = zeros(ny,nx);
J = zeros(2,2);
for ix = 1:nx
  for iy = 1:ny
      lambda(iy,ix) = (1/abs(T)) * log(max(svd(...
        [dphi1dx1(iy,ix), dphi1dx2(iy,ix); ...
         dphi2dx1(iy,ix), dphi2dx2(iy,ix)])));

%       J = [dphi1dx1(iy,ix), dphi1dx2(iy,ix); ...
%            dphi2dx1(iy,ix), dphi2dx2(iy,ix)];
%       lambda(iy,ix) = (1/(2*abs(T))) * log(max(eig(J' * J)));
%      
  end
end

