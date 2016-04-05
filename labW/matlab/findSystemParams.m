function [c1, c2, k, b] = findSystemParams(wo, f)
% solves EOM for 2 disc TDS system
% wo = frequency in rad/sec
% f = frequency to use f1,f2,f3,f4,f5 this is a string used to access
% struct
% example usage: [c1, c2, k, b] = findSystemParams(2*pi*1, 'f1')

% t = time
% bot = bottom encoder position
% mid = middle encoder position
% volt = commanded voltage

% inertia for lower and middle discs
J1 = 0.0128;
J2 = 0.0097;

% read in data
[t, volt, bot, mid] = read();

% find coeffecients for u(t)
[u0, u1a, u1b]  = solveU(wo, volt.(f), t.(f));

% find coeffecients for theta_1(t)
[th_10, w_10, w_11a, w_11b] = solveO(wo, t.(f), bot.(f));

% find coeffecients for theta_2(t)
[th_20, w_20, w_21a, w_21b] = solveO2(wo, t.(f), mid.(f));

% equations to describe model
u = u0 + u1a*cos(wo*t.(f)) + u1b*sin(wo*t.(f));
w1  = w_10 + w_11a*cos(wo*t.(f)) + w_11b*sin(wo*t.(f));
w1D = -w_11a*sin(wo*t.(f)) + w_11b*cos(wo*t.(f));
w2  = w_20 + w_21a*cos(wo*t.(f)) + w_21b*sin(wo*t.(f));
w2D = -w_21a*sin(wo*t.(f)) + w_21b*cos(wo*t.(f));
th1 = th_10 + w_10*t.(f) + w_11a*sin(wo*t.(f))/wo - w_11b*cos(wo*t.(f))/wo;
th2 = th_20 + w_20*t.(f) + w_21a*sin(wo*t.(f))/wo - w_21b*cos(wo*t.(f))/wo;

% least squares solutions
A1 = [w1 (th1 - th2) -u];
b1 = [-J1*w1D];
x1 = A1\b1;

A2 = [w2 (th2 - th1)];
b2 = [-J2*w2D];
x2 = A2\b2;

% return values
c1 = x1(1);
c2 = x2(1);
k  = mean([x1(2) x2(2)]);
b  = x1(3);