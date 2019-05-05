function Update_Config_File()
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
//****************Default global values***********
global MAG FREQ CYCLES Frunits kevans s gridon
global g g_save g_cont g_plant g_sensor k  // k is the gain
global  choice // root locus or frequency design mode
global Knumber Frunits;
global kevans fminmag fmaxmag magstep fminnyq fmaxnyq nyqstep 
global fminbode fmaxbode bodestep tmax tstep fminsens fmaxsens sensstep zeta wn   
Var=['//Loading your default settings file....';
'mode(-1)';
'// Rltool ver-1.7 Configuration file. Edit with care, if at all!';
'numer_g_cont='+pol2str(numer(g_cont)*s^0)+' // numerator of controller';
'denom_g_cont='+pol2str(denom(g_cont)*s^0)+' // denominator of controller';
'g_cont=numer_g_cont/denom_g_cont;';
'numer_g_plant='+pol2str(numer(g_plant)*s^0)+' // numerator of plant';
'denom_g_plant='+pol2str(denom(g_plant)*s^0)+' // denominator of plant';
'g_plant=numer_g_plant/denom_g_plant;';
'numer_g_sensor='+pol2str(numer(g_sensor)*s^0)+' // numerator of plant';
'denom_g_sensor='+pol2str(denom(g_sensor)*s^0)+' // denominator of plant';
'g_sensor=numer_g_sensor/denom_g_sensor;';
'g=g_cont*g_plant*g_sensor // this is the plant';
'gridon='+string(gridon);' // gridon = 0 (respectively 1) means grid off (respectively on';
'choice='+string(choice);' // choice=1 (respectively 2) means rootlocus mode (freq mode)';
'kevans='+string(kevans);' // maximum gain in rootlocus plot';
'fminmag='+string(fminmag);' //minimum frequency (rad/sec) for open loop bode plot';
'fmaxmag='+string(fmaxmag);' //maximum frequency (rad/sec) for open loop bode plot';
'magstep='+string(magstep);' //frequency step for open loop bode plot';
'fminnyq='+string(fminnyq);' // minimum frequency (rad/sec) for Nyquist and Nichols plot';
'fmaxnyq='+string(fmaxnyq);' // Maximum frequency (rad/sec) for Nyquist and Nichols plot';
'nyqstep='+string(nyqstep);' // Frequency step for Nyquist and Nichols plots.';
'fminbode='+string(fminbode);' // Minimum frequency (rad/sec) for closed loop bode plot';
'fmaxbode='+string(fmaxbode);' // Maximum frequency (rad/sec) loop bode plot';
'bodestep='+string(bodestep);' // Frequency step for closed loop bode plot';
'tmax='+string(tmax);' // Maximum simulation time (sec) for dynamic responses';
'tstep='+string(tstep);' // time step (sec) for dynamic responses';
'fminsens='+string(fminsens);' // minimum frequency (rad/sec) for Sensitivity plot';
'fmaxsens='+string(fmaxsens);' // maximum frequency (rad/sec) for Sensitivity plot';
'sensstep='+string(sensstep);' //frequency step for sensitivity plot';
'zeta='+string(zeta);' // the damping ratio';
'wn='+string(wn);' // undamped natural frequency';
'MAG='+string(MAG);' // Magnitude of sinusoidal test input';
'FREQ='+string(FREQ);' // Frequency (rad/sec) of sinusoidal test input';
'CYCLES='+string(CYCLES);' // Number of cycles of sinusoidal test input';
'Knumber='+string(Knumber);' // Gain configuration (1) Gain in forward path (2) in feedback';
]
ierr=1;
ierr=execstr('mputl(Var,''Rltool_Config-1.7.sci'')','errcatch');
if ierr<>0 then,
	disp(['Error! I do not have write permission in '+pwd()]);
end;

//return;

endfunction