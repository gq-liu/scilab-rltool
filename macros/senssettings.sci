function [ok,fminsens,fmaxsens,sensstep]=senssettings();
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
//function settings for sensitivity plot
global fminsens fmaxsens sensstep Frunits
if Frunits=='r' then, // which frequency units?
	UNITS='rad/sec';
else,
	UNITS='hz';
end;

labels=["Min. Frequency for Sensitivity plot ("+UNITS+")";	
	"Max. Frequency for Sensitivity plot ("+UNITS+")";
	"Step Size for Sensitivity plot response ("+UNITS+")"
	];
// dialog for entering data	
[ok,fminsens,fmaxsens,sensstep]=getvalue("Sensitivity plot Settings",labels,...
list("vec",1,"vec",1,"vec",1),[string(fminsens);string(fmaxsens);string(sensstep)]);
//xselect();
show_window(0);
if ok==%t then // OK is pressed.
xinfo('Changing Default Settings');
else xinfo('Loaded Default Settings');
 fminsens=0.01; // CANCEL is pressed
 fmaxsens=1000; 
 sensstep=0.01;	
end;
clear UNITS;
Update_Config_File();
//return;
endfunction
