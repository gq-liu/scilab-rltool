function rlt()
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
//function the main programme! 
// version=getversion();
// position=grep(version,'4.1');  
// if position==[] then,
// disp("Please consider upgrading to Scilab-4.1")
// end;
// clear position;
format(7); //display precision
//****************Default global values***********
global g g_cont g_plant g_sensor  
global MAG FREQ CYCLES Frunits kevans s gridon
global last_time // check if too fast
global k  // k is the gain
global handles
global  choice // root locus or frequency design mode
global Knumber Frunits;
global kevans fminmag fmaxmag magstep fminnyq fmaxnyq nyqstep fminbode fmaxbode bodestep tmax tstep fminsens fmaxsens sensstep zeta wn 
global marked_handle // handle for marking poles

handles.f=[]
//s=poly(0,'s');
g_cont=%s^0;
g_plant=1/%s;
g_sensor=%s^0;
g=g_cont*g_plant*g_sensor
Frunits='r';
k=0;
last_time=0;
//**************************************************
Rlt_Config()
//************************ welcome message *********
welcomemsg()
//**************** MENUS****************************
tic()
UpdateGUI();
//****************** initialize main graphics window
//xset('window',0);
//f=0
//f=figure(0,'position',[0,0,550,350]);
f=scf(0);


//xset('wdim',550,350);
//xset('wpos',0,0);
//xset('auto clear','off');
//delmenu(0,'Edit');
//delmenu(0,'3D Rot.');

//delmenu(0,'Edit');
//delmenu(0,'Tools');
delmenu(0,'?');

//addmenu(0,'Grid',['On';'Off';'Zeta/Wn';'sgrid']);
tmp=uimenu(f,'label','Grid');
uimenu(tmp,'label','On','callback','GridOn(1)');
uimenu(tmp,'label','Off','callback','GridOn(0)');
uimenu(tmp,'label','Zeta/Wn','callback','zetaplot()');
uimenu(tmp,'label','sgrid','callback','whichplot();sgrid()');
// Grid_0(1)='GridOn(1)';
// Grid_0(2)='GridOn(0)';
// Grid_0(3)='zetaplot(zeta,wn)';
// Grid_0(4)='marked_handle=[];whichplot(g);sgrid()';

tmp=uimenu(f,'label','Response');
uimenu(tmp,'label','Closed Loop','callback','response_select()');
uimenu(tmp,'label','Nyquist','callback','nyq()');
uimenu(tmp,'label','Nichols','callback','blacksplot()');
uimenu(tmp,'label','Details','callback','displayalldetails()');
uimenu(tmp,'label','Popov','callback','popov_plot()');
// addmenu(0,'Response',['Closed Loop';'Nyquist';'Nichols';'Details';'Popov']);
// Response_0(1)='response_select()';
// Response_0(2)='nyq()';
// Response_0(3)='blacksplot()'
// Response_0(4)='displayalldetails()'
// Response_0(5)='popov_plot()';

tmp=uimenu(f,'label','Design');
uimenu(tmp,'label','Root Locus','callback','callbk_rlt()');
uimenu(tmp,'label','Frequency','callback','callbk_frq()');

// addmenu(0,'Design',['Root Locus';'Frequency']);
// Design_0(1)='callbk_rlt()';
// Design_0(2)='callbk_frq()';

tmp=uimenu(f,'label','Plant');
uimenu(tmp,'label','Undo','callback','undo()');
uimenu(tmp,'label','Add Pole','callback','addpole()');
uimenu(tmp,'label','Add Zero','callback','addzero()');
uimenu(tmp,'label','Remove Pole','callback','rmpole()');
uimenu(tmp,'label','Remove Zero','callback','rmzero()');
uimenu(tmp,'label','Add Cascade','callback','addplant()');
uimenu(tmp,'label','Remove Cascade','callback','rmplant()');
uimenu(tmp,'label','Edit Plant','callback','EditLoop()');
uimenu(tmp,'label','Save plant','callback','saveplant()');
uimenu(tmp,'label','Load plant','callback','loadplant()');

// addmenu(0,'Plant',['Undo';'Add Pole';'Add Zero';'Remove Pole';'Remove Zero';'Add Cascade';'Remove Cascade';'Edit Plant';'Save plant';'Load plant']);
// Plant_0(1)='undo()';
// Plant_0(2)='addpole()';
// Plant_0(3)='addzero()';
// Plant_0(4)='rmpole()';
// Plant_0(5)='rmzero()';
// Plant_0(6)='addplant()';
// Plant_0(7)='rmplant()';
// Plant_0(8)='EditLoop()';
// Plant_0(9)='saveplant()';
// Plant_0(10)='loadplant()';

