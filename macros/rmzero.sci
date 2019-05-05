function rmzero()
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
//function delete a zero from the plant
global g g_cont g_plant g_sensor marked_handle Knumber
//xset('window',0);
scf(0)
flag=0;

p=locate(1,1);
p=clean(p,Limits()); // this is the mouse click...
p=p(1)+%i*p(2); // and the corresponding complex point

if Knumber<>3 then,
r=roots(numer(g));
else 
r=roots(numer(g_cont));
end;
[n,m]=size(r);
if n*m==0 then, //empty roots
	return;
end;
for i=1:n, // did you really click on a zero??......
	if abs(p-r(i))< Limits() then, p=r(i); flag=1;
	end;
end;

if flag==0 then // No you didn't!!....
//xselect(); 
show_window(0);
xinfo('click on a zero to remove it');
end;

if flag==1 then, // YES it is indeed a zero!! 

	if imag(p)==0 then gtr_cont=g_cont/(s-real(p));
	else gtr_cont=g_cont/((%s-real(p))^2+imag(p)^2); // remove it!
	end;
	gtr=clean(gtr_cont*g_plant*g_sensor,1e-5);
	whichplot(gtr); // update plots.
	gtr=rl(gtr);   // confirm this change
	if gtr<>[] then,
	g_cont=gtr_cont
	g=gtr;
	else
	whichplot(g);
	end;
end;
marked_handle=[]
clear gtr gtr_cont;
//return;
endfunction