function []=modified_bode(sl,fmin,fmax,pas,comments,f_unit)
//!
// Copyright INRIA
//
// Bode diagram with frequencies given in Hz or rad/s, selected
// by the last argument ('h' or 'r'). If the last argument is not
// 'h' neither 'r' then the default frequency unit is Hz in view of
// maintaining backwards compatibility with the original syntax adopted
// in Scilab 2.7.
//
// Distributed with the toolbox RLTOOL.
// Developed using the original code of bode.sci available in Scilab 2.7.
// Adapted by Jose Paulo V. S. da Cunha - State University of Rio de Janeiro
// Brazil - e-mail: jpaulo@ieee.org.
//
// Last modified: May 1 2004 by Ishan Pendharkar.
//
[lhs,rhs]=argn(0);
dom='c';
//---------------------
nyq_frq=[];l10=log(10);
pi2=2*%pi;
//---------------------
select rhs
case 1,
  f_unit='h';
case 2,
  if fmin=='h'|fmin=='r' then
    f_unit=fmin;
    rhs=1;
  else
    f_unit='h';
  end,
case 3,
  if fmax=='h'|fmax=='r' then
    f_unit=fmax;
    rhs=2;
  else
    f_unit='h';
  end,
case 4,
  if pas=='h'|pas=='r' then
    f_unit=pas;
    rhs=3;
  else
    f_unit='h';
  end,
case 5,
  if comments=='h'|comments=='r' then
    f_unit=comments;
    rhs=4;
  else
    f_unit='h';
  end,
case 6,
  if f_unit=='h'|f_unit=='r' then
    rhs=5;
  else
    error('Bode: Wrong frequency unit');
  end,
else
  error('Bode: Wrong number of arguments');
end;
//
// Selects the conversion constants for frequencies:
//
if f_unit=='r' then
  conversion2=%pi;
else
  conversion2=0.5;
end
//---------------------
pas_def='auto' // default
ilf=0
typ=type(sl)
//-compat next line added for list/tlist compatibility
if typ==15 then typ=16,end
select typ
case 16 then  // sl,fmin,fmax [,pas] [,comments]
  typ=sl(1);typ=typ(1);
  if typ<>'lss'&typ<>'r' then
    error(97,1)
  end
  if typ=='lss' then
    if sl(7)==[] then error('Undefined time domain (sl(7))');end
  end
  if typ=='r' then
    if sl(4)==[] then error('Undefined time domain (sl(4))');end
  end
  dom=sl('dt')
  if dom==[]|dom==0 then error(96,1),end
//
// Detects if the system is discrete-time without sampling period:
//
  discrete_time_without_T=(dom=='d');
  if dom=='d' then dom=1;end
  
  select rhs
  case 1 then //sl
   comments=' '
   fmin_default=1.d-3;
   fmax_default=1.d3;

//   if dom=='c' then fmax_default=1.d3; else fmax_default=1/(2*dom),end
   if dom=='c' then fmax_default=1.d3; else fmax_default=conversion2/dom,end
//   [frq,repf]=repfreq(sl,fmin_default,fmax_default);
   [frq,repf]=modified_repfreq(sl,fmin_default,fmax_default,f_unit);
   [d,phi]=dbphi(repf);
   sl=[] 
  case 2 then // sl,frq
   comments=' '
   if min(fmin)<=0 then
     error('bode: requires strictly positive frequency vector')
   end
//   [frq,repf]=repfreq(sl,fmin);
   [frq,repf]=modified_repfreq(sl,fmin,f_unit);
   [d,phi]=dbphi(repf);
   fmin=[];sl=[]
  case 3 , //sl,frq,comments ou sl,fmin,fmax
   if type(fmax)==1 then
      comments=' '
      if fmin<=0 then
         error('bode: requires strictly positive frequency range')
       end
//      [frq,repf]=repfreq(sl,fmin,fmax,pas_def),sl=[]
      [frq,repf]=modified_repfreq(sl,fmin,fmax,pas_def,f_unit),sl=[]
      [d,phi]=dbphi(repf);
   else
      comments=fmax
      if min(fmin)<=0 then
	error('bode: requires strictly positive frequency vector')
      end      
//      if type(dom)==1 then nyq_frq=1/2/dom;end
      if type(dom)==1 then nyq_frq=conversion2/dom;end
      if find(fmin>nyq_frq)~=[] then 
	warning('There are frequencies beyond Nyquist f!');
      end
//      [frq,repf]=repfreq(sl,fmin);fmin=[];sl=[]
      [frq,repf]=modified_repfreq(sl,fmin,f_unit);fmin=[];sl=[]
      [d,phi]=dbphi(repf);
   end
  case 4 ,
    if type(pas)==1 then 
      comments=' ',
    else 
      comments=pas;pas=pas_def;
    end,
    if min(fmin)<=0 then
      error('bode: requires strictly positive frequency vector')
    end
