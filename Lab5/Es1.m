%Punto A
s = tf('s');
F = (s^2 + 11*s + 10)/(s^4 + 4*s^3 + 8*s^2);
poli = pole(F);
zeri = zero(F);
[wn, zeta] = damp(F);
Guadagno_stazionario = dcgain(s^2 * F);
Guadagno_stazionario
poli
zeri
wn
zeta

%Punto B
Kc = 1;
Kr = 1;
Ga = (Kc/Kr) * F;
figure(1), bode(Ga), grid on, zoom on;

%Punto C
pole(Ga)
figure(2), nyquist(Ga), grid on, zoom on;
%nia = 0
%dal diagramma di Nyquist si vede come N = 0 e quindi nic = 0
W = feedback(Kc*F, 1/Kr);
pole(W)
%anche con l'osservazione dei poli di Wy si verifica la stabilità

%Punto D
%sistema di tipo 2, analisi errori sull'uscita

%per ingressi costanti o di tipo rampa, è nullo l'errore intrinseco
%per ingressi a ramo di parabola, si ha un errore pari a Kr/Kga =
%Kr/((Kr*Kf)/Kr)

%per disturbi sul ramo diretto costanti, a monte di essi c'è un tipo 0,
%quindi il valore dell'errore è sempre un valore di/Kg1
%per disturbi sul ramo diretto a rampa, l'uscita risulta divergente

%per disturbi sul ramo d'uscita costanti, dato che Ga è di tipo 2, non si
%hanno effetti sull'uscita