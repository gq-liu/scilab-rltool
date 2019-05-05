function g=addplant();
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
//function addplant lets you add a cascade to existing plant.
// if G(s) is the current open loop plant, you add a cascade H(s) to make 
// the resulting plant G(s)H(s).
global g marked_handle
g_casc=1/s;
g_casc=rl(g_casc);
if g_casc<>[] then,
	gtr=g*g_casc;
	whichplot(gtr);
	gtr=rl(gtr);
	if gtr<>[] then,
		g=gtr;
	else
		whichplot(g);
	end;
end;	
marked_handle=[]
clear gtr;		
//return

endfunction