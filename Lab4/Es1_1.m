Ra = 1;
La = 6e-3;
Km = 0.5;
J = 0.1;
Beta = 0.02;
Ka = 10;
t = 0:0.01:10;
s = tf('s');
F1 = (Ka*Km)/(s^2*J*La + s*(Beta*La + J*Ra) + Beta*Ra + Km^2);
F2 = -(s*La + Ra)/(s^2*J*La + s*(Beta*La + J*Ra) + Beta*Ra + Km^2);
u = (1/((Ka*Km)/(Beta*Ra + Km^2)));
open_system('Es1_1slx');
sim('Es1_1slx');
figure, plot(Vel_ang), grid on;
close_system('Es1_1slx');

