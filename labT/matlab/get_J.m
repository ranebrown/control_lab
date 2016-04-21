%input start and end times of linear portion of plot; alter J based on mass
%configuration
function [Jtot] = get_J(R,numweights)

%calculate inertia from mass arrangement:
% R = .09; %distance from center (m)
r = .025; %radius of mass disks (m)
m = 0.5; %mass of each disk (kg)
Jdisk = 0.0019; %inertia of large disk

Jweight = numweights*(0.5*m*(r)^2 + m*(R)^2);
% Jmotor = .0005;
Jtot = Jdisk+Jweight;%+Jmotor;


%find linear portion of plot and calculate c:
%wo = ; %start time of linear portion
%wt = ; %end time of linear portion
%  c = -(Jtot*log(wt/wo))/t;