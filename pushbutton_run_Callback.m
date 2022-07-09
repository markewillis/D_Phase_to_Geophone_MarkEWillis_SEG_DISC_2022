function pushbutton_run_Callback(hObject,eventdata,handles)
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

% *********************************************************
% turn off axes to animate the calculation
% *********************************************************

clearThisAxis(Theta2geo.h.axes_IQ)
clearThisAxis(Theta2geo.h.axes_phase)
clearThisAxis(Theta2geo.h.axes_unwrappedphase)
clearThisAxis(Theta2geo.h.axes_strain)
clearThisAxis(Theta2geo.h.axes_strainrate)
clearThisAxis(Theta2geo.h.axes_velocity)
clearThisAxis(Theta2geo.h.axes_geophone)

% *********************************************************
% delete arrows
% *********************************************************

deleteArrows

% *********************************************************
% create the data to display
% *********************************************************

Theta2geo.dt       = 0.0001;
Theta2geo.nsamples = 640000;
Theta2geo.time     = (1:Theta2geo.nsamples)*Theta2geo.dt;
Theta2geo.time0    = 32.;
Theta2geo.timeShifted = Theta2geo.time - Theta2geo.time0;

model.velocity = Theta2geo.apparentVelocity;
model.z0       = Theta2geo.apparentVelocity * Theta2geo.time0; 
model.f0       = Theta2geo.f0;
model.GL       = Theta2geo.gl;

model.omega0   = Theta2geo.omega0; 
model.damping  = Theta2geo.damping;

model.dt       = Theta2geo.dt;
model.nsamples = Theta2geo.nsamples;
model.time     = Theta2geo.time;
model.amps     = 1;

sim          = createSimulations(model);

% save a copy for global operations
Theta2geo.sim = sim;

lw = 2;

period = 1.0/Theta2geo.f0 * 2;

Theta2geo.timeStart = max(- 2*period,Theta2geo.timeShifted(  1));
Theta2geo.timeStop  = min(  2*period,Theta2geo.timeShifted(end));

trange = [Theta2geo.timeStart Theta2geo.timeStop];

axesLabelSize  = 12;
titleLabelSize = 16;

% set the gui time limits
Theta2geo.h.edit_startTime.Value = num2str(Theta2geo.timeStart);
Theta2geo.h.edit_stopTime.Value  = num2str(Theta2geo.timeStop);


% ***************************************
% plot the I & Q
% ***************************************

turnOnThisAxis(Theta2geo.h.axes_IQ)

plot(Theta2geo.h.axes_IQ,Theta2geo.timeShifted,sim.I,'k','linewidth',lw)
hold(Theta2geo.h.axes_IQ,'on')
plot(Theta2geo.h.axes_IQ,Theta2geo.timeShifted,sim.Q,'Color',[0.6350 0.0780 0.1840],'linewidth',lw)
hold(Theta2geo.h.axes_IQ,'off')
set(Theta2geo.h.axes_IQ,'fontsize',axesLabelSize,'fontweight','bold')
title(Theta2geo.h.axes_IQ,'I (black), Q (red)','fontsize',titleLabelSize,'fontweight','bold')
xlabel(Theta2geo.h.axes_IQ,'Time (s)')
xlim(Theta2geo.h.axes_IQ,trange)
maxV = max(abs(sim.wrappedphase))*1.1;
ylim(Theta2geo.h.axes_IQ,[-1 1]*maxV)
Theta2geo.h.axes_IQ.Box = 'on';

% plot arrow from IQ to phase
arrowRight(Theta2geo.h.axes_IQ,             Theta2geo.h.axes_phase,'Get wrapped phase from atan(Q/I)')


% ***************************************
% plot the wrapped phase
% ***************************************

turnOnThisAxis(Theta2geo.h.axes_phase)

plot(Theta2geo.h.axes_phase,Theta2geo.timeShifted,sim.wrappedphase,'k','linewidth',lw)
set(Theta2geo.h.axes_phase,'fontsize',axesLabelSize,'fontweight','bold')
title(Theta2geo.h.axes_phase,'Wrapped Phase','fontsize',titleLabelSize,'fontweight','bold')
xlabel(Theta2geo.h.axes_phase,'Time (s)')
ylabel(Theta2geo.h.axes_phase,'Radians')
xlim(Theta2geo.h.axes_phase,trange)
maxV = max(abs(sim.wrappedphase))*1.1;
ylim(Theta2geo.h.axes_phase,[-1 1]*maxV)
Theta2geo.h.axes_phase.Box = 'on';

