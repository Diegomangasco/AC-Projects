A = [0, 1; 900, 0];
B = [0; -9];
C = [600, 0];
D = 0; 
Co = ctrb(A, B);
n = 2;
if rank(Co) == n
    fprintf('Sistema Controllabile');
    K = acker(A, B, [-40; -60]);
    [V,Q] = eig(A-B*K);
    Q
else 
    fprintf('Sistema non Controllabile');
    exit();
end

alpha = -1;
Ars = (A - B*K);
Brs = alpha*B;
Crs = (C - D*K);
Drs = alpha*D;
System = ss(Ars, Brs, Crs, Drs);
es = menu('Scegli lo stato iniziale', '[0; 0]', '[0.01; 0]',...
    '[-0.01; 0]');
switch(es)
    case 1, deltaX0 = [0; 0];
    case 2, deltaX0 = [0.01; 0];
    case 3, deltaX0 = [-0.01; 0];
end

t = 0:0.1:20;
[Y, T, X] = lsim(System, sign(sin(2*pi*0.5*t)), t, deltaX0);
figure(1), plot(T,Y), grid on, zoom on, title('Evoluzione dell uscita');
