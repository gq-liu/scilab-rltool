function []=HELProotlocus()
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
messagebox(['To get the gain at a point on the';
'rootlocus, click on the ''Measure'' button. You';
'will then be  prompted to  click on  a point on the ';
'rootlocus. If the point that you selected lies on';
'the rootlocus, the gain will be displayed on the'
'rootlocus window (for *nix users, the display ';
'position is on the top, for Windows users, the ';
'display position is on the bottom left corner).';
' ';
'Changes to the rootlocus can be made at the click';
'of a mouse by using the ''Plant'' button.';
'You may add/remove a pole/zero / edit the plant';
'by  typing in the required transfer function.';
'    ';
'The   default   gain   of    rootlocus is 1000.';
'This   can   be    changed   by        changing'; 
'the gain in ''Settings->Root Locus''.You  can  choose';
'gain to be either in the forward or feedback path.';
'The default configuration is the so called standard';
'control loop with a plant, gain, controller and sensor.';
'Gain configuration can be changed in';
'''Settings-->Gain configuration.''';
'There is a choice of Grid On/Off  (''Grid'' button).';
'You can plot  damping ratio &  Natural frequency';
'lines using the ''Grid->zeta/wn'' option.';
' ';
'Manipulation of the rootlocus can also be done';
'using the ''Control Center'' window which has ';
'the same menu structure as the Rltool Main Window.'
'The maximum gain of the rootlocus plot can also ';
'be changed in the ''Control Center'' using a drop';
'down box that has fixed maxium gains of 100, 500, etc']);
return;

endfunction