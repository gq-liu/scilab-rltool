function rmpole()
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
//function delete a pole from the plant
global g g_cont g_plant g_sensor marked_handle Knumber
//xset('window',0);
scf(0);
flag=0;

p=locate(1,1); // read mouse position and clean it
p=clean(p,Limits());
p=p(1)+%i*p(2); // this is the complex point u clicked.

if Knumber<> 3 then,
r=roots(denom(g));
else,
r=roots(denom(g_cont));
end;
[n,m]=size(r);

if n*m==0 then, // empty string
return;
end;

for i=1:n,
	if abs(p-r(i))< Limits() then, p=r(i); flag=1;end;
end; // did you really click on a pole??......

if flag==0 then 
	show_window(0);
	xinfo('click on a pole to remove it'); // no you didn't!!
end;


if flag==1 then, // modify only if flag is affected. // Yes! It is a pole!
	if imag(p)==0 then gtr_cont=g_cont*(s-real(p));
	else gtr_cont=g_cont*((%s-real(p))^2+imag(p)^2); // remove it!
	end;
	gtr=gtr_cont*g_plant*g_sensor;
	whichplot(gtr); // update plots
	gtr=rl(gtr); // confirm the change.
	if gtr<>[] then,
	g_cont=gtr_cont;
	g=gtr;
	else
	whichplot(g);
	end;
 
end;
marked_handle=[]
clear gtr gtr_cont;
//return;

endfunction