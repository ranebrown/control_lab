function [c2, k] = solveParams(accel2, vel2, pos2, pos1, J2)
% solve for unkowns of TDS system with two discs: bottom and middle
% unknowns: k = spring constant, c2 = damping middle disc

J1 = 0.0128; % disc 1 inertia 4 weights 7cm

A = [vel2 (pos2-pos1)];
b = [-J2*accel2];
x = A\b;
c2 = x(1);
k = x(2);