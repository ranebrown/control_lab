close all;

J1 = get_Jmotor(6.5, 4);%include motor inertia
J2 = get_J(.065, 2);
J3 = get_J(.065, 2);

bb = 0.305;
kk = 2.55;
cc1 = 0.005;
cc2 = 0.0016;
cc3 = cc2;

b1 = bb/J1;
k11 = kk/J1;
c11 = cc1/J1;
k12 = kk/J2;
k22 = kk/J2;
c22 = cc2/J2;
k23 = kk/J3;
c33 = cc3/J3;

s = tf('s');

%x = [tha dth1 th2 dth2 th3 dth3]
A = [0 1 0 0 0 0;
    -k11 -c11 k11 0 0 0;
    0 0 0 1 0 0;
    k12 0 -k12-k22 -c22 k22 0;
    0 0 0 0 0 1;
    0 0 k23 0 -k23 -c33];

B = [0; b1; 0; 0; 0; 0];

%outputs are th1 th2 and beta21 = th2-th1 and beta32 = th3-th2
C = [1 0 0 0 0 0; 0 0 1 0 0 0; -1 0 1 0 0 0; 0 0 -1 0 1 0];

tds = ss(A, B, C, 0);

Hth1u = zpk(tds(1));
Hth2u = zpk(tds(2));
Hth3u = zpk(tds(3));

%lead compensator
% Cs = (1 + 0.7*s)/(1 + 0.07*s);
Cs = (995.3*s^2+8423*s+1036)/(s^2+29.15*s+103.6);
Cz = c2d(Cs,0.01,'tustin');

tds_cl = feedback(series(Cs,tds),1,1,1);

p = pole(tds_cl);

z1 = zero(tds_cl(1));

z2 = zero(tds_cl(2));

z3 = zero(tds_cl(3));

hold on
bode(tds_cl(1))
bode(tds_cl(2))
bode(tds_cl(3))
bode(tds_cl(4))
grid on
legend('r -> \theta_1', 'r -> \theta_2', 'r -> \beta_2_1', 'r -> \beta_3_2')

% figure, bode(tds_cl(1)), grid on, title('r -> \theta_1')

% figure, rlocus(Hth1u), grid on, title('r -> \theta_1 no compensation')

% figure, rlocus(tds_cl(1)), grid on, title('r -> \theta_1')

% figure, bode(tds_cl(2)), grid on, title('r -> \theta_2')
% 
% figure, bode(tds_cl(3)), grid on, title('r -> \beta_2_1')
% 
% figure, bode(tds_cl(4)), grid on, title('r -> \beta_3_2')