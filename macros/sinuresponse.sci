function sinuresponse(g_closedloop)
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
//
//RLTOOL for scilab (c) Ishan Pendharkar. 
//function one time period of sine wave response and associated functions
global FREQ MAG CYCLES gridon Frunits ;
//xbasc();
//clf();
xname('Closed loop sinusoidal response');
xinfo('Simulating sinusoidal response. This may take a while....');
	if Frunits=='r' then, //convert to hz
	FREQ=FREQ/(2*%pi);
	end;
	T=1/FREQ*abs(CYCLES); //Time period in second
	t=0:(T/(30*CYCLES)):T;
	u=MAG*sin(2*%pi*FREQ*t);
	resp=csim(u,t,g_closedloop); //this is the response vector
	plot2d(t',[resp' u'],[1,2],leg="Response@Input");
			if gridon==1 then xgrid(4); 
			end;
xtitle('Sinusoidal Response','Time (sec)','Magnitude') 

if Frunits=='h' then,
msg='Amplitude ='+string(MAG)+ ' Frequency = '+string(FREQ)+' Hz.Click Settings-->Dynamic response to change.';
xinfo(msg);
else,
msg='Amplitude ='+string(MAG)+ ' Frequency = '+string(2*%pi*FREQ)+' rad/sec.Click Settings-->Dynamic response to change.';
xinfo(msg);
end;


clear t,resp;
//return;

endfunction 
 
 
