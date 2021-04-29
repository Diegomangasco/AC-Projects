Ra = 1;
La = 6e-3;
Km = 0.5;
J = 0.1;
Beta = 0.02;
Ka = 10;
t = 0:0.01:10;
Kc = 1;
s = tf('s');
F1 = (Ka*Km)/(s^2*J*La + s*(Beta*La + J*Ra) + Beta*Ra + Km^2);
F2 = -(s*La + Ra)/(s^2*J*La + s*(Beta*La + J*Ra) + Beta*Ra + Km^2);
open_system('Es1_2slx');
sim('Es1_2slx');
figure(1), plot(Vel_ang), grid on;

W = feedback(Kc*F1, 1);
figure(2), bode(W);


