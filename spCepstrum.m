% NAME
%   spCepstrum - The cepstrum
% SYNOPSIS
%   [c, y] = spCepstrum(x, fs, window, show)
% DESCRIPTION
%   Obtain cepstrum coefficients of a signal
% INPUTS
%   x        (vector) of size Nx1 which contains signal
%   fs       (scalar) the sampling frequency
%   [window] (string) the window function such as 'rectwin', 'hamming'. 
%             The default is 'rectwin' (or no window). 
%   [show]   (bool)   plot or not. The default is 0.
% OUTPUTS
%   c        (vector) of size Nx1 which contains cepstrum coefficients
%   [y]      (vector) of size Nx1 which contains fourier response
% AUTHOR
%   Naotoshi Seo, April 2008
function [c, y] = spCepstrum(y, fs, window, show)
 %% Initialization
  N = length(y);
  c = real(ifft(log(abs(y)+eps)));
  ms1=fs/1000; % 1ms. maximum speech Fx at 1000Hz
  ms20=fs/30;  % 20ms. minimum speech Fx at 50Hz
  q=(ms1:ms20)/fs;

