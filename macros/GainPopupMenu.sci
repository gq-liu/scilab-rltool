function GainPopupMenu();
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
global kevans  k  marked_handle  g;
global handles;
select get(handles.MaxGain,'value')
	
	case 1 then, 
	kevans=10;
	
	case 2 then,
	kevans=50;

	case 3 then,
	kevans=100;

	case 4 then,
	kevans=500;
	
	case 5 then,
	kevans=1000;

	case 6 then,
	kevans=5000;

	case 7 then,
	kevans=10000;

	case 8 then,
	kevans=50000;

	case 9 then,
	kevans=100000;

	case 10 then,
	[ok,kevans]=rlsettings();
end;
		if isfield(handles,'GainSlider') then
		if  get(handles.GainSlider,'value')> kevans then,
		  set(handles.GainSlider,'value',kevans);
		  set(handles.ScaleValue,'string','Gain= '+string(kevans));
		end;
		set(handles.GainSlider,'max',kevans)
		end;
		whichplot(g);
		marked_handle=[];
//return;
 handles = resume(handles);
endfunction