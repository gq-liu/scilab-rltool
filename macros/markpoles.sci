function markpoles(r)
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
//function markpoles(r) marks all closed loop poles on the rootlocus.
global marked_handle choice;
if choice<> 1 then,
	return; // no marking if not rootlocus mode
end;
if marked_handle<>[] then,
marked_handle.visible='off';
end;
x=real(r);
y=imag(r);
//xset('window',0);
scf(0);
xset("mark size",1)
plot2d(x,y,-3,frameflag=7,logflag='nn');
marked_handle=get("hdl")
//return;




endfunction