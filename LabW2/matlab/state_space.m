%clear all; close all; clc;

% inertia
J1 = 0.0115;    % 4 weights 6.5cm
J2 = 0.0064;    % 2 weights at 6.5cm

% system parameters
b = 0.3050;
k = 2.5500;
c1 = 0.0040;
c2 = 0.0016;

% state space model
A = [-c1/J1 0 -k/J1; 0 -c2/J2 k/J2; 1 -1 0];
B = [b/J1; 0; 0];
C = [ eye(3); 0 0 0 ];
D = [ 0 0 0 1 ]';
% x = [w1; w2; beta]

ssModel = ss(A, B, C, D);

s = tf('s');
Kp = 1.7241;
C = Kp * ((1+ .68*s)*(1+0.1*s))/((1+0.097*s)*(1+3.9*s));
C2 = 0.52979 * ((1+.00019*s + (.04*s)^2)/(1+0.069*s+(0.04*s)^2)); % unstable

% calculate transfer functions
TFs = tf(ssModel);
H_w1u = TFs(1);
H_w2u = TFs(2);
H_Bu  = TFs(3);

% negative feedback loop for all transfer functions
cl = feedback(series(C,TFs),1,1,1);

% step response uncompensated
cl_noComp = feedback(TFs,1,1,1);
figure
step(cl_noComp(1));
title('Step response for \omega_1 feedback, no compensation');
stepresp0 = stepinfo(cl_noComp(1))
[Gm0,Pm0,Wgm0,Wpm0] = margin(cl_noComp(1))

% convert to discrete time
c2d(cl(1),.01,'tustin');

% bode plots
% figure(1); bode(cl(1)); title('H_{w1u}');
% figure(2); bode(cl(2)); title('H_{w2u}');
% figure(3); bode(cl(3)); title('H_{Bu}');

%step response
stepresp = stepinfo(cl(1))
figure
step(cl(1), 5);
title('Step response for \omega_1 feedback');


% gain and phase margin
[Gm1,Pm1,Wgm1,Wpm1] = margin(cl(1));
[Gm2,Pm2,Wgm2,Wpm2] = margin(cl(2));
[Gm3,Pm3,Wgm3,Wpm3] = margin(cl(3));
