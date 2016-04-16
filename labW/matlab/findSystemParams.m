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
w1  = w_10 + w_11a*wo*cos(wo*t.(f)) + w_11b*wo*sin(wo*t.(f));
w1D = -w_11a*sin(wo*t.(f)) + w_11b*cos(wo*t.(f));
w2  = w_20 + w_21a*cos(wo*t.(f)) + w_21b*sin(wo*t.(f));
w2D = -w_21a*sin(wo*t.(f)) + w_21b*cos(wo*t.(f));
th1 = th_10 + w_10*t.(f) + w_11a*sin(wo*t.(f))/wo - w_11b*cos(wo*t.(f))/wo;
th2 = th_20 + w_20*t.(f) + w_21a*sin(wo*t.(f))/wo - w_21b*cos(wo*t.(f))/wo;

% calculate beta
A3 = [cos(wo*t.(f)) sin(wo*t.(f))];
b3 = [th1 - th2];
x3 = A3 \ b3;
be1a = x3(1);
be1b = x3(2);

% calculate unknowns
A4 = [-u1a be1a w_11a 0; -u1b be1b w_11b 0; 0 -be1a 0 w_21a; 0 -be1b 0 w_21b];
b4 = [-J1*w_11b*wo; J1*w_11a*wo; -J2*w_21b*wo; J2*w_21a*wo];
x4 = A4 \ b4;

% return values
b = x4(1);
k = x4(2);
c1 = x4(3);
c2 = x4(4);




