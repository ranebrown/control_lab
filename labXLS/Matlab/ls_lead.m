clear all; close all; clc;
s = tf('s');
P = 0.3598/(0.0128*s + 0.0079);                 % plant 4 weights at 7cm
I = 1/s;                                        % integrator
Td = exp(-0.005*s);                             % time delay
ol = P*I*Td;                                    % open loop transfer function

% desired parameters
% ess to ramp < 0.10
% Mp < 0.15

% calculate gain based on desired steady state error
% (1) Kv = lim(s->0) [s*ol*K]
% (2) ess = 1/Kv < desired_ess
% solve (2) for Kv and sub result into (1) and solve for K
K = 0.2196;

% calculate phase margin based on desired overshoot
Mp = 0.15;                                      % overshoot
z = abs(log(Mp))/sqrt(pi^2+log(Mp)^2);          % damping
PM = atand(2*z/(sqrt(-2*z^2+sqrt(1+4*z^4))));   % phase margin

% calculate needed phase lead to meet specifications

