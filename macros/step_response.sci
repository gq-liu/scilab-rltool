function step_response(g_closedloop)	
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
//function plots step response of closed loop plant.
global gridon tstep tmax;
//xbasc();
//clf();
xname('Closed loop step response');
 if roots(denom(g_closedloop)) <>[] then

			t=0:tstep:tmax;
			resp=csim('step',t,g_closedloop);
			if tmax<1e-4 then,
			plot2d([1e6*t'],[resp],logflag='nn');
			xtitle('Impulse Response','Time (Micro sec)','Magnitude')
			else
			plot2d([t'],[resp],logflag='nn');
			xtitle('Impulse Response','Time (sec)','Magnitude');
			end;		
		else
		messagebox(['Sorry! I cannot plot the step response';'Due to numerical tolerances, a pole-zero cancellation has occured.';' Please reselect point.']);
		end;
			//xselect();
		show_window();
				
clear t,resp;
//return


endfunction