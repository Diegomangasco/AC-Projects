M = 0.2;
F0 = 1;
es = menu('Scegli i parametri:', 'Beta = 0.1 K = 2 x0 = [0; 0]',... 
            'Beta = 0.001 K = 2 x0 = [0; 0]',...
            'Beta = 10 K = 20 x0 = [0; 0]',...
            'Beta = 0.1 K = 2 x = [0; 0.2]');
switch (es)
    case 1, Beta = 0.1; K = 2; x0 = [0; 0];
    case 2, Beta = 0.001; K = 2; x0 = [0; 0];
    case 3, Beta = 10; K = 20; x0 = [0; 0];
    case 4, Beta = 0.1; K = 2; x = [0; 0.2];
end
A = [0, -K/M; 1, -K/Beta];
B = [1/M; 0];
C = [1, 0];
D = 0;

es2 = menu('Scegli la F esterna da applicare:', 'Gradino unitario',...
    'Sinusoidale');
t = 0:0.01:5;
switch (es)
    case 1, u = F0;
    case 2, u = F0*cos(4*t);
end

System = ss(A,B,C,D);
[Y, T, X] = lsim(System, u, t, x0);
figure(1), plot(T,Y), grid on, zoom on, title('Evoluzione dell''uscita y');
figure(2), plot(T,X(:,1)), grid on, zoom on, title('Evoluzione dello stato x_1');
figure(3), plot(T, X(:,2)), grid on, zoom on, title('Evoluzione dello stato x_2');

H = tf(System);
[numH, denH] = ss2tf(A, B, C, D);
es3 = menu('Inserimento degli ingressi:',...
    'Gradino di ampiezza uo',...
    'Rampa unitaria',...
    'Coseno di ampiezza u0');
s = tf('s');
switch(es3)
    case 1, U = 1/s;
    case 2, U = 1/s^2;
    case 3, U = s/(s^2+16);
end
Y = H*U;
[NUM, DEN] = tfdata(Y, 'v');
[R, P, K] = residue(NUM, DEN);
R, P, K


            
