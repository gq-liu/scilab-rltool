function [gtr]=rl(gtr,UndoFlag)
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
//this function does input handling and processing of polynomials.
// major code... 
//global g  k gold g_save GainSlider; // this is the "undo" plant.


//THIS IS FUCK BUG: global marked_handle g// handle to mark poles on rootlocus
global marked_handle g
if argn(2)==0 then,
gtr=g;
end;

if argn()==1 then,
UndoFlag='do not save'
end;
if UndoFlag=='save' then,
saveundo(g_save);// save the previous version for undo
end;

gold=gtr
//*********dialog*****************
txt=['Numerator: p(s)'; 'Denominator: q(s)  '];
//n=pol2str(numer(gtr)*%s^0);
n=pol2str(gtr.num*%s^0);
//d=pol2str(denom(gtr)*%s^0);
d=pol2str(gtr.den*%s^0);
ErrorFlag=1;//error checking flag.
while ErrorFlag<>0
[ok,n,d]=getvalue('enter transfer function p(s)/q(s) with p(s),q(s) polynomials in s',txt,...
 list("str",[1,1],"str",[1,1]),[string(n);string(d)]);
	if ok==%f then,
	ErrorFlag=0
	gtr=[]
	return;
	else //meaning OK=true
	[n,ierr1]=evstr(n+'*%s^0');
	[d,ierr2]=evstr(d+'*%s^0');
	ErrorFlag=ierr1*ierr2;	

//messagebox(size(n));
//if type(n)==2 & type(d)==2 & type(n.den)==1 & type(n.den)==1 & size(n)==[1 1] & size(d)==[1 1] then,  
if type(n)==2 & type(d)==2 & size(n)==[1 1] & size(d)==[1 1] then,
			gtr=n/d; // valid gtr if and only if it passes all these tests.
			ErrorFlag=0;
			marked_handle=[];
			messagebox('REACH HERE');
			return gtr;	

	else
				messagebox('Error entering input');
				d=pol2str(gold.den);
				n=pol2str(gold.num);
	end;
	end;
end;

//**************************

endfunction


 
