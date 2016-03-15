function [h, hd, hdd] = accel_fir(sigma, delta, delay, win)
% [h, hd, hdd] = accel_fir(sigma, delta, delay, win);
%
% compute FIR filters to
%   estimate position, velocity, and accel from encoder data
%
% at each sample, do a symmetric (hence noncausal), weighted least squares fit
% to     a t^2 /2  +  b t  +  c
%
%	weight using gaussian  exp( -(t/sigma)^2 )
%	using a window    t0 +- 2.5*sigma
%
% to obtain a smooth derivative estimate of experimental data, use
%
%   theta_dot_f = conv_delay(hd, theta);%theta = position, hd is obtained
%   from this function
%
% if 'delay' is specified, the fit is no longer symmetri1c.
%   delay then specifies the time between the first sample
%   and the 'center' of the fit
%
% if 'win' is specified, it replaces the factor 2.5 above.
%
%
% John Hauser
% Jun 1999

if nargin < 4, win   = []; end;
if nargin < 3, delay = []; end;
if nargin < 2, delta = []; end;
if nargin < 1, sigma = []; end;

if isempty(sigma), sigma = 0.5; end;

if isempty(delta), delta = 0.005; end;

if isempty(win), win = 2.5; end;

km = floor(win*sigma/delta);

if isempty(delay)
  kp = km;
else
  delay = abs(delay);
  kp = floor(delay/delta);
end

ks = (-km:kp)';

ts = delta*ks;

ws = exp( -(ts/sigma).^2 );

Ws = diag(ws);

WA = [ ws.*ts.^2/2   ws.*ts   ws ];

WA_W = WA \ Ws;

figure(8), plot(ts, WA_W'), grid on, zoom on%comment out

% impulse responses (flipped for convolution)

h = fliplr(WA_W(3,:));
hd = fliplr(WA_W(2,:));
hdd = fliplr(WA_W(1,:));
