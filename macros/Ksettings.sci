function Ksettings()
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
global Knumber;
tmp=x_choose(['K in forward path';'K in feedback path';'Standard Control Loop'],['Select configuration';'of the gain K']);
select tmp
case 0 then,
	return;
case 1 then,
	callbk_fwd()
	xinfo(['Loaded default configuration. Gain in forward path']); 
case 2 then,
	callbk_fbk()
	xinfo (['Configuration changed. Gain in feedback path']);
case 3 then,
	callbk_Des()
	xinfo (['Configuration changed. Standard Control Loop']);
end;
//return;

endfunction