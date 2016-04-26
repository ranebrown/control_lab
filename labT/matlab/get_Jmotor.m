%input start and end times of linear portion of plot; alter J based on mass
%configuration
function [Jtot] = get_Jmotor(R,numweights)

%calculate inertia from mass arrangement:
r = .025; %radius of mass disks (m)
m = 0.5; %mass of each disk (kg)
Jdisk = 0.0019; %inertia of large disk


Jweight = numweights*(0.5*m*(r)^2 + m*(R)^2);
Jmotor = .0005;
Jtot = Jdisk+Jweight+Jmotor;