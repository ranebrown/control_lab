%create theoretical Bode plots of transfer functions

b = 0.3598;
J1 = 0.0128;
J2 = 0.0097;
c1 = 0.0079;
c2 = 0.0107;
k=2.1822;

s = tf('s');

Hw1u = ((b/J1)*(s^2+ (c2/J2) + (k/J2))/(s^3 + s^2*((c1/J1)+(c2/J2)) + s*((c1/J1)*(c2/J2) + (k/J1)+ (k/J2)) + ((k/J1)*(c2/J2) + ((k/J2)*(c1/J1)))));

Hw2u = (((b/J1)*(k/J2))/(s^3 + s^2*((c1/J1)+(c2/J2)) + s*((c1/J1)*(c2/J2) + (k/J1)+ (k/J2)) + ((k/J1)*(c2/J2) + ((k/J2)*(c1/J1)))));

HBu = ((b*(s+(c2/J2)))/(s^3 + s^2*((c1/J1)+(c2/J2)) + s*((c1/J1)*(c2/J2) + (k/J1)+ (k/J2)) + ((k/J1)*(c2/J2) + ((k/J2)*(c1/J1)))));
% 
% figure
% rlocus(Hw1u);
% title('H_{\omega_{1}u}')
% 
% figure
% rlocus(Hw2u);
% title('H_{\omega_{2}u}')
% 
% figure
% rlocus(HBu);
% title('H_{\beta u}')

figure
bode(Hw1u);
title('H_{\omega_{1}u}')

% figure
% bode(Hw2u);
% title('H_{\omega_{2}u}')
% 
% figure
% bode(HBu);
% title('H_{\beta u}')