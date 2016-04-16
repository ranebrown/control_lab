% save Fourier Series coefficients  (expressed two ways)
%save labW_FS freq_s u_s beta_s w1_s w2_s Pw1u_frd Pw2u_frd Pbetau_frd Pxu_frd J1 J2
load labW_FS % freq_s u_s beta_s w1_s w2_s Pw1u_frd Pw2u_frd Pbetau_frd Pxu_frd J1 J2

% from constrained linear least squares with c1 >= 0.005
%
%   other values are not too sensitive to this choice
%
% bb = 0.3047;
% kk = 2.547;
% cc1 = 0.005;
% cc2 = 0.001615;
%
% perhaps round to
%
% bb = 0.305;
% kk = 2.55;
% cc1 = 0.005;
% cc2 = 0.0016;

% build up overdetermined linear system for estimating parameters

A_bkc1c2 = [];  % coef matrix for parameter estimation (over all freqs at once)
B_bkc1c2 = [];  % data vector for param estimation

bkc1c2_s = [];  % freq-by-freq estiamted params  (not so useful)

for ii = 1:length(freq_s)
  w0_ = 2*pi*freq_s(ii);

  u1a = u_s(ii,2);
  u1b = u_s(ii,3);
  w11a = w1_s(ii,2);
  w11b = w1_s(ii,3);
  w21a = w2_s(ii,2);
  w21b = w2_s(ii,3);
  beta1a = beta_s(ii,2);
  beta1b = beta_s(ii,3);
  
  A_bkc1c2 = [ A_bkc1c2;
               [ -u1a  beta1a w11a  0;
                 -u1b  beta1b w11b  0;
                 0   -beta1a  0   w21a;
                 0   -beta1b  0   w21b ] ];

  B_bkc1c2 = [ B_bkc1c2;
               [ -J1*w11b*w0_; J1*w11a*w0_; -J2*w21b*w0_; J2*w21a*w0_ ] ];

  bkc1c2_s = [ bkc1c2_s;
               ([ -u1a  beta1a w11a  0;
                  -u1b  beta1b w11b  0;
                  0   -beta1a  0   w21a;
                  0   -beta1b  0   w21b ] ...
                \ [ -J1*w11b*w0_; J1*w11a*w0_; -J2*w21b*w0_; J2*w21a*w0_ ])' ];

end





% unconstrained least squares
bkc1c2 = A_bkc1c2 \ B_bkc1c2

% constrained least squares
c1_min = 0.005;

if 0
bkc1c2_p002 = lsqlin(A_bkc1c2, B_bkc1c2, [],[], [],[], [ 0 0 0.002 0 ]')'
[A,B] = AB_bkc1c2(bkc1c2_p002,J1,J2);
figure,bode(ss(A,B,[1 0 0],0,'InputDelay',.005),Pw1u_frd),grid on,title('w1 .002')

bkc1c2_p003 = lsqlin(A_bkc1c2, B_bkc1c2, [],[], [],[], [ 0 0 0.003 0 ]')'
[A,B] = AB_bkc1c2(bkc1c2_p003,J1,J2);
figure,bode(ss(A,B,[1 0 0],0,'InputDelay',.005),Pw1u_frd),grid on,title('w1 .003')
end

% I kinda like the c1 = 0.004 case
%
% b = 0.305, k = 2.55, c1 = 0.004, c2 = 0.0016
% 
bkc1c2_p004 = lsqlin(A_bkc1c2, B_bkc1c2, [],[], [],[], [ 0 0 0.004 0 ]')'
[A,B] = AB_bkc1c2(bkc1c2_p004,J1,J2);
figure,bode(ss(A,B,[1 0 0],0,'InputDelay',.005),Pw1u_frd),grid on,zoom on,title('w1 .004')
figure,bode(ss(A,B,[0 1 0],0,'InputDelay',.005),Pw2u_frd),grid on,zoom on,title('w2 .004')
figure,bode(ss(A,B,[0 0 1],0,'InputDelay',.005),Pbetau_frd),grid on,zoom on,title('beta .004')
b = 0.305, k = 2.55, c1 = 0.004, c2 = 0.0016
[A,B] = AB_bkc1c2([b k c1 c2],J1,J2);
figure,bode(ss(A,B,[1 0 0],0,'InputDelay',.005),Pw1u_frd),grid on,zoom on,title('w1 .004')
figure,bode(ss(A,B,[0 1 0],0,'InputDelay',.005),Pw2u_frd),grid on,zoom on,title('w2 .004')
figure,bode(ss(A,B,[0 0 1],0,'InputDelay',.005),Pbetau_frd),grid on,zoom on,title('beta .004')

if 0
bkc1c2_p005 = lsqlin(A_bkc1c2, B_bkc1c2, [],[], [],[], [ 0 0 0.005 0 ]')'
[A,B] = AB_bkc1c2(bkc1c2_p005,J1,J2);
figure,bode(ss(A,B,[1 0 0],0,'InputDelay',.005),Pw1u_frd),grid on,title('w1 .005')

bkc1c2_p006 = lsqlin(A_bkc1c2, B_bkc1c2, [],[], [],[], [ 0 0 0.006 0 ]')'
[A,B] = AB_bkc1c2(bkc1c2_p006,J1,J2);
figure,bode(ss(A,B,[1 0 0],0,'InputDelay',.005),Pw1u_frd),grid on,title('w1 .006')

bkc1c2_p007 = lsqlin(A_bkc1c2, B_bkc1c2, [],[], [],[], [ 0 0 0.007 0 ]')'
[A,B] = AB_bkc1c2(bkc1c2_p007,J1,J2);
figure,bode(ss(A,B,[1 0 0],0,'InputDelay',.005),Pw1u_frd),grid on,title('w1 .007')

bkc1c2_p008 = lsqlin(A_bkc1c2, B_bkc1c2, [],[], [],[], [ 0 0 0.008 0 ]')'
[A,B] = AB_bkc1c2(bkc1c2_p008,J1,J2);
figure,bode(ss(A,B,[1 0 0],0,'InputDelay',.005),Pw1u_frd),grid on,title('w1 .008')

bkc1c2_p009 = lsqlin(A_bkc1c2, B_bkc1c2, [],[], [],[], [ 0 0 0.009 0 ]')'
[A,B] = AB_bkc1c2(bkc1c2_p009,J1,J2);
figure,bode(ss(A,B,[1 0 0],0,'InputDelay',.005),Pw1u_frd),grid on,title('w1 .009')
end



