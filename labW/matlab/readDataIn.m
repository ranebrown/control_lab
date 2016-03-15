function [t, filt_pos,filt_vel,filt_accel] = readDataIn()
% tds collected data
% col 1 = time sec
% col 2 = position encoder counts bottom disc
% col 3 = velocity counts / rev
% col 4 = motor voltage V
% col 5 = position encoder counts middle disc

% velocity data needs scaled by pi/8000 to be in rad/sec

fs = filesep; % / linux mac and \ windows

x = pi/8000; % convert to rad/sec

% collected data
d261=dlmread(['data' fs '2-6cm1.txt']);
d262=dlmread(['data' fs '2-6cm2.txt']);
d291=dlmread(['data' fs '2-9cm1.txt']);
d292=dlmread(['data' fs '2-9cm2.txt']);
d461=dlmread(['data' fs '4-6cm1.txt']);
d462=dlmread(['data' fs '4-6cm2.txt']);

% time seconds
t.d261 = d261(:,1);
t.d262 = d262(:,1);
t.d291 = d291(:,1);
t.d292 = d292(:,1);
t.d461 = d461(:,1);
t.d462 = d462(:,1);

% bottom encoder position rad/sec
bot.d261 = d261(:,2).*x;
bot.d262 = d262(:,2).*x;
bot.d291 = d291(:,2).*x;
bot.d292 = d292(:,2).*x;
bot.d461 = d461(:,2).*x;
bot.d462 = d462(:,2).*x;

% middle encoder position rad/sec
mid.d261 = d261(:,5).*x;
mid.d262 = d262(:,5).*x;
mid.d291 = d291(:,5).*x;
mid.d292 = d292(:,5).*x;
mid.d461 = d461(:,5).*x;
mid.d462 = d462(:,5).*x;

dt = 0.01;  % sampling time
sig = 0.05;  % std dev of Gaussian weighting
[h, hd, hdd] = accel_fir(sig, dt);

% bottom disc filtered position, velocity, acceleration
filt_pos.botd261 = conv_delay(h,bot.d261);
filt_vel.botd261 = conv_delay(hd,bot.d261);
filt_accel.botd261 = conv_delay(hdd,bot.d261);
filt_pos.botd262 = conv_delay(h,bot.d262);
filt_vel.botd262 = conv_delay(hd,bot.d262);
filt_accel.botd262 = conv_delay(hdd,bot.d262);
filt_pos.botd291 = conv_delay(h,bot.d291);
filt_vel.botd291 = conv_delay(hd,bot.d291);
filt_accel.botd291 = conv_delay(hdd,bot.d291);
filt_pos.botd292 = conv_delay(h,bot.d292);
filt_vel.botd292 = conv_delay(hd,bot.d292);
filt_accel.botd292 = conv_delay(hdd,bot.d292);
filt_pos.botd461 = conv_delay(h,bot.d461);
filt_vel.botd461 = conv_delay(hd,bot.d461);
filt_accel.botd461 = conv_delay(hdd,bot.d461);
filt_pos.botd462 = conv_delay(h,bot.d462);
filt_vel.botd462 = conv_delay(hd,bot.d462);
filt_accel.botd462 = conv_delay(hdd,bot.d462);

% middle disc filtered position, velocity, acceleration
filt_pos.midd261 = conv_delay(h,mid.d261);
filt_vel.midd261 = conv_delay(hd,mid.d261);
filt_accel.midd261 = conv_delay(hdd,mid.d261);
filt_pos.midd262 = conv_delay(h,mid.d262);
filt_vel.midd262 = conv_delay(hd,mid.d262);
filt_accel.midd262 = conv_delay(hdd,mid.d262);
filt_pos.midd291 = conv_delay(h,mid.d291);
filt_vel.midd291 = conv_delay(hd,mid.d291);
filt_accel.midd291 = conv_delay(hdd,mid.d291);
filt_pos.midd292 = conv_delay(h,mid.d292);
filt_vel.midd292 = conv_delay(hd,mid.d292);
filt_accel.midd292 = conv_delay(hdd,mid.d292);
filt_pos.midd461 = conv_delay(h,mid.d461);
filt_vel.midd461 = conv_delay(hd,mid.d461);
filt_accel.midd461 = conv_delay(hdd,mid.d461);
filt_pos.midd462 = conv_delay(h,mid.d462);
filt_vel.midd462 = conv_delay(hd,mid.d462);
filt_accel.midd462 = conv_delay(hdd,mid.d462);
