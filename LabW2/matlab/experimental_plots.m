% tds collected data
% col 1 = time sec
% col 2 = position encoder counts bottom disc
% col 3 = velocity counts / rev
% col 4 = motor voltage V
% col 5 = position encoder counts middle disc

% velocity data needs scaled by pi/8000 to be in rad/sec

fs = filesep;   % / linux mac and \ windows
rsC = pi/8000;  % convert to rad/sec
vC = 3276.7;    % convert motor count to a voltage

% collected data
step=dlmread(['dataw2' fs 'w2-controller-step.txt']);
f1=dlmread(['dataw2' fs 'w2-controller-f1.txt']);
f2=dlmread(['dataw2' fs 'w2-controller-f2.txt']);
f3=dlmread(['dataw2' fs 'w2-controller-f3.txt']);
f4=dlmread(['dataw2' fs 'w2-controller-f4.txt']);
f5=dlmread(['dataw2' fs 'w2-controller-f5.txt']);

% convert to voltage and rad/sec
step(:,4) = step(:,4).*vC;  % commanded voltage to volts
step(:,2) = step(:,2).*rsC; % bottom encoder to rad/sec
step(:,5) = step(:,5).*rsC; % middle encoder to rad/sec
step(:,3) = step(:,3).*rsC; % middle encoder to rad/sec

f1(:,4) = f1(:,4).*vC;  % commanded voltage to volts
f1(:,2) = f1(:,2).*rsC; % bottom encoder to rad/sec
f1(:,5) = f1(:,5).*rsC; % middle encoder to rad/sec

f2(:,4) = f2(:,4).*vC;  % commanded voltage to volts
f2(:,2) = f2(:,2).*rsC; % bottom encoder to rad/sec
f2(:,5) = f2(:,5).*rsC; % middle encoder to rad/sec

f3(:,4) = f3(:,4).*vC;  % commanded voltage to volts
f3(:,2) = f3(:,2).*rsC; % bottom encoder to rad/sec
f3(:,5) = f3(:,5).*rsC; % middle encoder to rad/sec

f4(:,4) = f4(:,4).*vC;  % commanded voltage to volts
f4(:,2) = f4(:,2).*rsC; % bottom encoder to rad/sec
f4(:,5) = f4(:,5).*rsC; % middle encoder to rad/sec

f5(:,4) = f5(:,4).*vC;  % commanded voltage to volts
f5(:,2) = f5(:,2).*rsC; % bottom encoder to rad/sec
f5(:,5) = f5(:,5).*rsC; % middle encoder to rad/sec

% experimental step response
si = stepinfo(step(501:end,3),step(501:end,1)-5);

% experimetnal step plot
plot(step(501:end,1)-5,step(501:end,3));
grid on;
title('experimental step response \omega_2');
xlabel('sec');
ylabel('rad/sec');

% frequencies of collected data in rad/sec
 wo.f1 = 2*pi;
 wo.f2 = 2*pi*2;
 wo.f3 = 2*pi*3;
 wo.f4 = 2*pi*4;
 wo.f5 = 2*pi*5;
 freq = [wo.f1, wo.f2, wo.f3, wo.f4, wo.f5];

% experimental bode plot
% calculate parameters for u(t) equation at each frequency
[u0.f1, u1a.f1, u1b.f1]  = solveU(wo.f1, f1(201:end,4), f1(201:end,1));
[u0.f2, u1a.f2, u1b.f2]  = solveU(wo.f2, f2(201:end,4), f2(201:end,1));
[u0.f3, u1a.f3, u1b.f3]  = solveU(wo.f3, f3(201:end,4), f3(201:end,1));
[u0.f4, u1a.f4, u1b.f4]  = solveU(wo.f4, f4(201:end,4), f4(201:end,1));
[u0.f5, u1a.f5, u1b.f5]  = solveU(wo.f5, f5(201:end,4), f5(201:end,1));

% calcualte parameters for theta_1(t) equation at each frequency
[om_10.f1, w_10.f1, w_11a.f1, w_11b.f1] = solveO(wo.f1, f1(201:end,1), f1(201:end,2));
[om_10.f2, w_10.f2, w_11a.f2, w_11b.f2] = solveO(wo.f2, f2(201:end,1), f2(201:end,2));
[om_10.f3, w_10.f3, w_11a.f3, w_11b.f3] = solveO(wo.f3, f3(201:end,1), f3(201:end,2));
[om_10.f4, w_10.f4, w_11a.f4, w_11b.f4] = solveO(wo.f4, f4(201:end,1), f4(201:end,2));
[om_10.f5, w_10.f5, w_11a.f5, w_11b.f5] = solveO(wo.f5, f5(201:end,1), f5(201:end,2));

% calculate parameters for theta_2(t) equation at each frequency
[om_20.f1, w_20.f1, w_21a.f1, w_21b.f1] = solveO2(wo.f1, f1(201:end,1), f1(201:end,5));
[om_20.f2, w_20.f2, w_21a.f2, w_21b.f2] = solveO2(wo.f2, f1(201:end,2), f2(201:end,5));
[om_20.f3, w_20.f3, w_21a.f3, w_21b.f3] = solveO2(wo.f3, f1(201:end,3), f3(201:end,5));
[om_20.f4, w_20.f4, w_21a.f4, w_21b.f4] = solveO2(wo.f4, f1(201:end,4), f4(201:end,5));
[om_20.f5, w_20.f5, w_21a.f5, w_21b.f5] = solveO2(wo.f5, f1(201:end,5), f5(201:end,5));

% experimental bode plot
% H_w1u(jwo) = w1'(jwo) / u'(jwo)
u_p = complex([u1a.f1, u1a.f2, u1a.f3, u1a.f4, u1a.f5], -[u1b.f1, u1b.f2, u1b.f3, u1b.f4, u1b.f5]);
w1_p = complex([w_11a.f1, w_11a.f2, w_11a.f3, w_11a.f4, w_11a.f5], -[w_11b.f1, w_11b.f2, w_11b.f3, w_11b.f4, w_11b.f5]);
H_w1u = w1_p./u_p;
mag = abs(H_w1u);
magdb = mag2db(mag);
phase = rad2deg(angle(H_w1u));
% create magnitude plot
figure
semilogx(freq,magdb, 'o')
set(gca,'xscale','log')
grid on
title('Magnitude')
xlabel('rad/sec')
ylabel('mag db')
legend('data points')
% create phase plot
figure
semilogx(freq, phase, 'ro')
set(gca,'xscale','log')
grid on
title('Phase')
xlabel('rad/sec')
ylabel('phase deg')
legend('data points')
 
