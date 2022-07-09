function [model] = createSimulations(model)
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
debug = false;

scaleFactor = 1.0/1000;
scaleFactor = 1.0/1000000;

% create master wavelet at depth

model.Vz = mkTraceRicker(model.z0/model.velocity,model.nsamples,model.dt,model.f0,model.amps) * scaleFactor;

% make two wavelets apart by GL

shallowTime = (model.z0-model.GL/2)/model.velocity;
deepTime    = (model.z0+model.GL/2)/model.velocity;

if debug
    disp(['Shallow time = ' num2str(shallowTime) ', deep time = ' num2str(deepTime) ', diff = ' num2str(deepTime-shallowTime)])
end

model.VzUp = mkTraceRicker(shallowTime,model.nsamples,model.dt,model.f0,model.amps) * model.velocity * scaleFactor;
model.VzDn = mkTraceRicker(deepTime,   model.nsamples,model.dt,model.f0,model.amps) * model.velocity * scaleFactor;

% create the DAS signal - strain rate
model.strainRate = (model.VzDn - model.VzUp )/model.GL;

% create the vertical particle velocity from the DAS strain rate signal
model.vzFromDAS      = -1*cumsum(model.strainRate)*model.dt*model.velocity;

% create the relative strain from the DAS strain rate signal
model.relativeStrain = -1*cumsum(model.strainRate)*model.dt;

xsi  = 0.78;
n    =  1.444;
lambda = 1550*10^(-9);

model.phase          = model.relativeStrain * 4*pi*n*model.GL*xsi/lambda;

model.wrappedphase = atan(tan(model.phase));

model.I = cos(model.wrappedphase);
model.Q = sin(model.wrappedphase);

omega0  = model.omega0;
damping = model.damping;

% create the frequency values of the spectrum
freq = mkFFTfreq(model.dt,model.nsamples);
% convert freq to omega
omega = 2.*pi*freq;

% take FFT of the Vz trace
VzFFT  = fft(model.vzFromDAS);

% convolve the VZ with the geophone response
GeoFFT = velocity(omega,omega0,damping).*VzFFT;
model.geo    = -1*real(ifft(GeoFFT));

return

function [out] = velocity(omega,omega0,damping)


out =  (omega.^2)./(-1.*omega.^2 + 2*1i*damping*omega*omega0 + omega0^2);