tmp=uimenu(f,'label','Settings');
uimenu(tmp,'label','Root Locus','callback','rlsettings()');
uimenu(tmp,'label','Open loop freq. response','callback','magsettings()');
uimenu(tmp,'label','Nyquist-Nichols Plot','callback','nyqsettings()');
uimenu(tmp,'label','Closed loop freq. response','callback','bodesettings()');
uimenu(tmp,'label','Dynamic Response','callback','dynamicsettings()');
uimenu(tmp,'label','Sensitivity Plot','callback','senssettings()');
//uimenu(tmp,'label','Graphics attributes','callback','rl()');
uimenu(tmp,'label','Loop configuration','callback','Ksettings()');
uimenu(tmp,'label','Frequency units','callback','Frunitssettings()');
//uimenu(tmp,'label','HTML viewer','callback','browserpathsettings()');
uimenu(tmp,'label','Display Precision','callback','NumDigits()');


// addmenu(0,'Settings',['Root Locus';'Mag. plot';'Nyquist-Nichols Plot';'Bode Plot';'Dynamic Response';'Sensitivity Plot';'Graphics attributes';'Loop configuration';'Frequency units';'HTML viewer';'Display Precision']);
// Settings_0(1)='[ok,kevans]=rlsettings()';
// Settings_0(2)='[ok,fminmag,fmaxmag,magstep]=magsettings()';
// Settings_0(3)='[ok,fminnyq,fmaxnyq,nyqstep]=nyqsettings()';
// Settings_0(4)='[ok,fminbode,fmaxbode,bodestep]=bodesettings()';  
// Settings_0(5)='[ok,tmax,tstep]=dynamicsettings()';
// Settings_0(6)='[ok,fminsens,fmaxsens,sensstep]=senssettings()';
// Settings_0(7)='xsetm();g=rl(g)';
// Settings_0(8)='Knumber=Ksettings()';
// Settings_0(9)='Frunits=Frunitssettings()';
// Settings_0(10)='bowser_path=browserpathsettings()';
// Settings_0(11)='NumDigits()';

tmp=uimenu(f,'label','Measure','callback','measure()');

// addmenu(0,'Measure');
// Measure_0 ='measure()';

tmp=uimenu(f,'label','Help');
uimenu(tmp,'label','Root Locus','callback','HELProotlocus()');
uimenu(tmp,'label','Magnitude Plot','callback','HELPmagplot()');
uimenu(tmp,'label','Nyquist-Nichols Plot','callback','HELPnyqplot()');
uimenu(tmp,'label','Bode Plot','callback','HELPbodeplot()');
uimenu(tmp,'label','Closed loop responses','callback','HELPclosedloopresponse()');
uimenu(tmp,'label','Sensitivity','callback','HELPsensitivityplot()');
uimenu(tmp,'label','Settings','callback','HELPsettings()');
uimenu(tmp,'label','Load/Save','callback','HELPloadandsave()');
uimenu(tmp,'label','About','callback','HELPabout()');
uimenu(tmp,'label','License','callback','HELPlicense()');
uimenu(tmp,'label','To Do','callback','HELPtodo()');
//uimenu(tmp,'label','HTML manual','callback','HELPloadmanual()');

// addmenu(0,'Help',['Root Locus';'Magnitude Plot';'Nyquist-Nichols Plot';'Bode Plot';'Closed loop responses';'Sensitivity';'Settings';'Load/Save';'About';'License';'To Do';'HTML manual']); 
// 
// Help_0(1)='HELProotlocus()';
// Help_0(2)='HELPmagplot()';
// Help_0(3)='HELPnyqplot()';
// Help_0(4)='HELPbodeplot()';
// Help_0(5)='HELPclosedloopresponse()';
// Help_0(6)='HELPsensitivityplot()';
// Help_0(7)='HELPsettings()';
// Help_0(8)='HELPloadandsave()';
// Help_0(9)='HELPabout()';
// Help_0(10)='HELPlicense()';
// Help_0(11)='HELPtodo()';
// Help_0(12)='HELPloadmanual()';
//******************************** Exit code ************************
whichplot(g);
xname('Rltool-1.7 Main Window');
//pause;
//*********************************************************

endfunction



 
