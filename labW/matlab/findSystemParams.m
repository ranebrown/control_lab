function [c1, c2, k, b] = findSystemParams()
% solves EOM for 2 disc TDS system
% wo = frequency in rad/sec
% t = time
% bot = bottom encoder position
% mid = middle encoder position
% volt = commanded voltage

% inertia for lower and middle discs
J1 = 0.0128;
J2 = 0.0097;

% frequency
wo = 2*pi;

% read in data
[t, volt, bot, mid] = read();

% find coeffecients for u(t)
[u0, u1a, u1b]  = solveU(wo, volt.f1, t.f1);

% find coeffecients for theta_1(t)
[th_10, w_10, w_11a, w_11b] = solveO(wo, t.f1, bot.f1);

% find coeffecients for theta_2(t)
[th_20, w_20, w_21a, w_21b] = solveO2(wo, t.f1, mid.f1);

% equations to describe model
u = u0 + u1a*cos(wo*t.f1) + u1b*sin(wo*t.f1);
w1  = w_10 + w_11a*cos(wo*t.f1) + w_11b*sin(wo*t.f1);
w1D = -w_11a*sin(wo*t.f1) + w_11b*cos(wo*t.f1);
w2  = w_20 + w_21a*cos(wo*t.f1) + w_21b*sin(wo*t.f1);
w2D = -w_21a*sin(wo*t.f1) + w_21b*cos(wo*t.f1);
th1 = th_10 + w_10*t.f1 + w_11a*sin(wo*t.f1)/wo - w_11b*cos(wo*t.f1)/wo;
th2 = th_20 + w_20*t.f1 + w_21a*sin(wo*t.f1)/wo - w_21b*cos(wo*t.f1)/wo;

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