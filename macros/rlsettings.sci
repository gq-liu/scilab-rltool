function [ok,kevans]=rlsettings();
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
//function settings for root locus
global kevans marked_handle handles g;
marked_handle=[];
labels=["Maximum Gain for Root Locus"];
	
[ok,kevans]=getvalue("Root Locus gain",labels,...
list("vec",1),[string(kevans)]);
//xselect();
show_window(handles.f);
if ok==%t then // if ok then update rootlocus
//xbasc(0)
whichplot(g);
xinfo('Changing Default Settings');
else xinfo('Loaded Default Settings');
kevans=1000; // if cancel then default.
end;
set(handles.GainSlider,'max',kevans);
UpdateGUI();
Update_Config_File();
//return;

endfunction