s = tf('s');
es = menu('Scegli la funzione di trasferimento', 'G1(s)=20/((s+1)*(s+10))',...
    'G2(s)=2/(s+1)^2', 'G3(s)=0.2/((s+1)*(s+0.1))');
switch(es)
    case 1, G=20/((s+1)*(s+10));
    case 2, G=2/(s+1)^2;
    case 3, G=0.2/((s+1)*(s+0.1));
end
[Y, T] = step(G);
figure(1), plot(T, Y), grid on, zoom on;
ltiview();