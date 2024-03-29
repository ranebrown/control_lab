function [data] = readDataIn()
% tds collected data
% col 1 = time sec
% col 2 = position encoder counts 
% col 3 = velocity counts / rev
% col 4 = motor voltage V

% velocity data needs scaled by pi/8000 to be in rad/sec

fs = filesep; % / linux mac and \ windows

% machine 1 data
data.m1t1=dlmread(['data' fs 'vref6_KP0.1548_KI0.4611_dist0_stepat5to7.txt']);
data.m1t2=dlmread(['data' fs 'vref6_KP0.469_KI3.558_dist0_stepat5to7.txt']);
data.m1t3=dlmread(['data' fs 'vref6_KP0.5472_KI3.558_dist0_stepat5to7.txt']);
data.m1t4=dlmread(['data' fs 'vref6_KP1.258_KI14.23_dist0_stepat5to7.txt']);
data.m1t5=dlmread(['data' fs 'vref6_KP1.329_KI14.2301_dist0_stepat5to7.txt']);
data.m1t6=dlmread(['data' fs 'vref6_KP2_KI32.0178_dist0_stepat5to7.txt']);

% machine 2 data (same values as machine 1)
data.m4t1=dlmread(['data' fs 'machine4_test1.txt']);
data.m4t2=dlmread(['data' fs 'machine4_test2.txt']);
data.m4t3=dlmread(['data' fs 'machine4_test3.txt']);
data.m4t4=dlmread(['data' fs 'machine4_test4.txt']);
data.m4t5=dlmread(['data' fs 'machine4_test5.txt']);

% disturbance data
data.m10dist=dlmread(['data' fs 'machine1_0dist_t3.txt']);
data.m1Rdist=dlmread(['data' fs 'machine1_rampdist_t3.txt']);
data.m40dist=dlmread(['data' fs 'machine4_0dist_t3.txt']);
data.m4Rdist=dlmread(['data' fs 'machine4_rampdist_t3.txt']);