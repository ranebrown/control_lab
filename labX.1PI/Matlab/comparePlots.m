function comparePlots(cl,tds)
% compares matlab step response and collected step response
% cl = matlab closed loop TF
% tds = collected data matrix 1501x4

% step response from time 0 to 7
[y,t] = step(cl,7);
y = y+6; % offset to align with actual data

% velocity to step response start time 5
time = tds(501:1201,1)-5;
vel = tds(501:1201,3).*(pi/8000);

% plot data
plot(t,y,time,vel);
title('Step Response Comparison');
legend('matlab','tds');