//    [frq,repf]=repfreq(sl,fmin,fmax,pas)
    [frq,repf]=modified_repfreq(sl,fmin,fmax,pas,f_unit)
    [d,phi]=dbphi(repf);
  case 5 then,
    if min(fmin)<=0 then
      error('bode: requires strictly positive frequency vector')
    end
//    [frq,repf]=repfreq(sl,fmin,fmax,pas)
    [frq,repf]=modified_repfreq(sl,fmin,fmax,pas,f_unit)
    [d,phi]=dbphi(repf);
  else 
    error('Invalid call: sys,fmin,fmax [,pas] [,com]')
  end;

case 1 then //frq,db,phi [,comments] ou frq, repf [,comments]
//
// The system is discrete-time with specified sampling period:
//
  discrete_time_without_T=%f;
  select rhs
  case 2 , //frq,repf
    comments=' '
    [phi,d]=phasemag(fmin);fmin=[]
  case 3 then
    if type(fmax)==1 then
      comments=' '//frq db phi
      d=fmin,fmin=[]
      phi=fmax,fmax=[]
    else
      [phi,d]=phasemag(fmin);fmin=[]
      comments=fmax
     end;
   case 4 then 
     comments=pas;d=fmin;fmin=[];phi=fmax;fmax=[]
   else 
     error('Invalid call: frq,db,phi,[com] or frq,repf,[com]')
   end;
   frq=sl;sl=[];[mn,n]=size(frq);
   if min(frq)<=0 then
     error('bode: requires strictly positive frequencies')
   end
   if mn<>1 then
      ilf=1;//un vecteur de frequences par reponse
   else
      ilf=0;//un seul vecteur de frequence
   end;
else 
   error('Bode: invalid call')
end;
[mn,n]=size(phi)
//
//Captions
if comments==' ' then
   comments(mn)=' ';
   mnc=0
   hx=0.48
   else
   mnc=mn
   hx=0.43
end;

[wrect,frect]=xgetech();
//magnitudez
xsetech(wrect=[wrect(1)+0,wrect(2)+0,wrect(3)*1.0,wrect(4)*hx*0.95]);
rect=[min(frq),min(d),max(frq),max(d)]
// just to fix the scales for xgrid
plot2d1("oln",min(frq),min(d),0,"051"," ",rect);
// xgrid first 
xgrid(4);
// now the curves 
plot2d1("oln",frq',d',[1:mn],"000"," ",rect);
if type(dom)==1 then
  [xx1,xx2]=xgetech();
  val= xx2([2;4])';
  plot2d1("oln",max(frq)*[1;1],val,5,"000"," ",rect);
end
//
// Selects the units for the axes:
//
if f_unit=='r' then
  if discrete_time_without_T then
    xtitle('Magnitude','W (rad)','(dB)');
  else
    xtitle('Magnitude','w (rad/s)','(dB)');
  end
else
  if discrete_time_without_T then
    xtitle('Magnitude',['normalized';'frequency'],'(dB)');
  else
    xtitle('Magnitude','f (Hz)','(dB)');
  end
end

//phase
xsetech(wrect=[wrect(1)+0,wrect(2)+wrect(4)*hx,wrect(3)*1.0,wrect(4)*hx*0.95]);
rect=[min(frq),min(phi),max(frq),max(phi)]
// just to fix the scales for xgrid
plot2d1("oln",min(frq),min(phi),0,"051"," ",rect);
xgrid(4);
//  now the curves
plot2d1("oln",frq',phi',[1:mn],"000");
if type(dom)==1 then
  [xx1,xx2]=xgetech();
  val= xx2([2;4])';
  plot2d1("oln",max(frq)*[1;1],val,5,"000");
end
//
// Selects the units for the axes:
//
if f_unit=='r' then
  if discrete_time_without_T then
    xtitle('Phase','W (rad)','(degrees)');
  else
    xtitle('Phase','w (rad/s)','(degrees)');
  end
else
  if discrete_time_without_T then
    xtitle('Phase',['normalized';'frequency'],'(degrees)');
  else
    xtitle('Phase','f (Hz)','(degrees)');
  end
end

if mnc>0 then
  xsetech([wrect(1)+0,wrect(2)+wrect(4)*2*hx,wrect(3)*1.0,wrect(4)*0.1],[0 0 1 1]);
  //dash=xget('dashes')

  y0=0.7;dy=-1/2
  x0=0;dx=1/2
  count=0
  for k=1:mnc
    //xset('dashes',k)
    xsegs([x0;x0+0.08],[y0;y0])
    rect=xstringl(x0+0.1,y0,comments(k))
    h=gce();
    set(h,"line_style",k);
    //xset('dashes',dash(1));
    xstring(x0+0.1,y0-rect(4)/3,comments(k))
    count=count+1
    y0=y0+dy
    if count==3 then x0=x0+dx;y0=0.7,end
  end
  //xset('dashes',dash(1))
end
xsetech(wrect,frect);
endfunction
