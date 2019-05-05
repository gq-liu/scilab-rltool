function [frq,rep,splitf]=modified_repfreq(sys,fmin,fmax,pas,f_unit)
// Copyright INRIA
//
// Frequency response with frequencies given in Hz or rad/s, selected
// by the last argument ('h' or 'r'). If the last argument is not
// 'h' neither 'r' then the default frequency unit is Hz in view of
// maintaining backwards compatibility with the original syntax adopted
// in Scilab 2.7.
//
// Distributed with the toolbox RLTOOL.
// Developed using the original code of repfreq.sci available in Scilab 2.7.
// Adapted by Jose Paulo V. S. da Cunha - State University of Rio de Janeiro
// Brazil - e-mail: jpaulo@ieee.org.
//
// Last modified: June 24, 2003.
//

pas_def='auto';
l10=log(10);
pi2=2*%pi;
[lhs,rhs]=argn(0)
//
// Choose the frequency unit:
//
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
  if f_unit=='h'|f_unit=='r' then
    rhs=4;
  else
    error('repfreq: Wrong frequency unit');
  end,
else
  error('repfreq: Wrong number of arguments');
end;
//---------------------
//discretization 

if type(sys)<>16 then  error(97,1),end;
flag=sys(1);
dom=sys('dt')
if dom==[]|dom==0 then error(96,1),end
if dom=='d' then dom=1;end

//
// Selects the conversion constants for frequencies:
//
if f_unit=='r' then
  conversion1=1;
  conversion2=%pi;
else
  conversion1=pi2;
  conversion2=0.5;
end;

select  rhs
case 1 then
  pas=pas_def
//  if dom=='c' then fmax=1.d3; else fmax=1/(2*dom),end
  if dom=='c' then fmax=1.d3; else fmax=conversion2/dom,end
  fmin=0
case 2 then
  if type(fmin)==10 then
    rhs=1
    pas=pas_def
//    if dom=='c' then fmax=1.d3; else fmax=1/(2*dom),end
    if dom=='c' then fmax=1.d3; else fmax=conversion2/dom,end
    if fmin=='sym' then
      fmin=-fmax
    else
      fmin=0
    end
  else
    frq=fmin
  end
case 3 then
  pas=pas_def
case 4 then ,
else 
  error('calling sequences: sys,fmin,fmax [,pas] or sys,frq')
end;
splitf=1
if rhs<>2 then
  if type(pas)==1 then
    splitf=1
    eps=1.e-14
    if fmin<0&fmax>=0 then
      frq=- [exp(l10*((log(eps)/l10):pas:(log(-fmin)/l10))) -fmin];
      if fmax>eps then
        frq1=[exp(l10*((log(eps)/l10):pas:(log(fmax)/l10))) fmax];
        frq=[frq($:-1:1) frq1]
      else
        frq=frq($:-1:1);
      end
    elseif fmin<0&fmax<0 then
      frq= [exp(l10*((log(-fmax)/l10):pas:(log(-fmin)/l10))) -fmin];
      frq=-frq($:-1:1);
    elseif fmin >= fmax then
      error('repfrq: fmin must be < fmax');
    else
      fmin=max(eps,fmin);
      frq=[exp(l10*((log(fmin)/l10):pas:(log(fmax)/l10))) fmax];
    end
  else
//
// calfrq must be called with frequencies given in Hz:
//
    if f_unit=='r' then
      [frq,bnds,splitf]=calfrq(sys,fmin/pi2,fmax/pi2);
      frq=pi2*frq;
    else
      [frq,bnds,splitf]=calfrq(sys,fmin,fmax);
    end;
  end;
end
//
typ=sys(1)
select typ(1)
case 'r' then
  [n,d]=sys(['num','den']),
  [mn,nn]=size(n)
  if nn<>1 then error(95,1),end
  if dom=='c' then 
    rep=freq(n,d,conversion1*%i*frq),
  else 
    rep=freq(n,d,exp(conversion1*%i*dom*frq)),
  end;
case 'lss' then
  [a,b,c,d,x0]=sys(2:6),
  [mn,nn]=size(b)
  if nn<>1 then error(95,1),end
  if dom=='c' then 
    rep=freq(a,b,c,d,conversion1*%i*frq)
  else 
    rep=freq(a,b,c,d,exp(conversion1*%i*dom*frq))
  end;
else error(97,1),
end;
//representation
if lhs==1 then frq=rep,end
endfunction
