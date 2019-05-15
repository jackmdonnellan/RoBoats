x = 0:.01:2;
y = 0:.01:1;
A = 1;

v = A * pi * [-sin(pi*X0(:,1)) .* cos(pi*X0(:,2)), ...
             cos(pi*X0(:,1)) .* sin(pi*X0(:,2))];

figure      
quiver(X0(:,1),X0(:,2),v(:,1),v(:,2))