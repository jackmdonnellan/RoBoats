function v = stable_doublegyre(xx,params)

%% Stable Double Gyre System
A = params.A; %omega = params.omega; epsilon = params.epsilon;
x = xx(:,1); y = xx(:,2);

% a = epsilon*sin(omega*t);
% b = 1 - 2*a;
% f = a*x.^2 + b*x;
% dfdx = 2*a*x + b;

v = A * pi * [-sin(pi*x) .* cos(pi*y), ...
             cos(pi*x) .* sin(pi*y)];
             