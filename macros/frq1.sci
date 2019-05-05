function frq1(g_closedloop)
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
//function closed loop requency response (bode plot)
global fminbode fmaxbode bodestep Frunits
//xset('window',2)
scf(2);clf(2)
//xbasc();
//clf();
xinfo(['Select units in Settings->Frequency units'])
		if roots(denom(g_closedloop))<>[] then
					modified_bode(g_closedloop,fminbode,fmaxbode,bodestep,Frunits); 
                                        //bode(g_closedloop,fminbode,fmaxbode,bodestep,Frunits); 
// plot bode plot. Frunits stands for "units"
// Frunits = 'h' or 'r'
		end;	
//return;

endfunction