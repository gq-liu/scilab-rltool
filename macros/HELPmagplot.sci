function []=HELPmagplot()
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
'Bode Plot of open loop plant can be seen by toggling'
'the ''Design'' Button. You can make changes to the';
'bode plot by cascading  transfer functions using the';
'''Plant-->Add/Remove cascade'' buttons.'
' ';
'The    default   minimum  frequency   is 0.01 rad/sec.';
'The    default   maximum  frequency   is 1000 rad/sec.';
'These can be changed by changing ''Settings->Mag. Plot''';
'Frequency units can be changed from rad/sec to Hertz at will';
'using the ''Settings-->Frequency Units'' button.';
])
return;


endfunction
