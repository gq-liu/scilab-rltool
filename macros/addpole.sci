function addpole()
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
//function adds a pole to existing plant.
global g g_cont g_sensor g_plant marked_handle g_save
//xset('window',0);
scf(0);
p=locate(1,1);
p=clean(p,Limits()); // locate point and "clean" it
if clean(p(2),Limits())==0 then
	gtr_cont=g_cont/(%s-p(1)); // add real pole
else
	gtr_cont=g_cont/((%s-p(1))^2+p(2)^2); // add complex pole and conjugate
end;
gtr=(gtr_cont*g_plant*g_sensor);
whichplot(gtr); // update rootlocus plot
gtr=rl(gtr);   // edit plant to truncate spurious entries
if gtr<>[] then,
	Update_Config_File();
	g_cont=gtr_cont
	g=gtr;
else
	whichplot(g);
end;
marked_handle=[]
clear gtr gtr_cont;
//return;
 
endfunction