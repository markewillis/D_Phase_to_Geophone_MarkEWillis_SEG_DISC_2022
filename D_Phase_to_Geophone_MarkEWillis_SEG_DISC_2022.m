function D_Phase_to_Geophone_MarkEWillis_SEG_DISC_2022
%
% This gui demonstrates the conversion from phase to strain to strain rate to particle velocity to geophone response
%
%
%
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

% **********************************************************************************************
% Create the default title of the gui
% **********************************************************************************************


releaseName = [];

if isempty(releaseName)
    Theta2geo.releaseTitle = 'DASPhase2Geo - 2022 SEG DISC (Mark Willis)';
else
    Theta2geo.releaseTitle = ['DASPhase2Geo - Exclusively released to ' releaseName ' by Mark Willis for testing. '];
end

Theta2geo.compile.title = Theta2geo.releaseTitle;


% create the gui with objects in default locations
openGUI;


% set the default values
openingFunction;
