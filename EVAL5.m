% Author: Mansour Torabi
% Email: smtoraabi@ymail.com
%%
clc, clear

syms x1 x2 th1 th2 Dx1 Dx2 Dth1 Dth2 
syms k1 k2 m1 m2 l1 l2 g 

%% Kinetic and Potential Energy

v1x = Dx1*sin(th1) + (l1 + x1)*Dth1*cos(th1);
v1y = Dx1*cos(th1) - (l1 + x1)*Dth1*sin(th1);

v2x = Dx1*sin(th1) + (l1 + x1)*Dth1*cos(th1) + Dx2*sin(th2) + (l2 + x2)*Dth2*cos(th2);
v2y = Dx1*cos(th1) - (l1 + x1)*Dth1*sin(th1) + Dx2*cos(th2) - (l2 + x2)*Dth2*sin(th2);

v1t = v1x^2 + v1y^2; 
v2t = v2x^2 + v2y^2; 

T = 1/2*m1*v1t + 1/2*m2*v2t;

V1 = -m1*g*((l1 + x1)*cos(th1)) + 1/2*k1*x1^2;
V2 = -m2*g*((l1 + x1)*cos(th1) + (l2 + x2)*cos(th2)) + 1/2*k2*x2^2;
V = V1 + V2;

L = T - V;
%%
q  = [x1, x2, th1, th2];
Dq = [Dx1, Dx2, Dth1, Dth2];
tt = linspace(0, 15, 500);
Eq = LagrangeDynamicEqDeriver(L, q, Dq);
[SS, xx] = DynamicEqSolver(Eq, q, Dq, [k1 k2 m1 m2 l1 l2 g],...
                           [20, 100, 1, 2, 1, 1, 9.81], tt, [0, 0, pi/3, 2*pi/3, 0, 0, 0, 0]);
%%             
figure; 
plot(tt,xx(:,1),'color',[0,0.6,0],'linewidth',2); 
hold on; 
plot(tt,xx(:,2),'b','linewidth',2); 
plot(tt,xx(:,3),'color','r','linewidth',2);
plot(tt,xx(:,4),'color','m','linewidth',2);

S1 = sprintf('$ x_1 $');
S2 = sprintf('$ x_2 $');
S3 = sprintf('$ \\theta_1$'); 
S4 = sprintf('$ \\theta_2$');
H = legend(S1, S2, S3, S4); 
set(H,'interpreter','latex','fontsize',18,'location','NorthWest');

hx = xlabel('Time (sec)');  set(hx, 'fontsize', 18);
hy = ylabel('Angles (rad)- Lenghth (m)'); set(hy, 'fontsize', 18);
set(gca, 'fontsize', 18);
saveas(gcf, 'Pic/Ex5.png')
%%
Animator5(xx(:,1:4), tt)

