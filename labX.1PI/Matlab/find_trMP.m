function [tr, Mp] = find_trMP(collectedData, refVal)
% caclulates the rise time and overshoot of experimental data

time = collectedData(501:1201,1)-5;
vel = collectedData(501:1201,3).*(pi/8000);

% calculate rise time
ten = find(vel >= refVal*0.1);
nineD = find(vel >= refVal*.9);
tr = time(nineD(1)) - time(ten(1));

% calculate overshoot
m = find(vel == max(vel));
Mp = vel(m) - refVal;