% plot arrow from phase to unwrapped phase
arrowRight(Theta2geo.h.axes_phase,          Theta2geo.h.axes_unwrappedphase, 'Get phase by unwrapping the wrapped phase')


% ***************************************
% plot the unwrapped phase
% ***************************************

turnOnThisAxis(Theta2geo.h.axes_unwrappedphase)

plot(Theta2geo.h.axes_unwrappedphase,Theta2geo.timeShifted,sim.phase,'k','linewidth',lw)
set(Theta2geo.h.axes_unwrappedphase,'fontsize',axesLabelSize,'fontweight','bold')
title(Theta2geo.h.axes_unwrappedphase,'Phase','fontsize',titleLabelSize,'fontweight','bold')
xlabel(Theta2geo.h.axes_unwrappedphase,'Time (s)')
ylabel(Theta2geo.h.axes_unwrappedphase,'Radians')
xlim(Theta2geo.h.axes_unwrappedphase,trange)
maxV = max(abs(sim.phase))*1.1;
ylim(Theta2geo.h.axes_unwrappedphase,[-1 1]*maxV)
Theta2geo.h.axes_unwrappedphase.Box = 'on';

% plot arrow from unwrapped phase to strain
arrowRight(Theta2geo.h.axes_unwrappedphase, Theta2geo.h.axes_strain, 'Multiply phase by scalars to get relative strain')

% ***************************************
% plot the relative strain
% ***************************************

turnOnThisAxis(Theta2geo.h.axes_strain)

plot(Theta2geo.h.axes_strain,Theta2geo.timeShifted,sim.relativeStrain,'k','linewidth',lw)
set(Theta2geo.h.axes_strain,'fontsize',axesLabelSize,'fontweight','bold')
title(Theta2geo.h.axes_strain,'Relative Strain','fontsize',titleLabelSize,'fontweight','bold')
xlabel(Theta2geo.h.axes_strain,'Time (s)')
xlim(Theta2geo.h.axes_strain,trange)
maxV = max(abs(sim.relativeStrain))*1.1;
ylim(Theta2geo.h.axes_strain,[-1 1]*maxV)
Theta2geo.h.axes_strain.Box = 'on';

% plot arrow from strain to strain rate
arrowDown(Theta2geo.h.axes_strain, Theta2geo.h.axes_strainrate)

% ***************************************
% plot out the strain rate data
% ***************************************

turnOnThisAxis(Theta2geo.h.axes_strainrate)

plot(Theta2geo.h.axes_strainrate,Theta2geo.timeShifted,sim.strainRate,'k','linewidth',lw)
set(Theta2geo.h.axes_strainrate,'fontsize',axesLabelSize,'fontweight','bold')
xlim(Theta2geo.h.axes_strainrate,trange)
xlabel(Theta2geo.h.axes_strainrate,'Time (s)')
title(Theta2geo.h.axes_strainrate,'Strain Rate','fontsize',titleLabelSize,'fontweight','bold')
maxV = max(abs(sim.strainRate))*1.1;
ylim(Theta2geo.h.axes_strainrate,[-1 1]*maxV)
Theta2geo.h.axes_strainrate.Box = 'on';

% plot arrow from strain rate to velocity
arrowLeft(Theta2geo.h.axes_velocity, Theta2geo.h.axes_strainrate,'Get particle velocity by spatial or temporal integration of strain rate')

% ***************************************
% plot out the particle velocity data
% ***************************************

turnOnThisAxis(Theta2geo.h.axes_velocity)

plot(Theta2geo.h.axes_velocity,Theta2geo.timeShifted,sim.vzFromDAS,'k','linewidth',lw)
set(Theta2geo.h.axes_velocity,'fontsize',axesLabelSize,'fontweight','bold')
xlabel(Theta2geo.h.axes_velocity,'Time (s)')
title(Theta2geo.h.axes_velocity,'Particle Velocity','fontsize',titleLabelSize,'fontweight','bold')
xlim(Theta2geo.h.axes_velocity,trange)
maxV = max(abs(sim.vzFromDAS))*1.1;
ylim(Theta2geo.h.axes_velocity,[-1 1]*maxV)
Theta2geo.h.axes_velocity.Box = 'on';

