A = [0, 1; 900, 0];
B = [0; -9];
C = [600, 0];
D = 0;
n = 2;

O = obsv(A, C);
if rank(O) == n
    fprintf('Sistema Osservabile');
    L = acker(A', C', [-120, -180])';
else
    fprintf('Sistema non Osservabile');
    exit();
end

Co = ctrb(A, B);
if rank(Co) == n
    fprintf('Sistema Raggiungibile');
    K = acker(A, B, [-40, -60]);
else
    fprintf('Sistema non Raggiungibile');
    exit();
end
alpha = -1;

Atot = [A, -B*K; L*C, A-B*K-L*C];
Btot = alpha*[B; B];
Ctot = [C, -D*K; zeros(size(C)), C-D*K];
Dtot = alpha*[D; D];
System = ss(Atot, Btot, Ctot, Dtot);
t = 0:0.0001:4;
u = sign(sin(2*pi*0.5*t));
deltaX0 = [0; 0; 0; 0]; deltaX01 = [0.01; 0; 0; 0]; deltaX02 = [-0.01; 0; 0; 0];
[Y1, T1, X1] = lsim(System, u, t, deltaX0);
[Y2, T2, X2] = lsim(System, u, t, deltaX01);
[Y3, T3, X3] = lsim(System, u, t, deltaX02);
figure(1), plot(T1, Y1(:, 1)), grid on, zoom on, title('Evoluzione dell uscita1');
figure(2), plot(T1, Y1(:, 2)), grid on, zoom on, title('Evoluzione della stima dell uscita1');
figure(3), plot(T2, Y2(:, 1)), grid on, zoom on, title('Evoluzione dell uscita2');
figure(4), plot(T2, Y2(:, 2)), grid on, zoom on, title('Evoluzione della stima dell uscita2');
figure(5), plot(T3, Y3(:, 1)), grid on, zoom on, title('Evoluzione dell uscita3');
figure(6), plot(T3, Y3(:, 2)), grid on, zoom on, title('Evoluzione della stima dell uscita3');