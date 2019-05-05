 function k=getgain(x,y)
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
// a main rltool code.
//*******************
//RLTOOL for scilab (c) Ishan Pendharkar. 
//function calculate gain corresponding to a point on rootlocus
global g k  choice handles
if choice==1 then // rootlocus gain calculations
		flag=0;
		check=0;
		p=[x y];	
		point=x+%i*y; // this is the complex point
		
		// case clicked on a open loop pole.
		r=roots(denom(g));
		[n,m]=size(r);
		
		for i=1:n, // Check if point is an open loop pole
			if abs(point-r(i))<Limits() then 
			check=1; 
			flag=1; 
			end;
		end;
		
		// case clicked on a open loop zero
		
		r=roots(numer(g));
		[n,m]=size(r);
		
		for i=1:n, // check if point is an open loop zero
			if abs(point-r(i))<Limits() then 
			check=1;
			flag=2; 
			end;
		end;
		
		if flag==0 then // if none, then calculate k
		        if clean(horner(denom(g),[1,%i]*p'))<> 0 then,
			k=real(horner(g,[1,%i]*p')); 
			k=-1/k;
			flag=3;
			end;
		end;
		// this k MAYNOT lie on rootlocus, check for this
		r=roots(denom(g)+k*numer(g));
		[n,m]=size(r);
		
		// Check whether point lies on root locus
							
		for i=1:n,
			if abs(point-r(i)) < Limits() then 
			check=1;
			index=i;
			p=[real(r(index)) imag(r(index))];
			
			if clean(horner(denom(g),[1,%i]*p'))<> 0 then,
				k=real(horner(g,[1,%i]*p')); 
				k=-1/k;
				flag=3;
			end;
			break;
			end;
		end;
	
if check<>0  then, //means the point indeed lies on the rootlocus
	if flag  == 3 & k > 0 then,  
				set(handles.GainSlider,'value',k);
				set(handles.ScaleValue,'string',"Gain= "+string(k));
		allsubplots(); // plots four subplots.. plzr, step, bode, sens.
	end;
		
	if flag==1 then,
	messagebox(['You clicked on a open-loop pole.';'Gain=0']);
	k=0;
	end;
	
	if flag==2 then,
  messagebox(['You clicked on a open-loop zero.';'Gain is infinity']);		k=[];
  	end;
	
	else
	xinfo('click on a point of the rootlocus to know the gain and roots');	
	k=get(handles.GainSlider,'value'); // retain the old value of gain
end;
clear r, point, check;		
else // magnitude plot calculations
xinfo(['Frequency  '+string(x)+' rad/sec'+' Magnitude '+string(y)+' dB']);
k=[];
end;
//return;

endfunction