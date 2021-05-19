clear all
close all
s = tf('s');
F = 5*(s+20)/(s*(s^2+2.5*s+2)*(s^2+15*s+100));
Kr = 2;
pole(F);
Kf = dcgain(F*s);
figure, bode(F)
%Sistema a stabilità regolare con un polo nell'origine
Kc = 160; 
%scelgo il minimo Kc positivo dato che il sistema è a stabilità regolare
%h = 0
wcd = 1.89;
figure, nichols(F)
%margine di fase consigliato = 47.65deg, margine minimo = 45deg

Ga1 = Kc*F/Kr;
[m1, f1] = bode(Ga1, wcd)
%m1 = 8.49 f1 = -209.38 

%Recupero di 78 gradi di fase con due reti anticipatrici da 6
md = 6;
xd = 1.4;
taud = xd/wcd;
Rd = (1+s*taud)/(1+taud/md*s);
Ga2 = Ga1*Rd^2;
[m2, f2] = bode(Ga2, wcd)
%m2 = 23.84, f2 = -126.73

%Attenuazione del modulo con una rete attenuatrice da 42.1
mi = 23.84;
xi = 230;
taui = xi/wcd;
Ri = (1+taui/mi*s)/(1+s*taui);
Ga3 = Ga2*Ri;
[m3, f3] = bode(Ga3, wcd)
figure, margin(Ga3)

C = Rd^2*Ri*Kc;
W = feedback(C*F, 1/Kr);
figure, step(W)
figure, step(W/Kr)
%Requisiti soddisfatti

%Valutazione del comando e delle prestazioni in catena chiusa
command = feedback(C, F/Kr);
figure, step(command)
figure, bode(W/Kr)
%Banda passante a 3.71rad/s Mr = 1.99dB
