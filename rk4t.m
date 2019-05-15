function X = rk4t(v,X,h,n,tstart)

% RK4T   Runge-Kutta scheme of order 4 
%   performs n steps of the scheme for the vector field v
%   using stepsize h on each row of the matrix X
%   v maps an (m x d)-matrix to an (m x d)-matrix, where
%   m is the number of grid points and d the dimension

% tstart:h:tstart+(n-1)*h
for t=tstart:h:tstart+(n-1)*h
    k1 = v(t, X); 
    k2 = v(t+h/2, X + h/2*k1);
    k3 = v(t+h/2, X + h/2*k2);
    k4 = v(t+h, X + h*k3);
    X = X + h*(k1 + 2*k2 + 2*k3 + k4)/6;
end
