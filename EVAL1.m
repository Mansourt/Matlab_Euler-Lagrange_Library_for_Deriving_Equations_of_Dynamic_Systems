% Author: Mansour Torabi
% Email: smtoraabi@ymail.com
%%
clc, clear

syms th1 th2  Dth1 Dth2 
syms l1 l2 m1 m2 J1 J2  g t 

%% Kinetic and Potential Energy
T1 = 1/2*J1*Dth1^2 +1/2*m1*(l1/2*Dth1)^2;

Vc2_x = l1*Dth1*cos(th1) + l2/2*(Dth1 + Dth2)*cos(th1+th2);
Vc2_y = l1*Dth1*sin(th1) + l2/2*(Dth1 + Dth2)*sin(th1+th2);
Vc2 = sqrt(Vc2_x^2 + Vc2_y^2); 
T2 = 1/2*J2*(Dth1+Dth2)^2+1/2*m2*Vc2^2;

T = T1 + T2;

V1 = m1*g*l1*(1-cos(th1))/2;
V2 = m2*g*(l1*(1-cos(th1))+l2*(1-cos(th1+th2))/2);
V = V1 + V2;

L = T - V;
%%
q  = [th1, th2];
Dq = [Dth1, Dth2];
tt = linspace(0,5,500);
Eq = LagrangeDynamicEqDeriver(L, q, Dq);
[SS, xx] = DynamicEqSolver(Eq, q, Dq, [l1 l2 m1 m2 J1 J2 g],...
                           [0.5 0.5 1 2 0.2 0.5 9.81], tt, [120,-90,0,0]/180*pi);
%%             
figure; 
plot(tt,xx(:,1),'r'); hold on; plot(tt,xx(:,2),'--b');

S1 = sprintf('$ \\theta_1$'); 
S2 = sprintf('$ \\theta_2$');
H = legend(S1, S2); 
set(H,'interpreter','latex','fontsize',14,'location','SouthWest');

xlabel('Time (sec)'); ylabel('Angles (rad)');
%%
Animator1(xx(:,1:2))

