function openGUI
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

% ************************************************************************************************************
% open the figure for the gui
% ************************************************************************************************************

% set up the default window size of the gui
xL =  240;    % left x value of the window
yB =   68;    % bottom y valule of the window
dx = 1255;    % width of the window
dy =  706;    % height of the window

% position = [ xL yB xR yT];
position = [ xL yB dx dy];

% define colors for the buttons
goGreen = [.81 .97 .71];
stopRed = [1 .7 .7];


axesHeight = 230;
axesWidth  = 201;

axesRow1   = 428;
axesRow2   = 137;

axesCol1   = 56;
axesCol2   = 367;
axesCol3   = 678;
axesCol4   = 988;

editRow    = 15;
textRow    = 42;

editRow    = 5;
textRow    = 30;

panelBottom = 10;
panelHeight = 80;


% ******************************************************************************************************************
% create the figure window for the gui
% ******************************************************************************************************************

Theta2geo.h.figure1 = uifigure('position',position,'Menubar','none','Color','white','Name',Theta2geo.compile.title);
% set(Theta2geo.h.figure1,'AutoResizeChildren','off');
% set(Theta2geo.h.figure1,'SizeChangedFcn',@resizeGUI);

% ******************************************************************************************************************
% create the gui title
% ******************************************************************************************************************

% create the gui label
Theta2geo.h.text_title = uilabel(Theta2geo.h.figure1);
Theta2geo.h.text_title.Text = 'Demonstrate Conversion from Phase to Geophone Response';
Theta2geo.h.text_title.FontWeight = 'Bold';
Theta2geo.h.text_title.FontSize   = 20;
Theta2geo.h.text_title.HorizontalAlignment   = 'center';
Theta2geo.h.text_title.BackgroundColor = [1 1 1];
Theta2geo.h.text_title.Position = [31 680 1135 28];     


% ******************************************************************************************************************
% create the IQ axes
% ******************************************************************************************************************

Theta2geo.h.axes_IQ = uiaxes(Theta2geo.h.figure1,'fontsize',14,'fontweight','bold','BackgroundColor','white', ...
                                              'Position',[axesCol1 axesRow1 axesWidth axesHeight]);


% ******************************************************************************************************************
% create the phase axes
% ******************************************************************************************************************

Theta2geo.h.axes_phase = uiaxes(Theta2geo.h.figure1,'fontsize',14,'fontweight','bold','BackgroundColor','white', ...
                                              'Position',[axesCol2 axesRow1 axesWidth axesHeight]);
                                          
% ******************************************************************************************************************
% create the unwrapped phase axes
% ******************************************************************************************************************

Theta2geo.h.axes_unwrappedphase = uiaxes(Theta2geo.h.figure1,'fontsize',14,'fontweight','bold','BackgroundColor','white', ...
                                              'Position',[axesCol3 axesRow1 axesWidth axesHeight]);
                                          
% ******************************************************************************************************************
% create the relative strain axes
% ******************************************************************************************************************

Theta2geo.h.axes_strain = uiaxes(Theta2geo.h.figure1,'fontsize',14,'fontweight','bold','BackgroundColor','white', ...
                                              'Position',[axesCol4 axesRow1 axesWidth axesHeight]);
                                          
% ******************************************************************************************************************
% create the strain rate axes
% ******************************************************************************************************************

Theta2geo.h.axes_strainrate = uiaxes(Theta2geo.h.figure1,'fontsize',14,'fontweight','bold','BackgroundColor','white', ...
                                              'Position',[axesCol4 axesRow2 axesWidth axesHeight]);
                                          
% ******************************************************************************************************************
% create the velocity axes
% ******************************************************************************************************************

Theta2geo.h.axes_velocity = uiaxes(Theta2geo.h.figure1,'fontsize',14,'fontweight','bold','BackgroundColor','white', ...
                                              'Position',[axesCol3 axesRow2 axesWidth axesHeight]);

% ******************************************************************************************************************
% create the geophone axes
% ******************************************************************************************************************

Theta2geo.h.axes_geophone = uiaxes(Theta2geo.h.figure1,'fontsize',14,'fontweight','bold','BackgroundColor','white', ...
                                              'Position',[axesCol2 axesRow2 axesWidth axesHeight]);
                                          
