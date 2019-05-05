function [ok,fminmag,fmaxmag,magstep]=magsettings();
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
//function settings for magnitude (frequency) plot.
global fminmag fmaxmag magstep Frunits g
if Frunits=='r' then, // which frequency units?
	UNITS='rad/sec';
else,
	UNITS='hz';
end;

labels=["Min. Frequency for Magnitude plot ("+UNITS+")";	
	"Max. Frequency for Magnitude plot ("+UNITS+")";
	"Step Size for magnitude plot response ("+UNITS+")"
	];
// dialog for entering data	
[ok,fminmag,fmaxmag,magstep]=getvalue("Frequency magnitude plot Settings",labels,...
list("vec",1,"vec",1,"vec",1),[string(fminmag);string(fmaxmag);string(magstep)]);
//xselect();
show_window(0);
if ok==%t then // ok is pressed
whichplot(g);
xinfo('Changing Default Settings');
else xinfo('Loaded Default Settings');
 fminmag=0.01; // cancel is pressed
 fmaxmag=1000; 
 magstep=0.01;	
end;

Update_Config_File();
//return;

endfunction