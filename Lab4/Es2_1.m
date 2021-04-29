Ra = 1;
La = 6e-3;
Km = 0.5;
J = 0.1;
Beta = 0.02;
Ka = 10;
Kc = 1;
s = tf('s');
F1 = (Ka*Km)/(s^2*J*La + s*(Beta*La + J*Ra) + Beta*Ra + Km^2);
F2 = -(s*La + Ra)/(s^2*J*La + s*(Beta*La + J*Ra) + Beta*Ra + Km^2);
open_system('Es2_1slx');
sim('Es2_1slx');
figure(1), plot(Pos_ang), grid on;



