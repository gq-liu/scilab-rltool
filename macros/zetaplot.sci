function zetaplot() 
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
//function draw zeta, wn line on rootlocus
global zeta wn;
labels=["zeta";"Undamped natural freq (rad.)"];
[ok,zeta,wn]=getvalue("Enter zeta and w_n",labels,list("vec",1,"vec",1),[string(zeta);string(wn)]);

	if ok==%t then
	//xset('window',0);
	scf(0);
	sgrid(zeta,wn,5); // plot zeta and w_n lines
	xinfo('Damping ratio: '+string(zeta)+' Undamped natural freq: '+string(wn) +' rad');
	end;	
//return;


endfunction