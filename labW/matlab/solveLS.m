  
 % frequencies of collected data in rad/sec
 wo.f1 = 2*pi;
 wo.f2 = 2*pi*2;
 wo.f3 = 2*pi*3;
 wo.f4 = 2*pi*4;
 wo.f5 = 2*pi*5;

% read data from text files
% t = struct containing times for 5 freqs
% volt = sturct of commanded voltage for 5 freqs
% bot = struct of bottom encoder position
[t, volt, bot, mid, posb, posm, velb, velm, accb, accm] = read();

% calculate parameters for u(t) equation
[u0, u1a, u1b]  = solveU(wo, volt, t)

