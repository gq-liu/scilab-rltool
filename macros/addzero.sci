function addzero()
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
//function adds a zero to the existing plant.
global g g_cont g_sensor g_plant marked_handle choice
if choice<>1 then return;end; // you cannot add zero in frequency design mode
//xset('window',0);
scf(0)
p=locate(1,1); // locate zero and clean it
p=clean(p,Limits());
if clean(p(2),Limits())==0 then
	gtr_cont=g_cont*(%s-p(1)); // real zero is added
else 
	gtr_cont=g_cont*((%s-p(1))^2+p(2)^2); // complex zero and its conjugate is added
end;
gtr=gtr_cont*g_plant*g_sensor
whichplot(gtr); // update rootlocus plot
gtr=rl(gtr); // edit new plant
if gtr<>[] then,
	g_cont=gtr_cont
	g=gtr;
else
	whichplot(g);
end;
marked_handle=[]
clear gtr gtr_cont;
//return;
endfunction