% ******************************************************************************************************************
% create the spectra axes
% ******************************************************************************************************************

Theta2geo.h.axes_spectra = uiaxes(Theta2geo.h.figure1,'fontsize',14,'fontweight','bold','BackgroundColor','white', ...
                                              'Position',[axesCol1 axesRow2 axesWidth axesHeight]);
                                          
% ******************************************************************************************************************
% create the spectra drop down list 
% ******************************************************************************************************************


Theta2geo.h.dropdown_spectra                 = uidropdown(Theta2geo.h.figure1);
Theta2geo.h.dropdown_spectra.Items           = {'DAS Phase', ...
                                                'DAS Relative Strain',...
                                                'DAS Strain Rate',...
                                                'DAS Particle Velocity',...
                                                'DAS Geophone',...
                                                'True Particle Velocity'};
Theta2geo.h.dropdown_spectra.ItemsData       = [1,2,3,4,5,6];
Theta2geo.h.dropdown_spectra.Value           = 4;
Theta2geo.h.dropdown_spectra.FontWeight      = 'Bold';
Theta2geo.h.dropdown_spectra.FontSize        = 14;
Theta2geo.h.dropdown_spectra.BackgroundColor = [1 1 1];
Theta2geo.h.dropdown_spectra.Position        = [20 (panelBottom+5+panelHeight) 285 20];   
Theta2geo.h.dropdown_spectra.ValueChangedFcn = @plotSpectra;
                                          

% ******************************************************************************************************************
% create the display options
% ******************************************************************************************************************

% create the angle option
Theta2geo.h.checkbox_angle                    = uicheckbox(Theta2geo.h.figure1);
Theta2geo.h.checkbox_angle.Text               = 'Angle of Incidence';
Theta2geo.h.checkbox_angle.FontWeight         = 'Bold';
Theta2geo.h.checkbox_angle.FontSize           = 14;
Theta2geo.h.checkbox_angle.Position           = [805 (textRow+10) 200 22];     
Theta2geo.h.checkbox_angle.ValueChangedFcn    = @checkbox_angle_Callback;

% create the geophone response option
Theta2geo.h.checkbox_geophone                 = uicheckbox(Theta2geo.h.figure1);
Theta2geo.h.checkbox_geophone.Text            = 'Geophone Specifications';
Theta2geo.h.checkbox_geophone.FontWeight      = 'Bold';
Theta2geo.h.checkbox_geophone.FontSize        = 14;
Theta2geo.h.checkbox_geophone.Position        = [805 (editRow+10) 200 22];   
Theta2geo.h.checkbox_geophone.ValueChangedFcn = @checkbox_geophone_Callback;

% ******************************************************************************************************************
% create the run button
% ******************************************************************************************************************

Theta2geo.h.pushbutton_run = uibutton(Theta2geo.h.figure1);
Theta2geo.h.pushbutton_run.Text = 'Run';
Theta2geo.h.pushbutton_run.FontWeight = 'Bold';
Theta2geo.h.pushbutton_run.FontSize   = 16;
Theta2geo.h.pushbutton_run.BackgroundColor = goGreen;
Theta2geo.h.pushbutton_run.Position = [1145 20 100 60];  
Theta2geo.h.pushbutton_run.Tooltip = 'Push to run this simulation';    
Theta2geo.h.pushbutton_run.ButtonPushedFcn = @pushbutton_run_Callback;

% ******************************************************************************************************************
% create the gauge length editable field
% ******************************************************************************************************************


% create panel around GL
Theta2geo.h.panel_GL                 = uipanel(Theta2geo.h.figure1);
Theta2geo.h.panel_GL.Title           = 'Gauge';
Theta2geo.h.panel_GL.FontWeight      = 'Bold';
Theta2geo.h.panel_GL.FontSize        = 12;
Theta2geo.h.panel_GL.BackgroundColor = [1 1 1];
Theta2geo.h.panel_GL.Position        = [20 panelBottom 90 panelHeight];      

