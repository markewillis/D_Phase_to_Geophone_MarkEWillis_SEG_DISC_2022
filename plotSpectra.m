function plotSpectra(~,~,~)
% ***********************************************************************************************************
% MIT License
% 
% Copyright (c) 2022 Mark E. Willis
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
%
% ***********************************************************************************************************
global Theta2geo

axesLabelSize  = 12;
titleLabelSize = 16;

switch Theta2geo.h.dropdown_spectra.Value
    case 1
        % DAS phase
        ttt = 'DAS Phase Spectrum';
        data = Theta2geo.sim.phase;
    case 2
        % DAS Relative Strain
        ttt = 'DAS Relative Strain Spectrum';
        data = Theta2geo.sim.relativeStrain;
    case 3
        % DAS Strain Rate
        ttt = 'DAS Strain Rate Spectrum';
        data = Theta2geo.sim.strainRate;
    case 4
        % DAS particle velocity
        ttt = 'DAS Particle Velocity Spectrum';
        data = Theta2geo.sim.vzFromDAS;
    case 5
        % DAS geophone
        ttt = 'DAS Geophone Spectrum';
        data = Theta2geo.sim.geo;
    case 6
        % True particle velocity
        ttt = 'True Particle Velocity Spectrum';
        data = Theta2geo.sim.Vz;
end

spec = abs(fft(data));
spec = spec ./ max(abs(spec));
freq = mkFFTfreq(Theta2geo.dt,Theta2geo.nsamples);
fmax = Theta2geo.f0 * 2;

mask = freq >=0 & freq <=fmax;

plot(  Theta2geo.h.axes_spectra,freq(mask),spec(mask),'k','linewidth',2)
set(   Theta2geo.h.axes_spectra,'fontsize',axesLabelSize,'fontweight','bold')

xlabel(Theta2geo.h.axes_spectra,'Frequency (Hz)')
title( Theta2geo.h.axes_spectra,ttt,'fontsize',titleLabelSize,'fontweight','bold')

Theta2geo.h.axes_spectra.Box = 'on';