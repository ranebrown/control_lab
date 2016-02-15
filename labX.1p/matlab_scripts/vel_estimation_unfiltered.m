% estimate c without filter
% Jan 2016

T_TH_dTH_V = load('9cmSpin1.txt');

T = T_TH_dTH_V(:,1); %time
Th_ = T_TH_dTH_V(:,2); %position (encoder counts)
dTh_ = T_TH_dTH_V(:,3); %velocity (counts/rev)
V_ = T_TH_dTH_V(:,4); %voltage (unscaled)


Th = Th_*pi/8000; %scaled position (rads)
dTh = dTh_*pi/8000; %scaled velocity (rads/s)
V = V_*10/32767; %voltage (V)

figure
  plot(T,Th_)%plot
  grid on, zoom on
title('\theta (radians)')

figure
  plot(T, dTh_)
  grid on, zoom on
title('d\theta  (velocity in rad/s)')

figure
  plot(T, log(dTh_))
  grid on, zoom on
title('d\theta  (velocity in rad/s)')

figure
  plot(T,V)
  grid on, zoom on
title('motor command (V)')

%calculate inertia from mass arrangement:
R = .045; %distance from center (m)
r = .025; %radius of mass disks (m)
m = 0.5; %mass of each disk (kg)
J = ;

%find linear portion of plot and calculate c:
wo = ; %start time of linear portion
wt = ; %end time of linear portion
c = -(J*log(wt/wo)/t;

