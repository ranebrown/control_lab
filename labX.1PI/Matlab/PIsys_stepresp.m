function [openLoop, closedLoop, S] = PIsys_stepresp(Kp, KI)
% returns the open loop and closed loop system for given PI controller
% returns the step response info in struct S
% plots the step response
% Kp = proportional gain
% KI = integral gain

% system parameters
K=.3598; 
C=.0079; 
J=.0128;

openLoop = tf([K*Kp K*KI],[J C 0]);
closedLoop = feedback(openLoop,1);
stepplot(closedLoop);
S = stepinfo(closedLoop);