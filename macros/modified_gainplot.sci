function []=modified_gainplot(sl,fmin,fmax,pas,comments,f_unit)
//!
// Copyright INRIA
//
// Gain magnitude  diagram with frequencies given in Hz or rad/s, selected
// by the last argument ('h' or 'r'). If the last argument is not
// 'h' neither 'r' then the default frequency unit is Hz in view of
// maintaining backwards compatibility with the original syntax adopted
// in Scilab 2.7.
//
// Distributed with the toolbox RLTOOL.
// Developed using the original code of gainplot.sci available in Scilab 2.7.
// Adapted by Jose Paulo V. S. da Cunha - State University of Rio de Janeiro
// Brazil - e-mail: jpaulo@ieee.org.
//
// Last modified: May 1 2004
//
[lhs,rhs]=argn(0);
dom='c';
//---------------------
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
    error('gainplot: Wrong frequency unit');
  end,
else
  error('gainplot: Wrong number of arguments');
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
//
noxtitle=%f;
ilf=0
flag=type(sl);
if flag==15 then flag=16;end
select flag
case 16 then  // sl,fmin,fmax [,pas] [,comments]
  typ=sl(1);typ=typ(1);
  if typ<>'lss'&typ<>'r' then
    error(97,1)
  end
  sl1=sl(1);
  if sl1(1)=='r' then dom=sl(4),else dom=sl(7),end
  if dom==[] then error(96,1),end
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
//   [frq,repf]=repfreq(sl,fmin_default,fmax_default);sl=[] 
   [frq,repf]=modified_repfreq(sl,fmin_default,fmax_default,f_unit);sl=[] 
   [d,phi]=dbphi(repf);
  case 2 then // sl,frq
   comments=' '
   if min(fmin)<=0 then
     error('gainplot: requires strictly positive frequency vector')
   end   
//   [frq,repf]=repfreq(sl,fmin);fmin=[];sl=[]
   [frq,repf]=modified_repfreq(sl,fmin,f_unit);fmin=[];sl=[]
   [d,phi]=dbphi(repf);
  case 3 , //sl,frq,comments ou sl,fmin,fmax
   if type(fmax)==1 then
      comments=' '
      if fmin<=0 then
         error('gainplot: requires strictly positive frequency range')
       end      
//      [frq,repf]=repfreq(sl,fmin,fmax,pas_def),sl=[]
      [frq,repf]=modified_repfreq(sl,fmin,fmax,pas_def,f_unit),sl=[]
      [d,phi]=dbphi(repf);
   else
      comments=fmax
      if min(fmin)<=0 then
	error('gainplot: requires strictly positive frequency vector')
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
      comments=pas;pas=pas_def
    end,
    if min(fmin)<=0 then
      error('gainplot: requires strictly positive frequency vector')
    end    
//    [frq,repf]=repfreq(sl,fmin,fmax,pas)
    [frq,repf]=modified_repfreq(sl,fmin,fmax,pas,f_unit)
    [d,phi]=dbphi(repf);
  case 5 then,
    if min(fmin)<=0 then
      error('gainplot: requires strictly positive frequency vector')
    end    
//    [frq,repf]=repfreq(sl,fmin,fmax,pas)
    [frq,repf]=modified_repfreq(sl,fmin,fmax,pas,f_unit)
    [d,phi]=dbphi(repf);
  else 
    error('Invalid call: sys,fmin,fmax [,pas] [,com]')
  end;

case 1 then //frq,db,phi [,comments] ou frq, repf [,comments]
noxtitle=%t;
//
// The system is discrete-time with specified sampling period:
//
  discrete_time_without_T=%f;
  select rhs
  case 2 , //frq,repf
    comments=' '
    [phi,d]=phasemag(fmin),fmin=[]
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
     error('inputs:frq,db,phi,[com] or frq,repf,[com]')
   end;
   frq=sl;sl=[];[mn,n]=size(frq);
   if min(frq)<=0 then
     error('gainplot: requires strictly positive frequencies')
   end   
   if mn<>1 then
      ilf=1;//un vecteur de frequences par reponse
   else
      ilf=0;//un seul vecteur de frequence
   end;
else 
   error('gainplot: invalid plot')
end;
[mn,n]=size(phi)
//
//Captions
if comments==' ' then
   comments(mn)=' ';
   mnc=0
  strf='051'
else
   mnc=mn
  strf='151'
end;

rect=[min(frq),min(d),max(frq),max(d)]
plot2d1("oln",min(frq),min(d),0,'051',' ',rect);
xgrid(4)
if ilf==0 then
     	plot2d1("oln",frq',d',[1,3:mn+1],strf,strcat(comments,'@'),rect);
else
     	plot2d1("gln",frq',d',[1,3:mn+1],strf,strcat(comments,'@'),rect);
end
if ~noxtitle then
//xtitle(' ','Hz','db');
//
// Selects the units for the axes:
//
  if f_unit=='r' then
    if discrete_time_without_T then
      xtitle('  ','W (rad)','(dB)');
    else
      xtitle('  ','w (rad/s)','(dB)');
    end
  else
    if discrete_time_without_T then
      xtitle('  ',['normalized';'frequency'],'(dB)');
    else
      xtitle('  ','f (Hz)','(dB)');
    end
  end
end
endfunction
