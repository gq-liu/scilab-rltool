function arbit_response(g_closedloop,t,u)
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
//function simulate for piecewise linear inputs.
global gridon tstep
//check if input is NOT single-valued
[x,y]=size(t);
	for i=1:x-1
		if t(i+1)-t(i)<= 0 then
		messagebox(['Error entering input.';'Input is not single valued']);
		return;
		end;
	end;
	
// interpolate to get values of input 
	interp_u(1)=0;
	interp_t(1)=0;
	interp_size=ceil(max(t)/tstep);
	for i=1:interp_size
	interp_u(i)=interpln([t';u'],(i-1)*tstep)
	interp_t(i)=(i-1)*tstep;
	end;

// plotting interpolated values
	t=interp_t;
	u=interp_u;

		if roots(denom(g_closedloop))<>[] then
			resp=csim(u',t',g_closedloop); //this is the response vector
			plot2d(t,[resp' u],[1,2],leg="Response@Input");
					if gridon==1 then xgrid(4); end;
			xtitle('Dynamic Response','Time (sec)','Magnitude') 

		else
		messagebox(['Sorry! I cannot plot the response';'Due to numerical tolerances, a pole-zero cancellation has occured.';' Please reselect point.']);
		end;
		//xselect();
		show_window();
clear interp_t,interp_u,t,resp
//return


endfunction