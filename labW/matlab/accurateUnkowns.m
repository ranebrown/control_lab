function [c1, c2, k, b] = accurateUnkowns()
% solves EOM for 2 disc TDS system
% wo = frequency in rad/sec
% f = frequency to use f1,f2,f3,f4,f5 this is a string used to access
% struct
% example usage: [c1, c2, k, b] = findSystemParams(2*pi*1, 'f1')

% t = time
% bot = bottom encoder position
% mid = middle encoder position
% volt = commanded voltage

% inertia for lower and middle discs
J1 = 0.0128;
J2 = 0.0097;

% read in data
[t, volt, bot, mid] = read();

% names of fields in returned structs
tn = fieldnames(t);
vn = fieldnames(volt);
bn = fieldnames(bot);
mn = fieldnames(mid);

% frequencies
wo = [2*pi*1; 2*pi*2; 2*pi*3; 2*pi*4; 2*pi*5];


for i = 1:numel(tn)
    % find coeffecients for u(t)
    [tu0, tu1a, tu1b]  = solveU(wo(i), volt.(vn{i}), t.(tn{i}));
    % concatenate matrices
    if i == 1
        u0 = tu0;
        u1a = tu1a;
        u1b = tu1b;
    else
        u0 = [u0;tu0];
        u1a = [u1a; tu1a];
        u1b = [u1b; tu1b];
    end
    
    % find coeffecients for theta_1(t)
    [tth_10, tw_10, tw_11a, tw_11b] = solveO(wo(i), t.(tn{i}), bot.(bn{i}));
    % concatenate matrices
    if i == 1
        th_10 = tth_10;
        w_10 = tw_10;
        w_11a = tw_11a;
        w_11b = tw_11b;
    else
        th_10 = [th_10; tth_10];
        w_10 = [w_10; tw_10];
        w_11a = [w_11a; tw_11a];
        w_11b = [w_11b; tw_11b];
    end

    % find coeffecients for theta_2(t)
    [tth_20, tw_20, tw_21a, tw_21b] = solveO2(wo(i), t.(tn{i}), mid.(mn{i}));
    % concatenate matrices
    if i == 1
        th_20 = tth_20;
        w_20 = tw_20;
        w_21a = tw_21a;
        w_21b = tw_21b;
    else
        th_20 = [th_20; tth_20];
        w_20 = [w_20; tw_20];
        w_21a = [w_21a; tw_21a];
        w_21b = [w_21b; tw_21b];
    end
    
    % time vector
    if i == 1
        time = t.(tn{i});
    else
        time = [time; t.(tn{i})];
    end
    
    % equations to describe model
    tu   = u0(i) + u1a(i)*cos(wo(i)*t.(tn{i})) + u1b(i)*sin(wo(i)*t.(tn{i}));
    tw1  = w_10(i) + w_11a(i)*wo(i)*cos(wo(i)*t.(tn{i})) + w_11b(i)*wo(i)*sin(wo(i)*t.(tn{i}));
    tw1D = -w_11a(i)*sin(wo(i)*t.(tn{i})) + w_11b(i)*cos(wo(i)*t.(tn{i}));
    tw2  = w_20(i) + w_21a(i)*cos(wo(i)*t.(tn{i})) + w_21b(i)*sin(wo(i)*t.(tn{i}));
    tw2D = -w_21a(i)*sin(wo(i)*t.(tn{i})) + w_21b(i)*cos(wo(i)*t.(tn{i}));
    tth1 = th_10(i) + w_10(i)*t.(tn{i}) + w_11a(i)*sin(wo(i)*t.(tn{i}))/wo(i) - w_11b(i)*cos(wo(i)*t.(tn{i}))/wo(i);
    tth2 = th_20(i) + w_20(i)*t.(tn{i}) + w_21a(i)*sin(wo(i)*t.(tn{i}))/wo(i) - w_21b(i)*cos(wo(i)*t.(tn{i}))/wo(i);
    if i == 1
        u = tu;
        w1 = tw1;
        w1D = tw1D;
        w2 = tw2;
        w2D = tw2D;
        th1 = tth1;
        th2 = tth2;
    else
        u = [u;tu];
        w1 = [w1;tw1];
        w1D = [w1D; tw1D];
        w2 = [w2; tw2];
        w2D = [w2D; tw2D];
        th1 = [th1; tth1];
        th2 = [th2; tth2];
    end
    
    % calculate beta
    A3 = [cos(wo(i)*t.(tn{i})) sin(wo(i)*t.(tn{i}))];
    % fix matrix dimensions 1:1001, 1002:2002 ...
    b3 = [th1(i) - th2(i)];
    x3 = A3 \ b3;
    tbe1a = x3(1);
    tbe1b = x3(2);
    if i == 1
        be1a = tbe1a;
        be1b = tbe1b;
    else
        be1a = [be1a; tbe1a];
        be1b = [be1b; tbe1b];
    end
end

% calculate unknowns
A4 = [-u1a be1a w_11a 0; -u1b be1b w_11b 0; 0 -be1a 0 w_21a; 0 -be1b 0 w_21b];
b4 = [-J1*w_11b*wo; J1*w_11a*wo; -J2*w_21b*wo; J2*w_21a*wo];
x4 = A4 \ b4;

% return values
b = x4(1);
k = x4(2);
c1 = x4(3);
c2 = x4(4);