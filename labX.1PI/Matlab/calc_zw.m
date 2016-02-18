function [zeta, wn] = calc_zw(Mp, tr)
% calculates zeta an wn needed for a specific overshoot and rise time

zeta = abs(log(Mp))/sqrt(pi^2+log(Mp)^2);
wn = 1.8/tr;