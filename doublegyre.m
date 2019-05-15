function v = doublegyre(t,xx,params)

%% Double Gyre System
A = params.A; omega = params.omega; epsilon = params.epsilon;
x = xx(:,1); y = xx(:,2);

a = epsilon*sin(omega*t);
b = 1 - 2*a;
f = a*x.^2 + b*x;
dfdx = 2*a*x + b;

v = pi*A * [-sin(pi*f) .* cos(pi*y), ...
             cos(pi*f) .* sin(pi*y) .* dfdx];
             