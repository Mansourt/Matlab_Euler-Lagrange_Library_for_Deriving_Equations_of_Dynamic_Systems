% Author: Mansour Torabi
% Email: smtoraabi@ymail.com
%%
clc, clear

syms th1 th2 Dth1 Dth2 
syms k m1 m2 l0 l1 l2 l3 g 

%% Kinetic and Potential Energy

v1x = l1*Dth1*cos(th1) ;
v1y = -l1*Dth1*sin(th1);

v2x = l2*Dth2*cos(th2) ;
v2y = -l2*Dth2*sin(th2);

v1t = v1x^2 + v1y^2; 
v2t = v2x^2 + v2y^2; 

T = 1/2*m1*v1t + 1/2*m2*v2t;

dXX = l0 + l2*sin(th2) - l1*sin(th1);
dYY = l1*cos(th1) - l2*cos(th2);
dx = (dXX^2 + dYY^2)^0.5 - l3;

V1 = -m1*g*(l1*cos(th1)) + 1/2*k*dx^2;
V2 = -m2*g*(l2*cos(th2));
V = V1 + V2;

L = T - V;
%%
q  = [th1, th2];
Dq = [Dth1, Dth2];
tt = linspace(0, 20, 500);
Eq = LagrangeDynamicEqDeriver(L, q, Dq);
l0n = 2; l1n = 1; l2n = 1.5; l3n = 2;
[SS, xx] = DynamicEqSolver(Eq, q, Dq, [k m1 m2 l0 l1 l2 l3 g],...
                           [20,1,3, l0n, l1n, l2n, l3n, 9.81], tt, [pi/6, pi/2.5, 0, 0]);
%%             
figure; 
plot(tt,xx(:,1),'color',[0,0.6,0],'linewidth',2); 
hold on; 
plot(tt,xx(:,2),'b','linewidth',2); 

S1 = sprintf('$ \\theta_1$'); 
S2 = sprintf('$ \\theta_2$');
H = legend(S1, S2); 
set(H,'interpreter','latex','fontsize',18,'location','SouthWest');

hx = xlabel('Time (sec)');  set(hx, 'fontsize', 18);
hy = ylabel('Angles (rad)'); set(hy, 'fontsize', 18);
set(gca, 'fontsize', 18);
saveas(gcf, 'Pic/Ex6.png')
%%
Animator6(xx(:,1:2), tt, [l0n, l1n, l2n])

