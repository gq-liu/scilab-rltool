function displayalldetails()
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
// Function displays numerical values of pole-zero plots.
// input open loop plant and current value of gain k
// output pole zero locations and step response details
// author Ishan Pendharkar. Developed for RLTOOL ver 1.4 
// Date 29 June 2004.
// Last modified same as above. by author.
global g k oldk tstep tmax Knumber;

if k==0|k==[] then, // no details if the point doesn't lie on rootlocus.
xinfo(['You selected gain '+string(oldk)]);
k=oldk;
end;

if Knumber ==1 then,
	g_closedloop=g*k/(1+g*k); // unity feedback configuration
else,
	g_closedloop=g/(1+k*g); // k in feedback
end;
// closed loop for k in feedback or forward path
	if denom(g_closedloop)==[] then,
	xinfo('Cannot simulate step response');
	return;
	end;
CLZ_POLES=string(roots(denom(g_closedloop))); 
CLZ_ZEROS=string(roots(numer(g_closedloop)));
button=messagebox(['Gain = '+string(k);'Closed loop pole(s):';CLZ_POLES;'zero(s)';CLZ_ZEROS],"details","question",['Close','Step'],"modal");
// dialog to display poles and zeros

if button==1 then, // if close is pressed...	
		return;
end;
		// else... display step details
			g_closedloop=syslin('c',g_closedloop);
			t=0:2*tstep:tmax;
			resp=csim('step',t,g_closedloop); // simulate
			stepdetails(resp); // calculate parameters
			clear t,g_closedloop,resp;

return;

endfunction