function undo()
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
//function lets you undo one change to open loop plant. 
global g g_cont g_plant g_sensor 
ierr=1;
if ierr<> 0 // open Rltool-1.6_Config.sci and read g. this is the "old" g
	ierr=execstr("exec Rltool_Config-1.7.sci" ,'errcatch');
	if ierr<>0 then messagebox("Warning! Cannot undo change. No previous data available.");
	end;
end;
whichplot(g);
//return


endfunction