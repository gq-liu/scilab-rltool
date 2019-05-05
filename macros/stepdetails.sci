function stepdetails(resp)
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
//function calculates response parameter of step response. 
// resp is the response vector computed by csim
[m,n]=size(resp);
flag=0;
finval=resp(n); //final value
ess=string(clean(1-abs(finval),1e-5)); // steady state erorr
[overshoot,tpeak]=max(resp);  // peak overshoot (if at all!!)

	if( clean(abs(overshoot-finval),1e-4) >0 &  (finval*overshoot)>0 )  then
		flag=1; //YES there is overshoot!
		perovershoot=string((overshoot-finval)/finval*100); //percentage over shoot
		tpeak=string(tpeak*tstep); //peak time
	else perovershoot='No Overshoot';
	     tpeak= 'None';
	end;
//****************damping ration calculations
if flag==1 then //there is overshoot
tmp=(%pi/(log(overshoot-finval)))^2+1;
tmp=1/tmp;
zeta=string(sqrt(tmp));
else
zeta='overdamped'
end	
//*********Settling time calculations************************
band=0.03*abs(resp(n)) // 3% tolerance band
for i=1:n-2
		if (abs( resp(n)-resp(n-i) )) >band then,
			ts=string((n-i)*tstep);
			tmp=n-i;
			break
		else ts='Couldnot resolve settling time.'
		tmp=0;
		end;
end;
if tmp>n-5 then ts='not settled. Select a larger time.';
tmp=[];
end;	

if tmp<>[] then, // if not unstable then display!
messagebox([
'Final Value (on the plot):        '+string(finval);
'Error (as seen on plot):          '+ess;
'Percent Peak Overshoot :          '+perovershoot;
'Damping ratio (2nd order approx): '+zeta;
'Peak Time (sec):                  '+tpeak ;
'Setting Time (sec):               '+ts ;
'                                           '],"modal");
else
messagebox(['System is unstable or output has not settled';'Increase simulation time in Settings->Step Response'],"modal");
end;

//return


endfunction
