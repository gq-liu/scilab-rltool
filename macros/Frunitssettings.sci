function Frunitssettings()
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
global Frunits
Frunits=x_choose(['Units=rad/sec';'Units=Hz'],['Select Frequency units']);
if Frunits==0 | Frunits==1 then,
	Frunits = 'r';
	xinfo(['Loaded default configuration. Frequency units=rad/sec']); 
	else,
	xinfo (['Configuration changed. Frequency units=hz']);
	Frunits='h';
end;
Update_Config_File();
//return;

endfunction