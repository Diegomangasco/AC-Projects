clear all
close all
s = tf('s');
F = 13.5*(s+4)*(s+10)/(s+3)^3;
Kr = 1;
pole(F)
Kf = dcgain(F)
figure, nyquist(F/s)
axis equal
%Si aggiunge un polo in 0 e si pone Kc = 5
%wcd = 3.78 e 5.1 < wb < 6.9
figure, nichols(F/s) 
%margine di fase limite a circa 50 gradi
wcd = 3.78;
Kc = 5;
Ga1 = Kc*(F/s)*(1/Kr);
[m1, f1] = bode(Ga1, wcd)

%Recupero di 60 gradi di fase (almeno 50)
md = 4;
xd = 1;
taud = xd/wcd;
Rd = (1+taud*s)/(1+taud/md*s)
Ga2 = Ga1*Rd^2; %due reti anticipatrici per avere recupero di 60 gradi e aumento contenuto di modulo
[m2, f2] = bode(Ga2, wcd)

%Attenuazione del modulo di 17.6dB con una rete attenuatrice
mi = m2;
figure, bode((1+s/mi)/(1+s));
xi = 150;
taui = xi/wcd;
Ri = (1+taui/mi*s)/(1+taui*s)
Ga3 = Ga2*Ri;
[m3, f3] = bode(Ga3, wcd) %m3 = 0dB, f3 = -123.93deg
%Situazione buona, posso definire il controllore

figure, margin(Ri*Rd^2*Ga1)
C = (Kc*Ri*Rd^2)/s
W = feedback(C*F, 1/Kr);
figure, bode(W)

%Funzione di sensibilità
Gaf = C*F;
Sens = feedback(1, Gaf);
[modS, freqs] = bode(Sens, 0.1);
esin = Kr*modS
attenuazione_disturbi = bode(W, 100)


%Tempo di salita e sovraelongazione massima per il gradino unitario
figure, step(W)