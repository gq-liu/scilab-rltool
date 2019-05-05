function []=HELPclosedloopresponse()
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
messagebox([
'The following  closed loop dynamic';
'responses can be seen: Impulse, Step, Ramp, ';
'(arbitrary) piece-wise linear single-';
'valued-input, sinusoidal input. ';
'Your current gain (as shown on the slider) is';
'used to compute these responses. The closed loop';
'transfer function can be computed either with';
'gain in the forward path or the feedback path';
' ';
'A selection menu is displayed when you select';
'''Response-->Closed loop''. Click on the required';
'dynamic response from this menu.'
'       ';
'The maximum simulation time & step interval';
'can be selected in ''Settings->Dynamic Response''.'],"modal");
return;


endfunction
