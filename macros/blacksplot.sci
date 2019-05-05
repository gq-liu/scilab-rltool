function []=blacksplot();
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
// function displays blacks (magnitude vs phase) frequency plot
global g fminnyq fmaxnyq nyqstep Frunits gridon
//xset('window',1);
scf(2);clf(2);
//xbasc(1);
xname('Magnitude-Phase plot');
xinfo(['Change frequency units in Settings->Frequency units'])
modified_black(syslin('c',g),fminnyq,fmaxnyq,nyqstep,Frunits);
//black(syslin('c',g),fminnyq,fmaxnyq,nyqstep,Frunits);
		if gridon==1 then,
		chart(list(1)); // if grid on then superimpose on nichols grid
		end;
	
//return;

 
endfunction