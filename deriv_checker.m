close all; clear all; clc
%% Kernel Definition
filterwidth = 1; fitwidth = 3; % parameters for the differentiation kernel
Av = 1.0/(0.5*filterwidth^2 * ...
    (sqrt(pi)*filterwidth*erf(fitwidth/filterwidth) - ...
    2*fitwidth*exp(-fitwidth^2/filterwidth^2)));
vkernel = -fitwidth:fitwidth;
vkernel = Av.*vkernel.*exp(-vkernel.^2./filterwidth^2);
%% Sin Curve
t = 0:1:400*pi;
x = sin(t);
u = -conv(x,vkernel,'valid');

figure
title('Sinusoidal Motion-Position and Velocity')
plot(t,x)
hold on
plot(t(1:length(u)),u)
legend('Position','Velocity')

figure
title('Sinusoidal Motion- Velocity')
plot(t(1:length(u)),u)
legend('Velocity')

%% Linear Motion
y = 2*t;
v = -conv(y,vkernel,'valid');

figure
title('Linear Motion-Position and Velocity')
plot(t,y)
hold on
plot(t(1:length(v)),v)
legend('Position','Velocity')

figure
title('Linear Motion-Velocity')
plot(t(1:length(v)),v)
legend('Velocity')