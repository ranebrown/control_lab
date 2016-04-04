function [t, volt, bot, mid, posb, posm, velb, velm, accb, accm] = read()
% tds collected data
% col 1 = time sec
% col 2 = position encoder counts bottom disc
% col 3 = velocity counts / rev
% col 4 = motor voltage V
% col 5 = position encoder counts middle disc

% velocity data needs scaled by pi/8000 to be in rad/sec

fs = filesep; % / linux mac and \ windows

x = pi/8000; % convert to rad/sec
y = 3276.7; % convert motor count to a voltage

% collected data
f1=dlmread(['data_freq_resp' fs 'kp1_f1.txt']);
f2=dlmread(['data_freq_resp' fs 'kp1_f2.txt']);
f3=dlmread(['data_freq_resp' fs 'kp1_f3.txt']);
f4=dlmread(['data_freq_resp' fs 'kp1_f4.txt']);
f5=dlmread(['data_freq_resp' fs 'kp1_f5.txt']);

% time seconds
t.f1 = f1(201:1201,1);
t.f2 = f2(201:1201,1);
t.f3 = f3(201:1201,1);
t.f4 = f4(201:1201,1);
t.f5 = f5(201:1201,1);

% commanded motor voltage
volt.f1 = f1(201:1201,4)./y;
volt.f2 = f2(201:1201,4)./y;
volt.f3 = f3(201:1201,4)./y;
volt.f4 = f4(201:1201,4)./y;
volt.f5 = f5(201:1201,4)./y;

% bottom encoder position rad/sec
bot.f1 = f1(201:1201,2).*x;
bot.f2 = f2(201:1201,2).*x;
bot.f3 = f3(201:1201,2).*x;
bot.f4 = f4(201:1201,2).*x;
bot.f5 = f5(201:1201,2).*x;

% middle encoder position rad/sec
mid.f1 = f1(201:1201,5).*x;
mid.f2 = f2(201:1201,5).*x;
mid.f3 = f3(201:1201,5).*x;
mid.f4 = f4(201:1201,5).*x;
mid.f5 = f5(201:1201,5).*x;

dt = 0.01;  % sampling time
sig = 0.05;  % std dev of Gaussian weighting
[h, hd, hdd] = accel_fir(sig, dt);

% calculate position velocity acceleration
posb.f1 = conv_delay(h, bot.f1);
velb.f1 = conv_delay(hd, bot.f1);
accb.f1 = conv_delay(hdd, bot.f1);

posb.f2 = conv_delay(h, bot.f2);
velb.f2 = conv_delay(hd, bot.f2);
accb.f2 = conv_delay(hdd, bot.f2);

posb.f3 = conv_delay(h, bot.f3);
velb.f3 = conv_delay(hd, bot.f3);
accb.f3 = conv_delay(hdd, bot.f3);

posb.f4 = conv_delay(h, bot.f4);
velb.f4 = conv_delay(hd, bot.f4);
accb.f4 = conv_delay(hdd, bot.f4);

posb.f5 = conv_delay(h, bot.f5);
velb.f5 = conv_delay(hd, bot.f5);
accb.f5 = conv_delay(hdd, bot.f5);

posm.f1 = conv_delay(h, mid.f1);
velm.f1 = conv_delay(hd, mid.f1);
accm.f1 = conv_delay(hdd, mid.f1);

posm.f2 = conv_delay(h, mid.f2);
velm.f2 = conv_delay(hd, mid.f2);
accm.f2 = conv_delay(hdd, mid.f2);

posm.f3 = conv_delay(h, mid.f3);
velm.f3 = conv_delay(hd, mid.f3);
accm.f3 = conv_delay(hdd, mid.f3);

posm.f4 = conv_delay(h, mid.f4);
velm.f4 = conv_delay(hd, mid.f4);
accm.f4 = conv_delay(hdd, mid.f4);

posm.f5 = conv_delay(h, mid.f5);
velm.f5 = conv_delay(hd, mid.f5);
accm.f5 = conv_delay(hdd, mid.f5);