% create the edit gauge length 
Theta2geo.h.edit_GL                     = uieditfield(Theta2geo.h.panel_GL);
Theta2geo.h.edit_GL.Value               = '12';
Theta2geo.h.edit_GL.FontWeight          = 'Bold';
Theta2geo.h.edit_GL.FontSize            = 12;
Theta2geo.h.edit_GL.BackgroundColor     = [1 1 1];
Theta2geo.h.edit_GL.Position            = [5 editRow 80 23];      
Theta2geo.h.edit_GL.Tooltip             = 'Enter the gauge length (m)';
Theta2geo.h.edit_GL.ValueChangedFcn     = @edit_GL_Callback;
Theta2geo.h.edit_GL.HorizontalAlignment = 'center';

% create the gauge length label
Theta2geo.h.text_GL                 = uilabel(Theta2geo.h.panel_GL);
Theta2geo.h.text_GL.Text            = 'Length (m)';
Theta2geo.h.text_GL.FontWeight      = 'Bold';
Theta2geo.h.text_GL.FontSize        = 12;
Theta2geo.h.text_GL.BackgroundColor = [1 1 1];
Theta2geo.h.text_GL.Position        = [5 textRow 80 26];     

% ******************************************************************************************************************
% create the center frequency editable field
% ******************************************************************************************************************

% create panel around frequency info
Theta2geo.h.panel_freq                 = uipanel(Theta2geo.h.figure1);
Theta2geo.h.panel_freq.Title           = 'Frequency';
Theta2geo.h.panel_freq.FontWeight      = 'Bold';
Theta2geo.h.panel_freq.FontSize        = 12;
Theta2geo.h.panel_freq.BackgroundColor = [1 1 1];
Theta2geo.h.panel_freq.Position        = [115 panelBottom 2*170 panelHeight];      


% create the edit center frequency
Theta2geo.h.edit_f0                     = uieditfield(Theta2geo.h.panel_freq);
Theta2geo.h.edit_f0.Value               = '70';
Theta2geo.h.edit_f0.FontWeight          = 'Bold';
Theta2geo.h.edit_f0.FontSize            = 12;
Theta2geo.h.edit_f0.BackgroundColor     = [1 1 1];
Theta2geo.h.edit_f0.Position            = [100 textRow 65 23];      
Theta2geo.h.edit_f0.Tooltip             = 'Enter the source center frequency';
Theta2geo.h.edit_f0.ValueChangedFcn     = @edit_f0_Callback;
Theta2geo.h.edit_f0.HorizontalAlignment = 'center';

% create the center frequency label
Theta2geo.h.text_f0                     = uilabel(Theta2geo.h.panel_freq);
Theta2geo.h.text_f0.Text                = 'Center (Hz):';
Theta2geo.h.text_f0.FontWeight          = 'Bold';
Theta2geo.h.text_f0.FontSize            = 12;
Theta2geo.h.text_f0.BackgroundColor     = [1 1 1];
Theta2geo.h.text_f0.Position            = [5 textRow 70 26];     


% ******************************************************************************************************************
% create the period field
% ******************************************************************************************************************

% create the period
Theta2geo.h.text_period                      = uilabel(Theta2geo.h.panel_freq);
Theta2geo.h.text_period.Text                 = '0.0143';
Theta2geo.h.text_period.FontWeight           = 'Bold';
Theta2geo.h.text_period.FontSize             = 12;
Theta2geo.h.text_period.BackgroundColor      = [1 1 1];
Theta2geo.h.text_period.Position             = [110 editRow 65 23];      
Theta2geo.h.text_period.Tooltip              = 'The center frequency converted to the period';

% create the period label
Theta2geo.h.text_periodLabel                 = uilabel(Theta2geo.h.panel_freq);
Theta2geo.h.text_periodLabel.Text            = 'Period (sec):';
Theta2geo.h.text_periodLabel.FontWeight      = 'Bold';
Theta2geo.h.text_periodLabel.FontSize        = 12;
Theta2geo.h.text_periodLabel.BackgroundColor = [1 1 1];
Theta2geo.h.text_periodLabel.Position        = [5 editRow 90 26];    

% ******************************************************************************************************************
% create the wavelength field
% ******************************************************************************************************************

