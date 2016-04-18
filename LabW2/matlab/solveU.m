function [u0, u1a, u1b]  = solveU(wo, volt, t)

% solve: u(t) = u_0 + u_1a*cos(wo*t)+u1b*sin(wo*t)

A = [ones(size(t)) cos(wo*t) sin(wo*t)];
b = [volt];
x = A\b;
u0 = x(1);
u1a = x(2);
u1b = x(3);

% plot to compare calculated values to actual
% plot(t.f1, [ volt.f1, u0+u1a*cos(2*pi*1*t.f1)+u1b*sin(2*pi*1*t.f1)]),grid on,zoom on