% plot arrow from velocity to geophone
arrowLeft(Theta2geo.h.axes_geophone, Theta2geo.h.axes_velocity,'Get geophone trace by convolving particle velocity with geophone response')

% ***************************************
% plot out the geophone data
% ***************************************

turnOnThisAxis(Theta2geo.h.axes_geophone)

plot(Theta2geo.h.axes_geophone,Theta2geo.timeShifted,sim.geo,'k','linewidth',lw)
set(Theta2geo.h.axes_geophone,'fontsize',axesLabelSize,'fontweight','bold')
xlabel(Theta2geo.h.axes_geophone,'Time (s)')
title(Theta2geo.h.axes_geophone,'Geophone','fontsize',titleLabelSize,'fontweight','bold')
xlim(Theta2geo.h.axes_geophone,trange)
maxV = max(abs(sim.geo))*1.1;
ylim(Theta2geo.h.axes_geophone,[-1 1]*maxV)
Theta2geo.h.axes_geophone.Box = 'on';

% ***************************************
% plot out the spectra data
% ***************************************

turnOnThisAxis(Theta2geo.h.axes_spectra)

plotSpectra



function arrowRight(ax1, ax2,infoText)

global Theta2geo

dx = Theta2geo.h.figure1.Position(3);
dy = Theta2geo.h.figure1.Position(4);

x1 = ax1.Position(1) + ax1.Position(3);
x2 = ax2.Position(1);
xdistance = x2 - x1;

y = [1 1] * (ax1.Position(2) + ax1.Position(4) / 2) / dy;
x = [x1 + xdistance*.1, x2 - xdistance*.4]          / dx;

htext = uilabel(Theta2geo.h.figure1);
htext.Text = ' * ';
htext.FontSize = 20;
htext.FontWeight = 'bold';
htext.FontColor = [0.6350 0.0780 0.1840];
htext.BackgroundColor = [1 1 1];
htext.Position = [x(1)*dx (y(1)*dy+10) (x(2)-x(1))*dx 20];   
htext.Tooltip  = infoText;
htext.Tag = 'flowArrow';

%annotation(Theta2geo.h.figure1,'arrow',x,y,'Units','pixels','Color',[0.6350 0.0780 0.1840],'linewidth',5)
annotation(Theta2geo.h.figure1,'arrow',x,y,'Color',[0.6350 0.0780 0.1840],'linewidth',5,'Tag','flowArrow')

drawnow
pause(0.2)

function arrowLeft(ax1, ax2,infoText)

global Theta2geo

dx = Theta2geo.h.figure1.Position(3);
dy = Theta2geo.h.figure1.Position(4);

x1 = ax1.Position(1) + ax1.Position(3);
x2 = ax2.Position(1);
xdistance = x2 - x1;

y = [1 1] * (ax1.Position(2) + ax1.Position(4) / 2) / dy;
x = [x2 - xdistance*.4, x1 + xdistance*.1]          / dx;

htext = uilabel(Theta2geo.h.figure1);
htext.Text = ' * ';
htext.FontSize = 20;
htext.FontWeight = 'bold';
htext.FontColor = [0.6350 0.0780 0.1840];
htext.BackgroundColor = [1 1 1];
htext.Position = [x(2)*dx (y(1)*dy+10) abs(x(2)-x(1))*dx 20];   
htext.Tooltip  = infoText;
htext.Tag = 'flowArrow';


annotation(Theta2geo.h.figure1,'arrow',x,y,'Color',[0.6350 0.0780 0.1840],'linewidth',5,'Tag','flowArrow')

drawnow
pause(0.2)

function arrowDown(ax1, ax2)

global Theta2geo

dx = Theta2geo.h.figure1.Position(3);
dy = Theta2geo.h.figure1.Position(4);

y1 = ax1.Position(2);
y2 = ax2.Position(2) + ax2.Position(4);
ydistance = y2 - y1;

x = [1 1] * (ax1.Position(1) + ax1.Position(3) / 2) / dx;
y = [y1 + ydistance*.3, y2 - ydistance*.25]         / dy;

annotation(Theta2geo.h.figure1,'arrow',x,y,'Color',[0.6350 0.0780 0.1840],'linewidth',5,'Tag','flowArrow')

drawnow
pause(0.2)

function deleteArrows

tags = findall(0,'Tag','flowArrow');
if ~isempty(tags)
    for itag = 1:length(tags)
        delete(tags(itag))
    end
end


