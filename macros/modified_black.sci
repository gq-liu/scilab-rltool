function []=modified_black(sl,fmin,fmax,pas,comments,f_unit)
//Black's diagram (Nichols chart) for a linear system sl.
//sl can be a continuous-time, discrete-time or sampled SIMO system
//Syntax:
//
//           black( sl,fmin,fmax [,pas] [,comments] [,f_unit])
//           black(frq,db,phi [,comments] [,f_unit])
//           black(frq, repf  [,comments] [,f_unit])
//  
//  sl       : SIMO linear system (see syslin). In case of multi-output
//             system the outputs are plotted with differents symbols.
//            
//  fmin     : minimal frequency.
//  fmax     : maximal frequency.
//  pas      : logarithmic discretization step. (see calfrq for the
//             choice of default value).
//  comments : character strings to comment the curves.
//
//  frq      : (row)-vector of frequencies or (SIMO case) matrix
//             of frequencies.
//  db       : matrix of modulus (in dB). One row for each response.
//  phi      : matrix of phases (in degrees). One row for each response.
//  repf     : matrix of complex numbers. One row for each response.
//  f_unit   : desired frequency unit ('h' for Hz or 'r' for rad/s).

// Copyright INRIA
//To plot the grid of iso-gain and iso-phase of y/(1+y) use abaque()
//%Example
//  s=poly(0,'s')
//  h=syslin('c',(s**2+2*0.9*10*s+100)/(s**2+2*0.3*10.1*s+102.01))
//  abaque();
//  black(h,0.01,100,'(s**2+2*0.9*10*s+100)/(s**2+2*0.3*10.1*s+102.01)')
//  //
//  h1=h*syslin('c',(s**2+2*0.1*15.1*s+228.01)/(s**2+2*0.9*15*s+225))
//  black([h1;h],0.01,100,['h1';'h'])
//See also:
//  bode nyquist  abaque freq repfreq 
//!
// Black's diagram with frequencies given in Hz or rad/s, selected
// by the last argument ('h' or 'r'). If the last argument is not
// 'h' neither 'r' then the default frequency unit is Hz in view of
// maintaining backwards compatibility with the original syntax adopted
// in Scilab 2.7.
//
// Distributed with the toolbox RLTOOL.
// Developed using the original code of black.sci available in Scilab 2.7.
// Adapted by Jose Paulo V. S. da Cunha - State University of Rio de Janeiro
// Brazil - e-mail: jpaulo@ieee.org.
//
// Last modified: May 1 2004.
//
[lhs,rhs]=argn(0);
sltyp='x';
pas_def='auto' //
//
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
//---------------------
//
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
  sltyp=sl('dt')
  select rhs
  case 1 then //sl
   comments=' '
//   [frq,repf]=repfreq(sl);
   [frq,repf]=modified_repfreq(sl,f_unit);
   [d,phi]=dbphi(repf);
   sl=[] 
  case 2 then // sl,frq
   comments=' '
//   [frq,repf]=repfreq(sl,fmin);
   [frq,repf]=modified_repfreq(sl,fmin,f_unit);
   [d,phi]=dbphi(repf);
   fmin=[];sl=[]
  case 3 ,
   if type(fmax)==1 then
      comments=' '
//      [frq,repf]=repfreq(sl,fmin,fmax,pas_def),
      [frq,repf]=modified_repfreq(sl,fmin,fmax,pas_def,f_unit),
      [d,phi]=dbphi(repf);
      sl=[]
   else
      comments=fmax
//      [frq,repf]=repfreq(sl,fmin);
      [frq,repf]=modified_repfreq(sl,fmin,f_unit);
      [d,phi]=dbphi(repf);
      fmin=[];sl=[]
   end
  case 4 ,
    if type(pas)==1 then 
      comments=' ',
    else 
      comments=pas;pas=pas_def
    end,
//    [frq,repf]=repfreq(sl,fmin,fmax,pas)
    [frq,repf]=modified_repfreq(sl,fmin,fmax,pas,f_unit)
    [d,phi]=dbphi(repf);
  case 5 then,
//    [frq,repf]=repfreq(sl,fmin,fmax,pas)
    [frq,repf]=modified_repfreq(sl,fmin,fmax,pas,f_unit)
    [d,phi]=dbphi(repf);
  else 
    error('invalid call: sys,fmin,fmax [,pas] [,com]')
  end;
//bode(sl,fmin,fmax,pas,comments)
case 1 then //frq,db,phi [,comments] or frq, repf [,comments]
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
     error('invalid call :frq,db,phi,[com] ou frq,repf,[com]')
   end;
   frq=sl;sl=[];[mn,n]=size(frq);
   if mn<>1 then
      ilf=1;
   else
      ilf=0;
   end;
