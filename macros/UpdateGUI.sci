function UpdateGUI()
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
//clear;
global Knumber g marked_handle;
global kevans
global handles


	if handles.f<>[] then,
	close(handles.f);
	end;
	if marked_handle<>[] then,
	marked_handle.visible='off';
	end;
	marked_handle=[];
	handles.f = 1000;
        handles.all_handles = [];
	handles.f=figure(1000,'position',[0,310,310,380]);
        scf(1000);
	//delmenu(1000,'File');
	//delmenu(1000,'Edit');
	//delmenu(1000,'Tools');
	delmenu(1000,'?');
	handles.GainSlider=uicontrol(handles.f,'style','slider',...
	'min',0,'max',kevans,'position', [10 50 150 16],'callback','slidercallbk()','BackgroundColor',[1 1 1]);
	
	handles.MaxGain=uicontrol(handles.f,'style','popupmenu','callback','GainPopupMenu()',...
	'position', [175,40,100,30],'string','Max','BackgroundColor',[0 1 1]);
	//set(handles.MaxGain,'string',"Max.Gain="+string(kevans)+"|10|50|100|500|1000|5,000|10,000|50,000|100,000|Type value");
	set(handles.MaxGain,'string',"10|50|100|500|1000|5,000|10,000|50,000|100,000");
	
        handles.ScaleValue=uicontrol(handles.f,'style','text',...
	'position', [0 70 250 20],'fontsize',18);

	handles.SetGain=uicontrol(handles.f,'style','edit','string','Type Gain here',...
	'position',[10,140,140,25],'fontsize',18);

	handles.Button=uicontrol(handles.f,'style','pushbutton','callback','ReadGain()',...
	'string','Ok','position',[150,140,25,25],'BackgroundColor',[0 1 1]);

	handles.Button_Close=uicontrol(handles.f,'style','pushbutton','callback','Close()',...
	'string','Exit','position',[105,10,50,25],'BackgroundColor',[0 1 1]);

// ************************ Menus **********************
	handles.Response=uimenu(handles.f,'label','Response');
	uimenu(handles.Response,'label','Closed loop','callback','response_select()')
	uimenu(handles.Response,'label','Nyquist plot','callback','nyq()');
	uimenu(handles.Response,'label','Nichols chart','callback','blacksplot()');
	uimenu(handles.Response,'label','Details','callback','displayalldetails()');
        uimenu(handles.Response,'label','Popov','callback','popov_plot()');
	
// 	handles.Design=uimenu(handles.f,'label','Design');
// 	uimenu(handles.Design,'label','Root Locus','callback','callbk_rlt()');
// 	uimenu(handles.Design,'label','Frequency','callback','callbk_frq()');

	handles.Plant=uimenu(handles.f,'label','Plant');
	uimenu(handles.Plant,'label','undo','callback','undo()');
//	uimenu(handles.Plant,'label','Add pole','callback','addpole()');
//	uimenu(handles.Plant,'label','Add zero','callback','addzero()');
//	uimenu(handles.Plant,'label','Remove pole','callback','rmpole()');
//	uimenu(handles.Plant,'label','Remove zero','callback','rmzero()');
	//uimenu(handles.Plant,'label','Edit plant','callback','rl()');
	uimenu(handles.Plant,'label','Add Cascade','callback','addplant()');
	uimenu(handles.Plant,'label','Remove Cascade','callback','rmplant()');
	uimenu(handles.Plant,'label','Edit Plant','callback','EditLoop()');
	uimenu(handles.Plant,'label','Save plant','callback','saveplant()');
	uimenu(handles.Plant,'label','Load plant','callback','loadplant()');

	handles.Settings=uimenu(handles.f,'label','Settings');
	uimenu(handles.Settings,'label','Rootlocus','callback','rlsettings()');
	uimenu(handles.Settings,'label','Open loop freq. response','callback', 'magsettings()');
	uimenu(handles.Settings,'label','Nyquist/Nichols chart','callback', 'nyqsettings()');
	uimenu(handles.Settings,'label','Closed loop freq. response','callback', 'bodesettings()');
	uimenu(handles.Settings,'label','Dynamic response','callback', 'dynamicsettings()');
	uimenu(handles.Settings,'label','Sensitivity','callback', 'senssettings()');
        uimenu(handles.Settings,'label','Loop configuration','callback','Ksettings()');