% create the wavelength
Theta2geo.h.text_wavelength                      = uilabel(Theta2geo.h.panel_freq);
Theta2geo.h.text_wavelength.Text                 = '28.6';
Theta2geo.h.text_wavelength.FontWeight           = 'Bold';
Theta2geo.h.text_wavelength.FontSize             = 12;
Theta2geo.h.text_wavelength.BackgroundColor      = [1 1 1];
Theta2geo.h.text_wavelength.Position             = [(110+180) editRow 65 23];      
Theta2geo.h.text_wavelength.Tooltip              = 'The seismic wavelength of the wave';

% create the period label
Theta2geo.h.text_wavelengthLabel                 = uilabel(Theta2geo.h.panel_freq);
Theta2geo.h.text_wavelengthLabel.Text            = 'Wavelength (1/m):';
Theta2geo.h.text_wavelengthLabel.FontWeight      = 'Bold';
Theta2geo.h.text_wavelengthLabel.FontSize        = 12;
Theta2geo.h.text_wavelengthLabel.BackgroundColor = [1 1 1];
Theta2geo.h.text_wavelengthLabel.Position        = [(5+170) editRow 110 26];    

% ******************************************************************************************************************
% create the apparent velocity editable field
% ******************************************************************************************************************

% create panel around velocity info
Theta2geo.h.panel_velocity                 = uipanel(Theta2geo.h.figure1);
Theta2geo.h.panel_velocity.Title           = 'Velocity';
Theta2geo.h.panel_velocity.FontWeight      = 'Bold';
Theta2geo.h.panel_velocity.FontSize        = 12;
Theta2geo.h.panel_velocity.BackgroundColor = [1 1 1];
Theta2geo.h.panel_velocity.Position        = [(300+170-10) panelBottom (260-30) panelHeight];      

% create the edit apparent velocity
Theta2geo.h.edit_apparentVelocity                     = uieditfield(Theta2geo.h.panel_velocity);
Theta2geo.h.edit_apparentVelocity.Value               = '2000';
Theta2geo.h.edit_apparentVelocity.FontWeight          = 'Bold';
Theta2geo.h.edit_apparentVelocity.FontSize            = 12;
Theta2geo.h.edit_apparentVelocity.BackgroundColor     = [1 1 1];
Theta2geo.h.edit_apparentVelocity.Position            = [105 textRow 55 23];      
Theta2geo.h.edit_apparentVelocity.Tooltip             = 'Enter the apparent velocity';
Theta2geo.h.edit_apparentVelocity.ValueChangedFcn     = @edit_apparentVelocity_Callback;
Theta2geo.h.edit_apparentVelocity.HorizontalAlignment = 'center';

% create the apparent velocity label
Theta2geo.h.text_apparentVelocity                     = uilabel(Theta2geo.h.panel_velocity);
Theta2geo.h.text_apparentVelocity.Text                = 'Apparent (m/s):';
Theta2geo.h.text_apparentVelocity.FontWeight          = 'Bold';
Theta2geo.h.text_apparentVelocity.FontSize            = 12;
Theta2geo.h.text_apparentVelocity.BackgroundColor     = [1 1 1];
Theta2geo.h.text_apparentVelocity.Position            = [5 textRow 100 26];     

% ******************************************************************************************************************
% create the angle of incidence field
% ******************************************************************************************************************

% create the angle of incidence
Theta2geo.h.text_theta                      = uilabel(Theta2geo.h.panel_velocity);
Theta2geo.h.text_theta.Text                 = '0';
Theta2geo.h.text_theta.FontWeight           = 'Bold';
Theta2geo.h.text_theta.FontSize             = 12;
Theta2geo.h.text_theta.BackgroundColor      = [1 1 1];
Theta2geo.h.text_theta.Position             = [195 textRow 70 23]; 
Theta2geo.h.text_theta.Visible              = 'off';

% create the angle of incidence label
Theta2geo.h.text_thetaLabel                 = uilabel(Theta2geo.h.panel_velocity);
Theta2geo.h.text_thetaLabel.Interpreter     = 'latex';
Theta2geo.h.text_thetaLabel.Text            = '$\theta$:';
Theta2geo.h.text_thetaLabel.FontWeight      = 'Bold';
Theta2geo.h.text_thetaLabel.FontSize        = 12;
Theta2geo.h.text_thetaLabel.BackgroundColor = [1 1 1];
Theta2geo.h.text_thetaLabel.Position        = [170 textRow 20 26];   
Theta2geo.h.text_thetaLabel.Visible         = 'off';

