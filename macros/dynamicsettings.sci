function [ok,tmax,tstep]=dynamicsettings();
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
//function settings for various dynamic responses.
global MAG FREQ CYCLES tmax tstep Frunits

unit='rad/sec';
	if Frunits=='h' then,
	unit='Hz';
	end;

labels=["Max. Time for Closed loop dynamic response (sec)";
	"Step Size for discrete time in dynamic response (sec)";
	"Magnitude of sinusoidal input (scalar) ";
	"Frequency in "+unit;
	"Number of cycles (integer)  ";
	];
	
[ok,tmax,tstep,MAG,FREQ,CYCLES]=getvalue("dynamic response settings",labels,...
list("vec",1,"vec",1,"vec",1,"vec",1,"vec",1),[string(tmax);string(tstep);...
string(MAG);string(FREQ);string(CYCLES)]);
if ok==%t then
xinfo('Changing Default Settings');
else xinfo('Loaded Default Settings'); // if cancel is pressed load default
 tmax=5; 
 tstep=0.05;
 end;
Update_Config_File();
//return;


endfunction