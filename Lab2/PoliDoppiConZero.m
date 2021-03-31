s = tf('s');
es = menu('Tipologia di zeri', 'Positivi', 'Negativi maggiori di -1', 'Negativi minori di -1');
switch(es)
    case 1, z1 = 100; z2 = 10; z3 = 1;
    case 2, z1 = -0.9; z2 = -0.5; z3 = -0.1;
    case 3, z1 = -100; z2 = -10; z3 = -2;
end
G1 = (5/(-z1))*((s-z1)/((s+1)*(s+5)));
G2 = (5/(-z2))*((s-z2)/((s+1)*(s+5)));
G3 = (5/(-z3))*((s-z3)/((s+1)*(s+5)));
[Y1, T1] = step(G1);
[Y2, T2] = step(G2);
[Y3, T3] = step(G3);
figure(1), plot(T1, Y1), grid on, zoom on;
figure(2), plot(T2, Y2), grid on, zoom on;
figure(3), plot(T3, Y3), grid on, zoom on;