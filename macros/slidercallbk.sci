function slidercallbk(handles)
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
global g k  last_time Knumber marked_handle kevans
global handles;
select Knumber
case 1 then,
	position=' (Forward)';
case 2 then,	
	position=' (Feedback)';
case 3 then,
	position=' (std control loop)';
end;

t_diff=toc()-last_time // do not update more than once a second
	if t_diff > 1 then,
		last_time=toc()
		k=get(handles.GainSlider,'value');	
		//k=get(handles.GainSlider,'value');
		set(handles.ScaleValue,'string','Gain= '+string(k)+position);
			if k>0 then,
			set(handles.Gain,'string',string(k));
			allsubplots();
			end;	
	end;
//return

// handles = resume(handles);
endfunction