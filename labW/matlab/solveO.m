function [om_10, w_10, w_11a, w_11b] = solveO(wo, t, bot)
% wo in rad/sec
% solves: omega_1 = omega_0 + w_10*t + w_11a*(sin(wo*t))/wo -
% w_11b*((cos(wo*t))/wo)

A = [ones(size(t)), t, sin(wo*t)/wo, cos(wo*t)/wo];
b = [bot];
x = A\b;
om_10 = x(1);
w_10  = x(2);
w_11a = x(3);
w_11b = x(4);

% plot collected vs fitted position
%   plot(t.f1, bot.f1, t.f1, (om_10+w_10*t.f1+w_11a*sin(2*pi*t.f1)/(2*pi) - w_11b*cos(2*pi*t.f1)/(2*pi)))