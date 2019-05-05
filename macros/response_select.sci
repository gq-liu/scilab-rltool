function response_select();
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
//function response_select gives a menu for closed loop response selection.
global k g g_cont g_plant g_sensor Knumber tstep tmax;
	if k<=0 then, 
		xinfo('Select a point on the root locus');
		//xset('window',0)
		scf(0);clf(0);
		status=xclick();
		p=clean([status(2) status(3)],Limits());
		k=getgain(p(1),p(2)) // compute gain on root locus
			if k > 0 then, // bona-fide point. Mark all poles
			xinfo("Gain = "+ string(k));
			else,
			return; // no bona fide point selected
			end;
	end;
//selection of response
whichresponse=1;
stability=isstable(g,k); //check whether closed loop system is stable.
while whichresponse<> 0 & k > 0, 
whichresponse=x_choose([
'Impulse Response';
'Step Response';
'Ramp Response';
'Arbitrary Input';
'Sinusoidal input';
'----------';
'Bode plot';
'Sensitivity plot';
'----------';
'Closed loop poles';
'Step response parameters'
],['Gain = +string(k)';stability;'Select required closed loop response']);
//

select  Knumber 
	case 1 then,
	g_closedloop=syslin('c',numer(g)*k/(denom(g)+k*numer(g)));
	case 2 then,
	g_closedloop=syslin('c',numer(g)/(denom(g)+k*numer(g)));
	case 3 then,
	g_closedloop=syslin('c',k*numer(g_cont)*numer(g_plant)*denom(g_sensor)/(denom(g_cont)*denom(g_plant)*denom(g_sensor)+k*numer(g_cont)*numer(g_plant)*numer(g_sensor)));
	
end;


	r=roots(denom(g_closedloop));
			if whichresponse==0 then,
			xdel(2) // delete all open windows
			end;
			
			if whichresponse==1 then,
			//xset('window',2);
			scf(2);clf(2);
			xname('Closed loop Impulse response');
			impulse_response(g_closedloop);
			end;
						
			if whichresponse==2 then,
			//xset('window',2);
			scf(2);clf(2);
			xname('Closed loop step response');
			step_response(g_closedloop)
			end;

			if whichresponse==3 then,
			//xset('window',2);
			scf(2);clf(2);
			xname('Closed loop ramp response');
			ramp_response(g_closedloop);
			end;
			
			if whichresponse==4 then,
			//xset('window',2);
                        scf(2);clf(2);
	xinfo('Draw piece-wise continuous signal and click Edit-->OK')
			xname('Edit input');
 			[t,u,ok,gc] = edit_curv();
			//xset('window',2);
                        scf(2);clf(2);
			xname('Closed loop response');
				if ok == %t & u<>[] then,
				arbit_response(g_closedloop,t,u);
				end;
			end;
			
			if whichresponse==5 then,
			//xset('window',2);
                        scf(2);clf(2);
			xname('Closed loop sinusoidal response');
			sinuresponse(g_closedloop);
			end;
			
			if whichresponse==6 then,
			end; //do nothing
			
			if whichresponse==7 then,
			//xset('window',2);
                        scf(2);clf(2);
			xname('Closed loop Bode plot');
			frq1(g_closedloop);
			end;
			
			if whichresponse==8 then,
			//xset('window',2);
                        scf(2);clf(2);
			xname('Sensitivity plot');
			sens(g,k);
			end;
			
			if whichresponse==9 then,
			end; //do nothing
			
			if whichresponse==10 then,
			//messagebox(string(r));
                        polezeroplot(g_closedloop);
			end;

			if whichresponse==11 then,
			t=0:tstep:tmax;
			resp=csim('step',t,g_closedloop);
			stepdetails(resp);
			end;
						     
//else
xinfo('click on a point of the rootlocus');
end;				
//return;
endfunction
   

