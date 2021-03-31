s = tf('s');
es = menu('Inserisci i valori di Omegan e Zeta',...
    'Wn = 2, Z = 0.5', 'Wn = 2, Z = 0.25', 'Wn = 1, Z = 0.5');
switch(es)
    case 1, Wn = 2; Z = 0.5;
    case 2, Wn = 2; Z = 0.25;
    case 3, Wn = 1; Z = 0.5;
end
S = exp((-pi*Z)/(sqrt(1-Z^2)));
Ts = (1/(Wn*sqrt(1-Z^2)))*(pi-acos(Z));
G = Wn^2/(s^2+2*Z*Wn*s+Wn^2);
[Y, T] = step(G);
figure(1), plot(T, Y), zoom on, grid on;