% ******************************************************************************************************************
% create the true velocity editable field
% ******************************************************************************************************************

% create the edit true velocity
Theta2geo.h.edit_trueVelocity                     = uieditfield(Theta2geo.h.panel_velocity);
Theta2geo.h.edit_trueVelocity.Value               = '2000';
Theta2geo.h.edit_trueVelocity.FontWeight          = 'Bold';
Theta2geo.h.edit_trueVelocity.FontSize            = 12;
Theta2geo.h.edit_trueVelocity.BackgroundColor     = [1 1 1];
Theta2geo.h.edit_trueVelocity.Position            = [105 editRow 55 23];      
Theta2geo.h.edit_trueVelocity.Tooltip             = 'Enter the true velocity';
Theta2geo.h.edit_trueVelocity.ValueChangedFcn     = @edit_trueVelocity_Callback;
Theta2geo.h.edit_trueVelocity.Visible             = 'off';
Theta2geo.h.edit_trueVelocity.HorizontalAlignment = 'center';

% create the true velocity label
Theta2geo.h.text_trueVelocity                     = uilabel(Theta2geo.h.panel_velocity);
Theta2geo.h.text_trueVelocity.Text                = 'True (m/s):';
Theta2geo.h.text_trueVelocity.FontWeight          = 'Bold';
Theta2geo.h.text_trueVelocity.FontSize            = 12;
Theta2geo.h.text_trueVelocity.BackgroundColor     = [1 1 1];
Theta2geo.h.text_trueVelocity.Position            = [5 editRow 100 26];   
Theta2geo.h.text_trueVelocity.Visible             = 'off';



% ******************************************************************************************************************
% create the geophone omega editable field
% ******************************************************************************************************************

% create panel around geophone info
Theta2geo.h.panel_geophone                 = uipanel(Theta2geo.h.figure1);
Theta2geo.h.panel_geophone.Title           = 'Geophone';
Theta2geo.h.panel_geophone.FontWeight      = 'Bold';
Theta2geo.h.panel_geophone.FontSize        = 12;
Theta2geo.h.panel_geophone.BackgroundColor = [1 1 1];
Theta2geo.h.panel_geophone.Position        = [(570+125) panelBottom 100 panelHeight];   
Theta2geo.h.panel_geophone.Visible         = 'off';

% create the edit geophone omega
Theta2geo.h.edit_omega                     = uieditfield(Theta2geo.h.panel_geophone);
Theta2geo.h.edit_omega.Value               = '10';
Theta2geo.h.edit_omega.FontWeight          = 'Bold';
Theta2geo.h.edit_omega.FontSize            = 12;
Theta2geo.h.edit_omega.BackgroundColor     = [1 1 1];
Theta2geo.h.edit_omega.Position            = [30 textRow 60 23];      
Theta2geo.h.edit_omega.Tooltip             = 'Enter the geophone omega value (radians)';
Theta2geo.h.edit_omega.ValueChangedFcn     = @edit_omega_Callback;
Theta2geo.h.edit_omega.Visible             = 'off';
Theta2geo.h.edit_omega.HorizontalAlignment = 'center';

% create the geophone omega label
Theta2geo.h.text_omega                    = uilabel(Theta2geo.h.panel_geophone);
Theta2geo.h.text_omega.Interpreter        = 'latex';
Theta2geo.h.text_omega.Text               = '$f _{0}$';
Theta2geo.h.text_omega.FontWeight         = 'Bold';
Theta2geo.h.text_omega.FontSize           = 12;
Theta2geo.h.text_omega.BackgroundColor    = [1 1 1];
Theta2geo.h.text_omega.Position           = [5 textRow 20 26];     
Theta2geo.h.text_omega.Visible            = 'off';

% ******************************************************************************************************************
% create the geophone damping editable field
% ******************************************************************************************************************

