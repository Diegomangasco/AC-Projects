s = tf('s');
es = menu('Scegli la funzione di trasferimento', ...
            'G1(s) = 10/(s-5)', 'G2(s) = 10/s', 'G3(s) = 10/(s+5)',...
            'G4(s) = 10/(s+20)');
switch(es)
    case 1, G = 10/(s-5); tau = 1/5;
    case 2, G = 10/s; 
    case 3, G = 10/(s+5); tau = 1/5;
    case 4, G = 10/(s+20); tau = 1/20;
end

es2 = menu('Scegli il tipo di ingresso', 'Impulso', 'Gradino unitario');
switch(es2)
    case 1, [Y, T]=impulse(G); figure(1), plot(T, Y), grid on, zoom on, title('Risposta all impulso');
    case 2, [Y, T]=step(G); figure(2), plot(T, Y), grid on, zoom on, title('Risposta al gradino');
end


