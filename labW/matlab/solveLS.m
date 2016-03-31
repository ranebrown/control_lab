  
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

% calculate parameters for u(t) equation at each frequency
[u0.f1, u1a.f1, u1b.f1]  = solveU(wo.f1, volt.f1, t.f1);
[u0.f2, u1a.f2, u1b.f2]  = solveU(wo.f2, volt.f2, t.f2);
[u0.f3, u1a.f3, u1b.f3]  = solveU(wo.f3, volt.f3, t.f3);
[u0.f4, u1a.f4, u1b.f4]  = solveU(wo.f4, volt.f4, t.f4);
[u0.f5, u1a.f5, u1b.f5]  = solveU(wo.f5, volt.f5, t.f5);

% calcualte parameters for omega_1(t) equation at each frequency


