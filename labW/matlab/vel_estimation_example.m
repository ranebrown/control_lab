% estimate velocity using noncausal filter (accel_fir)
%
% John Hauser
% Jan 2016

T_TH_dTH_V = load('resp_P.txt');%change to file you need

T = T_TH_dTH_V(:,1);
Th_ = T_TH_dTH_V(:,2);



Th = Th_*pi/8000;


% design noncausal filters for pos, vel, accel
% [h, hd, hdd] = accel_fir(sigma, delta, delay, win);
dt = 0.01;  % sampling time
% choose the amount of smoothing
sig = 0.05;  % std dev of Gaussian weighting
[h, hd, hdd] = accel_fir(sig, dt);

Th_f = conv_delay(h,Th);
dTh_f = conv_delay(hd,Th);
ddTh_f = conv_delay(hdd,Th);

figure
  plot(T,[Th,Th_f])
  grid on, zoom on
title('\theta (encoder + filtered)')

figure
  plot(T,[dTh_f dTh])
  grid on, zoom on
title('d\theta  (noncausal + causal/experiment)')

figure
  plot(T,[ddTh_f])
  grid on, zoom on
title('dd\theta  (noncausal)')

figure
  plot(T,V)
  grid on, zoom on
title('motor command (V)')

