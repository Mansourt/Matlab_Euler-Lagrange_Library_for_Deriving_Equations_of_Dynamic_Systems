% Author: Mansour Torabi
% Email: smtoraabi@ymail.com
%%
clc, clear

syms x th1 th2 Dx Dth1 Dth2 
syms M m1 m2 l1 l2 g

%% Kinetic and Potential Energy
v1x = l1*Dth1*cos(th1) + Dx;
v1y = l1*Dth1*sin(th1);

v2x = l1*Dth1*cos(th1) + l2*Dth2*cos(th2) + Dx;
v2y = l1*Dth1*sin(th1) + l2*Dth2*sin(th2);

v1t = v1x^2 + v1y^2; 
v2t = v2x^2 + v2y^2; 

T = 1/2*M*Dx^2 + 1/2*m1*v1t + 1/2*m2*v2t;

V1 = m1*g*l1*(1-cos(th1));
V2 = m2*g*(l1*(1-cos(th1))+l2*(1-cos(th2)));
V = V1 + V2;

L = T - V;
%%
q  = [x, th1, th2];
Dq = [Dx, Dth1, Dth2];
tt = linspace(0,25,500);
Eq = LagrangeDynamicEqDeriver(L, q, Dq);
[SS, xx] = DynamicEqSolver(Eq, q, Dq, [M m1 m2 l1 l2 g],...
                           [0.5, 0.5, 2, 1, 1, 9.81], tt, [0, pi/3, 2*pi/3, 0, 0, 0]);
%%             
figure; 
plot(tt,xx(:,1),'color',[0,0.6,0],'linewidth',2); 
hold on; 
plot(tt,xx(:,2),'b','linewidth',2); plot(tt,xx(:,3),'color','r','linewidth',2);

S1 = sprintf('$ x $');
S2 = sprintf('$ \\theta_1$'); 
S3 = sprintf('$ \\theta_2$');
H = legend(S1, S2, S3); 
set(H,'interpreter','latex','fontsize',18,'location','SouthWest');

hx = xlabel('Time (sec)');  set(hx, 'fontsize', 18);
hy = ylabel('Angles (rad)- Lenghth (m)'); set(hy, 'fontsize', 18);
set(gca, 'fontsize', 18);
saveas(gcf, 'Pic/Ex4.png')
%%
Animator4(xx(:,1:3), tt)