// 	handles.Gain_Config=uimenu(handles.Settings,'label','Loop configuration');
// 	handles.Gain_Config_Fwd=uimenu(handles.Gain_Config,'label','Forward path','callback','callbk_fwd()');
// 	handles.Gain_Config_Fbk=uimenu(handles.Gain_Config,'label','Feedback path','callback','callbk_fbk()');
// 	handles.Gain_Config_Des=uimenu(handles.Gain_Config,'label','Standard Control Loop','callback','callbk_Des()');
	uimenu(handles.Settings,'label','Display Precision','callback', 'NumDigits()');

        uimenu(handles.Settings,'label','Frequency units','callback','Frunitssettings()');
	//handles.Frq_Unit=uimenu(handles.Settings,'label','Frequency Units');
	//handles.Frq_Unit_rad=uimenu(handles.Frq_Unit,'label','Rad/sec','callback','Frunits=''r'' ');
	//handles.Frq_Unit_hz=uimenu(handles.Frq_Unit,'label','Hertz','callback','Frunits=''h'' ');

select Knumber
case   1 then, // Gain in forward path
	handles.Plant=uicontrol(handles.f,'style','pushbutton','callback','UpdatePlantFwdFbk()',...
	'string','Plant','position',[50,300,75,75],'BackgroundColor',[0 1 1]);

	handles.Gain=uicontrol(handles.f,'style','pushbutton',...
	'string','Gain','position',[170,300,75,75],'BackgroundColor',[0 1 1]);

	handles.Plant2Gain=uicontrol(handles.f,'style','popupmenu','position',[123,337,50,5])
	handles.Gain2y=uicontrol(handles.f,'style','popupmenu','position',[245,337,30,5],'string','plant output');
	handles.y2u_1=uicontrol(handles.f,'style','popupmenu','position',[250,237,5,100]);
	handles.y2u_2=uicontrol(handles.f,'style','popupmenu','position',[40,237,210,5]);
	handles.y2u_3=uicontrol(handles.f,'style','popupmenu','position',[40,237,5,100]);
	handles.u2Plant=uicontrol(handles.f,'style','popupmenu','position',[30,337,20,5],'string','Ref. input');	 

case    2 then, // Feedback configuration... Gain in feedback
	u2y=uicontrol(handles.f,'style','popupmenu','position',[40,337,230,5]);
	handles.Plant=uicontrol(handles.f,'style','pushbutton','callback','UpdatePlantFwdFbk()',...
	'string','Plant','position',[120,300,75,75],'BackgroundColor',[0 1 1]);
	y2u_1=uicontrol(handles.f,'style','popupmenu','position',[250,237,5,100],'string','plant output');
	y2u_2=uicontrol(handles.f,'style','popupmenu','position',[40,237,210,5]);
	y2u_3=uicontrol(handles.f,'style','popupmenu','position',[40,237,5,100]);
	handles.Gain=uicontrol(handles.f,'style','pushbutton',...
	'string','Gain','position',[120,200,75,75],'BackgroundColor',[0 1 1]);
	u2Plant=uicontrol(handles.f,'style','popupmenu','position',[30,337,20,5],'string','Ref. input');
	

case   3 then,


	u2G=uicontrol(handles.f,'style','popupmenu','position',[0,337,20,5],'string','Ref. input');
	handles.Gain=uicontrol(handles.f,'style','pushbutton',...
	'string','Gain','position',[30,310,50,50],'BackgroundColor',[0 1 1]);
	G2C=uicontrol(handles.f,'style','popupmenu','position',[80,337,20,5]);
	handles.Controller=uicontrol(handles.f,'style','pushbutton','callback','UpdateController()',...
	'string','Controller','position',[100,310,60,50],'BackgroundColor',[0 1 1]);
	C2P=uicontrol(handles.f,'style','popupmenu','position',[160,337,40,5]);
	handles.Plant=uicontrol(handles.f,'style','pushbutton','callback','UpdatePlant()',...
	'string','Plant','position',[200,310,50,50],'BackgroundColor',[0 1 1]);
	P2y=uicontrol(handles.f,'style','popupmenu','position',[250,337,40,5],'string','Plant Output');
	y2S=uicontrol(handles.f,'style','popupmenu','position',[260,270,5,70]);
	u2S=uicontrol(handles.f,'style','popupmenu','position',[15,270,250,5]);
	handles.Sensor=uicontrol(handles.f,'style','pushbutton','callback','UpdateSensor()',...
	'string','Sensor','position',[150,250,50,50],'BackgroundColor',[0 1 1]);
	S2u=uicontrol(handles.f,'style','popupmenu','position',[15,270,5,70]);
	
	//Ref_input=uicontrol(f,'style','text','string','Reference input','position',[0,350,100,10],'fontsize',10); 

end;

	
//return;
//handles = resume(handles);
endfunction






