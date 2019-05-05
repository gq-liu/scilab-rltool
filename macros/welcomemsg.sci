function welcomemsg()
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

global g g_cont g_plant g_sensor  
WelcomeMsg='Rltool for Scilab, version 1.7.'
CreditsMsg=['(c) Ishan Pendharkar, India.';
            'Jose Da Cunha, Brazil';
            'Holger Nahrstaedt, Germany'];

Start='no';
while Start=='no'
//WelcomeNumber=buttondialog(WelcomeMsg,"Open|New|Credits|Help|Cancel","question");
WelcomeNumber=messagebox(WelcomeMsg,"Info","question",["Open","New","Credits","Help","Cancel"], "modal");
if WelcomeNumber==1 then,
	loadplant();
	Start='yes';
end;
if WelcomeNumber==2 then
	g_plant_new=rl(g_plant);
	if g_plant<>[] then,
	Start='yes'
			if g_plant_new==g_plant then, 
//if user changes the plant then set controller to default, else use previous value
			g_plant=g_plant_new
			else
			g_plant=g_plant_new
			g_cont=s^0;
			g_sensor=s^0; //default values for controller and sensor, plant has changed!
			xinfo('Setting controller and plant to default values');
			end
	g=g_cont*g_plant*g_sensor;
	else
	bye();
	end;
end;

if WelcomeNumber==3 then
	HELPabout();
	Start='no'
end;

if WelcomeNumber==4 then
        //HELPmenu()
        help "RLtool Toolbox"
	Start='no'
        halt("Help loaded! Press enter to proceed!");
end;

if WelcomeNumber==5 then
        bye()
end;

end;
return;

endfunction




