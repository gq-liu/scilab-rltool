function [ok,fminbode,fmaxbode,bodestep]=bodesettings()
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
//function settings for bode plot

global fminbode fmaxbode bodestep Frunits
if Frunits=='r' then, // which frequency units ?
	UNITS='rad/sec';
else,
	UNITS='hz';
end;

labels=["Min. Frequency for Bode plot ("+UNITS+")";
	"Max. Frequency for Bode Plot ("+UNITS+")";
	"Step size for frequency in Bode plot ("+UNITS+")"
	];
// dialog to input data
[ok,fminbode,fmaxbode,bodestep]=getvalue("Closed loop Bode plot Settings",labels,...
list("vec",1,"vec",1,"vec",1),[string(fminbode);string(fmaxbode);string(bodestep)]);
if ok==%t then
xinfo('Changing Default Settings');
else xinfo('Loaded Default Settings'); // if "cancel" load default data
 fminbode=0.01; 
 fmaxbode=1000; 
 bodestep=0.01;
 end;
clear UNITS;
Update_Config_File();
//return;


endfunction