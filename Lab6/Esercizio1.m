clear all
close all
s = tf('s');
F = (s+10)/(s^3 + 45*s^2 - 250*s);
Kr = 2;

% Singolarità, guadagno stazionario, fase iniziale e fase finale di F
zero(F)
damp(F)
Kf = dcgain(s*F)
[mi, fi] = bode(F, 0);
[mf, ff] = bode(F, inf);
fi, ff

%Diagrammi di Bode di Ga
Kc = 1;
Ga = (Kc/Kr)*F;
figure, bode(Ga);

%Diagramma di Nyquist di Ga
figure, nyquist(Ga)
axis equal
%punto A a circa -1.54e-03

%Asintotica stabilità di W
%Kc > 649.35 per la stabilità
Kc = 800;
W = feedback(Kc*F, 1/Kr);
pole(W)

%Simulink
We = Kr*feedback(1, (Kc/Kr)*F);
Wd1 = feedback(F, Kc/Kr);
Wd2 = feedback(1, (Kc/Kr)*F);
ertot = dcgain(We) + dcgain(Wd1) + dcgain(Wd2);
open_system('simulink1');
sim('simulink1');
figure, plot(yout), grid on;


