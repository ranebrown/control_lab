 % frequencies of collected data in rad/sec
 wo.f1 = 2*pi;
 wo.f2 = 2*pi*2;
 wo.f3 = 2*pi*3;
 wo.f4 = 2*pi*4;
 wo.f5 = 2*pi*5;
 freq = [wo.f1, wo.f2, wo.f3, wo.f4, wo.f5];

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

% calcualte parameters for theta_1(t) equation at each frequency
[om_10.f1, w_10.f1, w_11a.f1, w_11b.f1] = solveO(wo.f1, t.f1, bot.f1);
[om_10.f2, w_10.f2, w_11a.f2, w_11b.f2] = solveO(wo.f2, t.f2, bot.f2);
[om_10.f3, w_10.f3, w_11a.f3, w_11b.f3] = solveO(wo.f3, t.f3, bot.f3);
[om_10.f4, w_10.f4, w_11a.f4, w_11b.f4] = solveO(wo.f4, t.f4, bot.f4);
[om_10.f5, w_10.f5, w_11a.f5, w_11b.f5] = solveO(wo.f5, t.f5, bot.f5);

% calculate parameters for theta_2(t) equation at each frequency
[om_20.f1, w_20.f1, w_21a.f1, w_21b.f1] = solveO2(wo.f1, t.f1, mid.f1);
[om_20.f2, w_20.f2, w_21a.f2, w_21b.f2] = solveO2(wo.f2, t.f2, mid.f2);
[om_20.f3, w_20.f3, w_21a.f3, w_21b.f3] = solveO2(wo.f3, t.f3, mid.f3);
[om_20.f4, w_20.f4, w_21a.f4, w_21b.f4] = solveO2(wo.f4, t.f4, mid.f4);
[om_20.f5, w_20.f5, w_21a.f5, w_21b.f5] = solveO2(wo.f5, t.f5, mid.f5);

% experimental bode plot
% H_w1u(jwo) = w1'(jwo) / u'(jwo)
u_p = complex([u1a.f1, u1a.f2, u1a.f3, u1a.f4, u1a.f5], -[u1b.f1, u1b.f2, u1b.f3, u1b.f4, u1b.f5]);
w1_p = complex([w_11a.f1, w_11a.f2, w_11a.f3, w_11a.f4, w_11a.f5], -[w_11b.f1, w_11b.f2, w_11b.f3, w_11b.f4, w_11b.f5]);
H_w1u = w1_p./u_p;
mag = abs(H_w1u);
magdb = mag2db(mag);
phase = angle(H_w1u);
% create plot
semilogx(freq,magdb, 'o')
set(gca,'xscale','log')
grid on
title('Experimental Bode Plot')
xlabel('rad/sec')
ylabel('mag db')
legend('data points')