else 
   error('invalid call to black')
end;

[mn,n]=size(phi);
//
if comments==' ' then
   comments(mn)=' ';
   mnc=0;
   strf='051'
else
   mnc=mn;
  strf='151'
end;
xmn=floor(min(phi)/90)*90
xmx=ceil(max(phi)/90)*90
ymn=min(d)
ymx=max(d)
rect=[ymn;xmn;ymx;xmx]
//[xmn,xmx,npx]=graduate(-360,0)
//[ymn,ymx,npy]=graduate(min(d),max(d))
rect=[xmn,ymn,xmx,ymx]
leg=strcat(comments,'@')

//plot2d(phi',d',(1:mn),strf,leg,rect,[10,npx,10,npy]);
plot2d(phi',d',(1:mn),strf,leg,rect);
kf=1
phi1=phi+5*ones(phi);
h=gce();
//xgeti=xget("mark");
xgeti=[get(h.children(1),"mark_style"), get(h.children(1),"mark_size")]
//xset("mark",2,xgeti(2));

//xset("clipgrf");
set(h.children(1),"clip_state","clipgrf");



kk=1;p0=[phi(:,kk) d(:,kk)];ks=1;dst=0;
dx=rect(3)-rect(1)
dy=rect(4)-rect(2)
dx2=dx^2;dy2=dy^2

while kk<n
  kk=kk+1
//
//  dst=dst+min(((phi(:,kk-1)-phi(:,kk))^2)/dx2+((d(:,kk-1)-d(:,kk))^2)/dy2)
//
// The command line above can lead to division by zero. To avoid division
// by zero, this line was replaced by the following lines:
//
  if dx2==0 then
    if dy2<>0 then
      dst=dst+min(((d(:,kk-1)-d(:,kk))^2)/dy2);
    end
  elseif dy2<>0 then
    dst=dst+min(((phi(:,kk-1)-phi(:,kk))^2)/dx2+((d(:,kk-1)-d(:,kk))^2)/dy2);
  else
    dst=dst+min(((phi(:,kk-1)-phi(:,kk))^2)/dx2);
  end
//      
  if dst>0.001 then
  if min(abs(frq(:,ks(prod(size(ks))))-frq(:,kk))./frq(:,kk))>0.2 then
   ks=[ks kk]
   dst=0
  end
  end
end
kf=1
for k=1:mn,
    xnumb(phi(k,ks),d(k,ks),frq(kf,ks),0);
    xpoly(phi(k,ks),d(k,ks),'marks',0);
  kf=kf+ilf
end;
//xclip();

//
// Selects the units for the axes:
//
if sltyp=='c' then
  if f_unit=='r' then
    xtitle('h(i*w) (frequencies in rad/s) ','Phase (degrees)','Magnitude (dB)');
  else
    xtitle('h(i*2*pi*f) (frequencies in Hz) ','Phase (degrees)','Magnitude (dB)');
  end
elseif sltyp=='x' then
//    xtitle('Blacks diagram ','Re','Im');
  if f_unit=='r' then
    xtitle('h(i*w) (frequencies in rad/s) ','Phase (degrees)','Magnitude (dB)');
  else
    xtitle('h(i*2*pi*f) (frequencies in Hz) ','Phase (degrees)','Magnitude (dB)');
  end
elseif sltyp=='d' then
  if f_unit=='r' then
    xtitle('h(exp(i*W)) (frequencies in rad) ','Phase (degrees)','Magnitude (dB)');
  else
    xtitle('h(exp(i*2*pi*f)) (normalized frequencies) ','Phase (degrees)','Magnitude (dB)');
  end
else
  if f_unit=='r' then
    xtitle('h(exp(i*w*dt)) (frequencies in rad/s) ','Phase (degrees)','Magnitude (dB)');
  else
    xtitle('h(exp(i*2*pi*f*dt)) (frequencies in Hz) ','Phase (degrees)','Magnitude (dB)');
  end
end

//     contour 2.3 db
mbf=2.3;
lmda=exp(log(10)/20*mbf);
r=lmda/(lmda**2-1);
npts=100;
crcl=exp(%i*(-%pi:(2*%pi/npts):%pi));
lgmt=log(-r*crcl+r*lmda*ones(crcl));
plot2d([180*(imag(lgmt)/%pi-ones(lgmt))]',[(20/log(10)*real(lgmt))]',...
     [2,-(mnc+1)],"100",'2.3db curve'),
//xset("mark",xgeti(1),xgeti(2));
h=gce();
set(h.children(1),"mark_style",xgeti(1));
set(h.children(1),"mark_size",xgeti(2));
endfunction
