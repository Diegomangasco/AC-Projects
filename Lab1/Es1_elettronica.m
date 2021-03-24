C = 0.2;
I0 = 1;
es = menu('Scegli i parametri:', 'R = 10 L = 0.5 x0 = [0; 0]',... 
            'R = 100 L = 0.5 x0 = [0; 0]',...
            'R = 0.1 L = 0.05 x0 = [0; 0]',...
            'R = 10 L = 0.5 x = [0; 0.2]');
switch (es)
    case 1, R = 10; L = 0.5; x0 = [0; 0];
    case 2, R = 100; L = 0.5; x0 = [0; 0];
    case 3, R = 0.1; L = 0.05; x0 = [0; 0];
    case 4, R = 10; L = 0.5; x = [0; 0.2];
end
A = [0, -1/C; 1/L, -R/L];
B = [1/C; 0];
C = [1, 0];
D = 0;

es2 = menu('Scegli la corrente esterna da applicare:', 'Gradino unitario',...
    'Sinusoidale');
t = 0:0.01:5;
switch (es)
    case 1, u = I0;
    case 2, u = I0*cos(4*t);
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
