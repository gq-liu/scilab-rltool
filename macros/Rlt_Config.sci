function Rlt_Config()
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation; either version 2 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
// Authors
//   Holger Nahrstaedt -  2010
//   Ishan Pendharkar - 2001-2007
global g g_cont g_plant g_sensor  MAG FREQ CYCLES Frunits kevans s gridon
global last_time k f 
global choice  Knumber Frunits 
global kevans fminmag fmaxmag magstep fminnyq fmaxnyq 
global nyqstep fminbode fmaxbode bodestep tmax tstep 
global fminsens fmaxsens sensstep zeta wn gridon 
//************************************************************line 10******

ierr=1;
ierr=execstr('exec Rltool_Config-1.7.sci','errcatch');	
if ierr<>0 then,// if file could not be opened then...
//'// Loading your default settings file......'
mode(-1)
// Rltool ver-1.7 Configuration file. Edit with care, if at all!
gridon=0; // gridon = 0 (respectively 1) means grid off (respectively on)
diry=pwd(); // your present working directory
choice=1;   // choice=1 (respectively 2) means rootlocus mode (freq mode)
kevans=1000; // maximum gain in rootlocus plot
fminmag=0.01; //minimum frequency (rad/sec) for open loop bode plot
fmaxmag=1000; //maximum frequency (rad/sec) for open loop bode plot
magstep=0.01; //frequency step for open loop bode plot
fminnyq=0.01; // minimum frequency (rad/sec) for Nyquist and Nichols plots
fmaxnyq=1000; // Maximum frequency (rad/sec) for Nyquist and Nichols plots
nyqstep=0.01; // Frequency step for Nyquist and Nichols plots.
fminbode=0.01; // Minimum frequency (rad/sec) for closed loop bode plot
fmaxbode=1000; // Maximum frequency (rad/sec) for closed loop bode plot.
bodestep=0.01; // Frequency step for closed loop bode plot
tmax=5; // Maximum simulation time (sec) for dynamic responses
tstep=0.05; // time step (sec) for dynamic responses
fminsens=0.01;  // minimum frequency (rad/sec) for Sensitivity plot
fmaxsens=1000;  // maximum frequency (rad/sec) for Sensitivity plot
sensstep=0.01;	//frequency step for sensitivity plot
zeta=0.7;       // the damping ratio
wn=1;           // undamped natural frequency
MAG=1;          // Magnitude of sinusoidal test input
FREQ=1;         // Frequency (rad/sec) of sinusoidal test input
CYCLES=1;       // Number of cycles of sinusoidal test input
Knumber=3;      // Gain configuration (1) Gain in forward path (2) in feedback


//Lines 14 to 42 are to be written into a file
This_Path=get_function_path('Rlt_Config');
Var_List=mgetl(This_Path);
Var_List=Var_List(14:42,:);
mputl(Var_List,'Rltool_Config-1.7.sci');
else
	disp('....loaded your settings file. Rltool is configured!');
end;
return

endfunction
