function  x_f = conv_delay(h, x, delay)
%  x_f = conv_delay(h, x, delay);
%
% convolve a signal with an FIR filter with
%
%   * specify the 'delay' of the (noncausal) filter
%     (taken to be midpoint if not specified)
%
%   * extend the signal (with constant value) so the ouput
%     has the same length as input
%
% developed for use with
%
%   accel_fir.m
%
%     which produces filters for
%       value     (smoothed position)
%       1st deriv (velocity)
%       2nd deriv (accel)
% 
%
% John Hauser
% Jun 1999

if nargin < 3, delay = []; end;
if nargin < 2, x = [];     end;
if nargin < 1, h = [];     end;

if isempty(h), error('conv_delay: nonempty impulse response required'); end;

if isempty(x), error('conv_delay: nonempty input signal required'); end;

if isempty(delay), delay = floor(length(h)/2); end;

hlen = length(h);
remain = hlen - delay - 1;

% extend theta signal with constant values before and after

[m,n] = size(x);
if n>m, x = x'; end;	% force column

x_e = [x(1)*ones(remain,1); x; x(end)*ones(delay,1)];

x_f_e = conv(h, x_e);

x_f = x_f_e(hlen:end-hlen+1);

if n>m, x_f = x_f'; end;	% make x_f be same size as x
