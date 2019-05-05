function allsubplots()
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
// shows subplots of closed loop poles/zeros, step responses etc. 
//RLTOOL for scilab (c) Ishan Pendharkar. 
global g k g_sensor g_plant g_cont fminbode fmaxbode bodestep fminsens fmaxsens sensstep Frunits Knumber;
global handles
if k==[] then,
	k=get(handles.GainSlider,'value')
end;
if k==0 then,
	return;
end;
// no subplots are to be drawn if the point is not legitimate, i.e. not on root
// locus
		
setmenu(0, 'Response', [4]); // sets the details button on
select  Knumber 
	case 1 then,
	g_closedloop=syslin('c',numer(g)*k/(denom(g)+k*numer(g)));
	case 2 then,
	g_closedloop=syslin('c',numer(g)/(denom(g)+k*numer(g)));
	case 3 then,
	g_closedloop=syslin('c',k*numer(g_cont)*numer(g_plant)*denom(g_sensor)/(denom(g_cont)*denom(g_plant)*denom(g_sensor)+k*numer(g_cont)*numer(g_plant)*numer(g_sensor)));
	
end;
// closedloop for k in feedback or k in forward path
//***************** mark closed loop poles **********
	r=roots(denom(g_closedloop));
	markpoles(r);
//****************************************************
//xset('window',1);
scf(1);clf(1)
//xbasc();
xname('Rltool-1.7: closed loop plots');
//xset('wdim',200,400);
//xset('wpos',440,230);
f=get("current_figure");
set(f,'figure_position',[440,230]);
subplot(211)
	//bode(g_closedloop,fminbode,fmaxbode,bodestep); 
        modified_bode(g_closedloop,fminbode,fmaxbode,bodestep,Frunits); 
        xtitle('Frequency gain plot');
subplot(223)
	modified_gainplot(syslin('c',1/(1+k*g)),fminsens,fmaxsens,sensstep,Frunits);
	//gainplot(syslin('c',1/(1+k*g)),fminsens,fmaxsens,sensstep,Frunits);
	xtitle('Sensitivity plot');
subplot(224)
substep_response(g_closedloop); //'sub' means subplot.
xtitle('Unit step response');

//subplot(211)
//	modified_bode(g_closedloop,fminbode,fmaxbode,bodestep,Frunits); 
 //       xtitle('Frequency gain plot');


xinfo("Gain = "+ string(k)+ ". "+ isstable(g,k));
clear g_closedloop;
//return;

	
endfunction