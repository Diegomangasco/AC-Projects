B = [1; 1];
C = [1 3];
D = 0;
es = menu('Scegliere la matrice A', 'A1 = [-0.5 1; 0 -2]',...
    'A2 = [-0.5 1; 0 -1]', 'A3 = [-0.5 1; 0 0]', 'A4 = [-0.5 1; 0 1]');
switch(es)
    case 1, A = [-0.5 1; 0 -2];
    case 2, A = [-0.5 1; 0 -1];
    case 3, A = [-0.5 1; 0 0];
    case 4, A = [-0.5 1; 0 1];
end
t = 0:0.1:5;
u = 0*t;
x0 = [1; 2];
System = ss(A, B, C, D);
[Y, T, X] = lsim(System, u, t, x0);
figure(1), plot(T, X(:,1)), zoom on, grid on, title('Evoluzione dello stato x_1');
figure(2), plot(T, X(:,2)), zoom on, grid on, title('Evoluzione dello stato x_2');
