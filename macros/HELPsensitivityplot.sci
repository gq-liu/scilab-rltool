function []=HELPsensitivityplot()
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
messagebox(['Sensitivity plot can be seen by'; 
'selecting ''Response->Closed loop''. This brings up a menu';
'with all closed loop responses that Rltool can display. Select';
'''Sensitivity plot'' to view the Sensitivity plot.';
'   '; 
'The default minimum frequency  is 0.01 rad/sec.';
'The default maximum frequency  is 1000 rad/sec.';
'These can be changed by changing ''Settings->Sensitivity Plot''.'
'   ';
'The Sensitivity plot can be displayed in Hz. as well as rad/sec.';
'by setting the appropriate frequency units in';
'''Settings->Frequency units''.']);
return;

endfunction