function [ok,fminnyq,fmaxnyq,nyqstep]=nyqsettings();
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
//function settings for nyquist plot.
global fminnyq fmaxnyq nyqstep Frunits
if Frunits=='r' then, // which frequency unit?
	UNITS='rad/sec';
else,
	UNITS='hz';
end;


labels=["Min. Frequency for Nyquist/Nichols plot ("+UNITS+")";
	"Max. Frequency for Nyquist/Nichols plot ("+UNITS+")";
	"Step Size for frequency in Nyquist/Nichols plot ("+UNITS+")";
	];
// dialog for entering data	
[ok,fminnyq,fmaxnyq,nyqstep]=getvalue("Nyquist and Nichols plot Settings",labels,...
list("vec",1,"vec",1,"vec",1),[string(fminnyq);string(fmaxnyq);string(nyqstep)]);
//xselect();
show_window(0);
if ok==%t then // ok is pressed
xinfo('Changing Default Settings');
else xinfo('Loaded Default Settings');
 fminnyq=0.01; // cancel is pressed
 fmaxnyq=1000;
 nyqstep=0.01;	
 end;
clear UNITS;
Update_Config_File();
//return;

endfunction

