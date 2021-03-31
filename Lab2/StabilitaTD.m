B = [1; 1];
C = [1 3];
D = 0;
es = menu('Scegli i valori della matrice A', 'A1 = [-0.5 1;0 -2]',...
    'A2 = [-0.5 1;0 -1]', 'A3 = [-0.5 1;0 0]', 'A4 = [-0.5 1;0 1]');
switch(es)
    case 1, A = [-0.5 1;0 -2];
    case 2, A = [-0.5 1;0 -1];
    case 3, A = [-0.5 1;0 0];
    case 4, A = [-0.5 1;0 1];
end
x0 = [1; 2];
t = 0:1:20;
u = 0*t;
System = ss(A, B, C, D, -1);
[Y, T, X] = lsim(System, u, t, x0);
figure(1), plot(T, X(:,1)), grid on, zoom on, title('Evoluzione dello stato x_1');
figure(2), plot(T, X(:,2)), grid on, zoom on, title('Evoluzione dello stato x_2');
