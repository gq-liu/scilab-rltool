//Loading your default settings file....
mode(-1)
// Rltool ver-1.7 Configuration file. Edit with care, if at all!
numer_g_cont=1+s // numerator of controller
denom_g_cont=6.0351+4.2667*s+s^2 // denominator of controller
g_cont=numer_g_cont/denom_g_cont;
numer_g_plant=1 // numerator of plant
denom_g_plant=1+s // denominator of plant
g_plant=numer_g_plant/denom_g_plant;
numer_g_sensor=1 // numerator of plant
denom_g_sensor=1 // denominator of plant
g_sensor=numer_g_sensor/denom_g_sensor;
g=g_cont*g_plant*g_sensor // this is the plant
gridon=0
 // gridon = 0 (respectively 1) means grid off (respectively on
choice=1
 // choice=1 (respectively 2) means rootlocus mode (freq mode)
kevans=10
 // maximum gain in rootlocus plot
fminmag=0.01
 //minimum frequency (rad/sec) for open loop bode plot
fmaxmag=1000
 //maximum frequency (rad/sec) for open loop bode plot
magstep=0.01
 //frequency step for open loop bode plot
fminnyq=0.01
 // minimum frequency (rad/sec) for Nyquist and Nichols plot
fmaxnyq=1000
 // Maximum frequency (rad/sec) for Nyquist and Nichols plot
nyqstep=0.01
 // Frequency step for Nyquist and Nichols plots.
fminbode=0.01
 // Minimum frequency (rad/sec) for closed loop bode plot
fmaxbode=1000
 // Maximum frequency (rad/sec) loop bode plot
bodestep=0.01
 // Frequency step for closed loop bode plot
tmax=5
 // Maximum simulation time (sec) for dynamic responses
tstep=0.05
 // time step (sec) for dynamic responses
fminsens=0.01
 // minimum frequency (rad/sec) for Sensitivity plot
fmaxsens=1000
 // maximum frequency (rad/sec) for Sensitivity plot
sensstep=0.01
 //frequency step for sensitivity plot
zeta=0.7
 // the damping ratio
wn=1
 // undamped natural frequency
MAG=1
 // Magnitude of sinusoidal test input
FREQ=1
 // Frequency (rad/sec) of sinusoidal test input
CYCLES=1
 // Number of cycles of sinusoidal test input
Knumber=3
 // Gain configuration (1) Gain in forward path (2) in feedback
