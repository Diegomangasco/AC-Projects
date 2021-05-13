clear all
close all
s = tf('s');
F = (s-1)/((s+0.2)*(s^3 + 2.5*s^2 + 4*s));
Kr = 0.5;

%Guadagno stazionario, poli e zeri e fase di F
damp(F)
zero(F)
Kf = dcgain(s*F)
[mi, fi] = bode(F, 0);
[mf, ff] = bode(F, inf);
fi, ff

%Diagrammi di Bode di Ga
Kc = 1;
Ga = (Kc/Kr)*F;
Ga
figure, bode(Ga)

%Diagramma di Nyquist di Ga
pole(Ga)
figure, nyquist(Ga)
axis equal
%Punto A in 4, punto B in -0.11

%Stabilità del sistema se -0.25 < Kc < 0
Kc = -0.1;
Ga = (Kc/Kr) * F;
W = feedback(Kc*F, 1/Kr);
pole(W)

%Simulink
We = Kr*feedback(1, Ga);
Wd1 = feedback(F, Kc/Kf);
Wd2 = feedback(1, Ga);
ertot = dcgain(We) - dcgain(Wd1) - dcgain(Wd2);
ertot
open_system('simulink2');
sim('simulink2');
figure, plot(yout)
