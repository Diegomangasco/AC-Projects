clear all
close all
s = tf('s');
F = (5*(1+s/4))/((1+s)^2*(1+s/16)^2);
%damp(F)
%step(F)
%il sistema è asintoticamente stabile e step(F) è monotona e limitata, quindi posso procedere con il metodo
%di taratura in anelllo aperto

%margin(F)
%margine di fase a 25.6dB (finito), quindi posso procedere anche con il
%metodo di tratura in anello chiuso

%taratura in anello chiuso
[Gm, Pm, Wgm, Wpm] = margin(F);
Kpbar = Gm;
Tbar = 2*pi/Wgm;
Kp = 0.6*Kpbar;
Ti = 0.5*Tbar;
Td = 0.125*Tbar;
N = 5;
polo = -N/Td
Rpid = Kp*(1+(1/(s*Ti))+(Td*s/(1+Td/N*s)));
damp(F*Rpid)
W = feedback(Rpid*F, 1);
figure, step(W)

%taratura in anello aperto
%step(F) y0.63 = 3.15
%ascissa a 3.15 è 2s
Kf = dcgain(F);
damp(F) %polo dominante è quello che mi da una tau più grande, quindi quello più vicino all'origine
tauf = 1;
omegaf = 2-tauf;
Gapp = Kf*exp(-omegaf*s)/(1+tauf*s);
%step(Gapp) tempo di assestamento abbastanza grande, uso il metodo Cohen-Coon
Kp2 = (16*tauf+3*omegaf)/(12*Kf*omegaf);
Ti2 = (30*tauf+3*omegaf)/(9*tauf+20*omegaf);
Td2 = (4*tauf*omegaf)/(11*tauf+2*omegaf);
N2 = 5;
Rpid2 = Kp2*(1+(1/(s*Ti2))+(Td2*s/(1+Td2/N2*s)));
pole(Rpid2*F) %asintoticamente stabile
W2 = feedback(Rpid2*F, 1);
figure, step(W2)