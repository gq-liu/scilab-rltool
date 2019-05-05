function ramp_response(g_closedloop)	
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
//function closed loop ramp response
global gridon tstep tmax
//xbasc();
//clf();
xname('Closed loop ramp response');
if roots(denom(g_closedloop))<>[] then
			
			t=0:tstep:tmax;
		resp=csim(t,t,g_closedloop) //this is the response vector
			plot2d([t',t'],[resp',0*t']);
			if gridon==1 then xgrid(4); end;

			xtitle('Ramp Response','Time (sec)','Magnitude') 

		else
messagebox(['Sorry! I cannot plot the ramp response';'Due to numerical tolerances, a pole-zero cancellation has occured.';' Please reselect point.']);
		end;
	
clear t,resp;
//return;

endfunction


