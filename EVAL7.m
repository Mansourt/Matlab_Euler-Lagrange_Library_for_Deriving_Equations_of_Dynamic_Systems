% Author: Mansour Torabi
% Email:  smtoraabi@ymail.com

%%
clc, clear

syms th0 ths x Dth0 Dths Dx
syms R r M J m k l g 

%% Kinetic and Potential Energy

VoM = (R-r)*[cos(th0), sin(th0)];
Wd  = -(R-r)*Dth0/r;

Vm = (R-r)*Dth0*[cos(th0), sin(th0)] + (l+x)*Dths*[cos(ths), sin(ths)] + Dx*[sin(ths), -cos(ths)];

yM = -(R-r)*cos(th0);
ym = yM - (l+x)*cos(ths);

T = 1/2*M*(VoM*VoM.') + 1/2*m*(Vm*Vm.') + 1/2*J*Wd^2;

V = M*g*yM + m*g*ym + 1/2*k*x^2;

L = T - V;
%%
q  = [th0, ths, x];
Dq = [Dth0, Dths, Dx];
tt = linspace(0, 20, 500);
Eq = LagrangeDynamicEqDeriver(L, q, Dq);
R0 = 5; r0 = 1; l0 = 2; 
[SS, xx] = DynamicEqSolver(Eq, q, Dq, [R r M J m k l g],...
                           [R0, r0, 1, 2, 3, 30, l0, 9.81], tt, [pi/3, pi/2, 0, 0, 0, 0]);
%%             
figure; 
plot(tt,xx(:,1),'color',[0,0.6,0],'linewidth',2); 
hold on; 
plot(tt,xx(:,2),'b','linewidth',2); 
plot(tt,xx(:,3),'r','linewidth',2); 

S1 = sprintf('$ \\theta_0$'); 
S2 = sprintf('$ \\theta_s$');
S3 = sprintf('$x_s$');
H = legend(S1, S2, S3); 
set(H,'interpreter','latex','fontsize',18,'location','SouthWest');

hx = xlabel('Time (sec)');  set(hx, 'fontsize', 18);
hy = ylabel('Angles (rad) - Length (m)'); set(hy, 'fontsize', 18);
set(gca, 'fontsize', 18);
saveas(gcf, 'Pic/Ex7.png')
%%
Animator7(xx(:,1:3), tt, [R0, r0, l0])

