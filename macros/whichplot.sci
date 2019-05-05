function whichplot(gtr)
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
//RLTOOL for scilab (c) Ishan Pendharkar. 
//function selects the Design->rootlocus/frequency parameter.
global g  choice kevans fminmag fmaxmag magstep marked_handle Frunits gridon

if argn(2)==0 then,
gtr=g;
end;

//xset('window',0);
scf(0);
for i=1:5
  a=gca();
  delete(a);
end;
//xbasc(0);
//clf();
if choice==1 then // rootlocus mode
	//setmenu(0,'Measure');
	setmenu(0,'Grid');
	//setmenu(0,'Plant',[2])
	setmenu(0,'Plant',[3]);
	//setmenu(0,'Plant',[4]);
	setmenu(0,'Plant',[5]);
	//setmenu(0,'Response',[1]);
	//setmenu(0,'Response',[4]);
	//delmenu(0, 'Option');
        
		evans(syslin('c',gtr),kevans);
		if gridon==1 then 
		a=gca();
		set(a,'line_style',3);
		//xset('line style',3);
		xgrid(2); 
		//xset('line style',1);
		set(a,'line_style',1);
		end; // grid on	
else  // frequency domain design mode
	marked_handle=[];
	unsetmenu(0,'Grid'); // deactivate grid off.
	//unsetmenu(0,'Plant',[2])
	unsetmenu(0,'Plant',[3])
	//unsetmenu(0,'Plant',[4])
	unsetmenu(0,'Plant',[5]);
	//unsetmenu(0,'Response',[1]);
	//unsetmenu(0,'Response',[4]);
        
	//unsetmenu(0,'Measure');
	modified_bode(syslin('c',gtr),fminmag,fmaxmag,magstep,Frunits);
        //bode(syslin('c',gtr),fminmag,fmaxmag,magstep,Frunits);
end;
xinfo('''Rltool for Scilab'', Ver-1.7. Click on HELP menu for detailed online help');
//return;


endfunction
