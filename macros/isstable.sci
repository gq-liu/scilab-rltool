function nrhp=isstable(g , k);
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
//function isstable checks whether closed loop system is stable.

nrhp='The closed loop system is stable.'
g=g;
cls_loop=denom(g);
cls_loop=cls_loop+k*numer(g); // characteristic polynomial of closed loop tf
cls_loop=roots( cls_loop );
[n,m]=size(cls_loop);
for i=1:n,
if real( cls_loop(i) ) > 0 then , // check if any root in right half plane
	nrhp='The closed loop system is not stable.';
	return;	
	end;
end;
clear cls_loop;
//return;
   

  
endfunction