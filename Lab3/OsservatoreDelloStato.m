A = [0, 1; -2400, -100];
B = [0; 9];
C = [600, 0];
D = 0;
n = 2;

O = obsv(A, C);
if rank(O) == n
    fprintf('Sistema Osservabile');
    L = acker(A', C', [-120, -180])';
    [V, Q] = eig(A-L*C);
    Q
else
    fprintf('Sistema non Osservabile');
    exit();
end

Atot = [A, zeros(size(A)); L*C, A-L*C];
Btot = [B; B];
Ctot = [C, zeros(size(C)); zeros(size(C)), C];
Dtot = [D; D];

t = 0:0.001:5;
u = sign(sin(2*pi*0.5*t));
es = menu('Scegli lo stato iniziale del sistema', '[0; 0]',...
    '[0.01; 0]', '[-0.01; 0]');
switch(es)
    case 1, X0 = [0; 0; 0; 0];
    case 2, X0 = [0.01; 0; 0; 0];
    case 3, X0 = [-0.01; 0; 0; 0];
end

System = ss(Atot, Btot, Ctot, Dtot);
[Y, T, X] = lsim(System, u, t, X0);
figure(1), plot(T, Y(:,1)), grid on, zoom on, title('Evoluzione dell uscita');
figure(2), plot(T, Y(:,2)), grid on, zoom on, title('Evoluzione della stima dell uscita');
figure(3), plot(T, X(:,1)), grid on, zoom on, title('Evoluzione del primo stato');
figure(4), plot(T, X(:,3)), grid on, zoom on, title('Evoluzione della stima del primo stato');
figure(5), plot(T, X(:,2)), grid on, zoom on, title('Evoluzione del secondo stato');
figure(6), plot(T, X(:,4)), grid on, zoom on, title('Evoluzione della stima del secondo stato');

