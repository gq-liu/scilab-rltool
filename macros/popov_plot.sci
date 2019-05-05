function popov_plot(g)
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
// (C) Ishan Pendharkar. Included with Rltool for Scilab.
// function plots the popov plot of the plant g
// on the real axis we have real part of g(i\omega)
// on the imaginary axis we plot omega times imaginary part of g(i\omega)
global g
wmin=0 
wmax= 30;
wstep= 0.1;

popov=zeros(ceil((wmax-wmin)/wstep),2);
for i=1:ceil((wmax-wmin)/wstep)
	if horner(denom(g),%i*(wmin+(i-1)*wstep)) <> 0 then,
		temp=horner(g,%i*(wmin+(i-1)*wstep));
		popov(i,1)=real(temp);	//real part
		popov(i,2)=(wmin+i*wstep)*imag(temp);//omega*imag part
	end;
end;
//We now plot.....Real part vs omega*imaginary part.
//xset('window',2);
scf(2);clf(2);
	plot2d(popov(:,1),popov(:,2),axesflag=5,logflag='nn');
	xtitle("Popov plot","Real(G)","omega Imag(G)");
//return;


endfunction










