function [KI, KP] = calc_KIKP(zeta,wn)
% calculates KI and KP for a given natural freq wn and damping zeta

% system parameters
K=.3598; 
C=.0079; 
J=.0128;

KI = wn^2*J/K;
KP = (2*zeta*wn-C/J)*J/K;