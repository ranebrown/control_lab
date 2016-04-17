function [om_20, w_20, w_21a, w_21b] = solveO2(wo, t, mid)
% wo in rad/sec
% solves: omega_2 equation

A = [ones(size(t)), t, sin(wo*t)/wo, -cos(wo*t)/wo];
b = [mid];
x = A\b;
om_20 = x(1);
w_20  = x(2);
w_21a = x(3);
w_21b = x(4);