% create the edit geophone damping
Theta2geo.h.edit_damping                    = uieditfield(Theta2geo.h.panel_geophone);
Theta2geo.h.edit_damping.Value              = '0.7';
Theta2geo.h.edit_damping.FontWeight         = 'Bold';
Theta2geo.h.edit_damping.FontSize           = 12;
Theta2geo.h.edit_damping.BackgroundColor    = [1 1 1];
Theta2geo.h.edit_damping.Position           = [30 editRow 60 23];      
Theta2geo.h.edit_damping.Tooltip            = 'Enter the geophone damping value';
Theta2geo.h.edit_damping.ValueChangedFcn    = @edit_damping_Callback;
Theta2geo.h.edit_damping.Visible            = 'off';
Theta2geo.h.edit_damping.HorizontalAlignment = 'center';

% create the geophone damping label
Theta2geo.h.text_damping                    = uilabel(Theta2geo.h.panel_geophone);
Theta2geo.h.text_damping.Interpreter        = 'latex';
Theta2geo.h.text_damping.Text               = '$\lambda$';
Theta2geo.h.text_damping.FontWeight         = 'Bold';
Theta2geo.h.text_damping.FontSize           = 12;
Theta2geo.h.text_damping.BackgroundColor    = [1 1 1];
Theta2geo.h.text_damping.Position           = [5 editRow 20 26];     
Theta2geo.h.text_damping.Visible            = 'off';

% ******************************************************************************************************************
% create the start time editable field
% ******************************************************************************************************************

% create panel around display time info
Theta2geo.h.panel_time                 = uipanel(Theta2geo.h.figure1);
Theta2geo.h.panel_time.Title           = 'Display Time';
Theta2geo.h.panel_time.FontWeight      = 'Bold';
Theta2geo.h.panel_time.FontSize        = 12;
Theta2geo.h.panel_time.BackgroundColor = [1 1 1];
Theta2geo.h.panel_time.Position        = [1000 panelBottom 135 panelHeight];      

% create the edit start time
Theta2geo.h.edit_startTime                     = uieditfield(Theta2geo.h.panel_time);
Theta2geo.h.edit_startTime.Value               = '0.8';
Theta2geo.h.edit_startTime.FontWeight          = 'Bold';
Theta2geo.h.edit_startTime.FontSize            = 12;
Theta2geo.h.edit_startTime.BackgroundColor     = [1 1 1];
Theta2geo.h.edit_startTime.Position            = [65 textRow 60 23];      
Theta2geo.h.edit_startTime.Tooltip             = 'Enter the starting time (sec)';
Theta2geo.h.edit_startTime.ValueChangedFcn     = @edit_startTime_Callback;
Theta2geo.h.edit_startTime.HorizontalAlignment = 'center';

% create the start time label
Theta2geo.h.text_startTime                  = uilabel(Theta2geo.h.panel_time);
Theta2geo.h.text_startTime.Text             = 'Start (s)';
Theta2geo.h.text_startTime.FontWeight       = 'Bold';
Theta2geo.h.text_startTime.FontSize         = 12;
Theta2geo.h.text_startTime.BackgroundColor  = [1 1 1];
Theta2geo.h.text_startTime.Position         = [5 textRow 55 26];    

% ******************************************************************************************************************
% create the stop time editable field
% ******************************************************************************************************************

% create the edit stop time
Theta2geo.h.edit_stopTime                     = uieditfield(Theta2geo.h.panel_time);
Theta2geo.h.edit_stopTime.Value               = '1.2';
Theta2geo.h.edit_stopTime.FontWeight          = 'Bold';
Theta2geo.h.edit_stopTime.FontSize            = 12;
Theta2geo.h.edit_stopTime.BackgroundColor     = [1 1 1];
Theta2geo.h.edit_stopTime.Position            = [65 editRow 60 23];      
Theta2geo.h.edit_stopTime.Tooltip             = 'Enter the starting time (sec)';
Theta2geo.h.edit_stopTime.ValueChangedFcn     = @edit_stopTime_Callback;
Theta2geo.h.edit_stopTime.HorizontalAlignment = 'center';

% % create the stop time label
Theta2geo.h.text_stopTime                 = uilabel(Theta2geo.h.panel_time);
Theta2geo.h.text_stopTime.Text            = 'Stop (s)';
Theta2geo.h.text_stopTime.FontWeight      = 'Bold';
Theta2geo.h.text_stopTime.FontSize        = 12;
Theta2geo.h.text_stopTime.BackgroundColor = [1 1 1];
Theta2geo.h.text_stopTime.Position        = [5 editRow 55 26];    