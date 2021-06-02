clear all
close all

% Parametri del motore elettrico

close all

s=tf('s');

Ra=6;
La=3.24e-3;
Km=0.0535;
J=19.74e-6;
Beta=17.7e-6;
Kf=14e-3;
Kpwm=2.925;
Rs=7.525;
Kt=0.02;                % guadagno della dinamo tachimetrica
tau_a=0.001;


F=402.5/(s*(1+s/0.8967)); % f.d.t. motore fra  u e velocita' angolare
Fd=-56500/(1+s/0.8967);   % f.d.t. motore fra Td e velocita' angolare

Td=0; %da cambiare a seconda dei casi

F_primo = F*Kt;
Kf_primo = dcgain(s*F_primo)
pole(F_primo)

%F_primo è di tipo 1, qindi l'errore di riferimento a segnali costanti è nullo
%Per la seconda specifica mod(Kc) > 2.48, verifico il segno con Nyquist
figure, bode(F_primo)
figure, nyquist(F_primo)
axis equal
%Prendo Kc positivo uguale a 2.48
Kc = 2.48;
Ga1 = Kc*F_primo;

%Picco di risonanza uguale a 1.38un (2.8dB)
%figure, nichols(F_primo)
%Margine di fase consigliato di 46deg, margine di fase minimo di 45deg
%Punto ad un margine di fase di circa 50deg
%Banda passante a 6.5rad/s
%Omega di crossover a 4.1rad/s
wcd = 4.41;


[m1, f1] = bode(Ga1, wcd) 
%37deg di fase da recuperare
%1 rete anticipatrici da 4
md = 5;
xd = 2;
taud = xd/wcd; %massimo recupero di fase per la rete da 4
Rd = (1+s*taud)/(1+s*taud/md);
Ga2 = Ga1*Rd;
[m2, f2] = bode(Ga2, wcd)

%1 rete attenuatrice di tipo 1.87
mi = 1.87;
figure, bode((1+s/mi)/(1+s))
xi = 20;
taui = xi/wcd;
Ri = (1+s*taui/mi)/(1+s*taui);
Ga3 = Ga2*Ri;
[m3, f3] = bode(Ga3, wcd)
figure, margin(Ga3)
%Tentativo riuscito

C = Kc*Rd*Ri;
W = feedback(C*F_primo, 1);
figure, step(W)

%Discretizzazione del controllore
%figure, bode(W); wb = 6.25rad/s
wb = 6.25;
alpha = 20;
T = 2*pi/(alpha*wb)
T = 0.005;
Gaz = Ga3*(1/(1+s*T/2));
figure, margin(Gaz)
Cz1 = c2d(C, T, 'tustin');
Cz2 = c2d(C, T, 'zoh');
Cz3 = c2d(C, T, 'match');
Fz = c2d(F_primo, T, 'zoh');
%Scelgo Cz1
Td = 10e-4

%Non soddisfatta specifica per il tempo di salita, va modificata la banda
%passante facendola aumentare sopra i 6rad/s
%Scelgo di portare l'omega a -3dB a 7rad/s e l'omega di crossover a
%4.41rad/s

