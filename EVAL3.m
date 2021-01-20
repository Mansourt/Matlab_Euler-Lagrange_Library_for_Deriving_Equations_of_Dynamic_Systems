% Author: Mansour Torabi
% Email: smtoraabi@ymail.com
%%

syms th Dth x Dx
syms M m l k g 

%% Kinetic and Potential Energy
Vx2 = (Dx + l*Dth*cos(th))^2 + (l*Dth*sin(th))^2;
T   = 1/2*m*Vx2 + 1/2*M*Dx^2;

V = m*g*l*(1-cos(th)) + 1/2*k*x^2;

L = T - V;
%% Derive Equations
q = [th, x]; Dq = [Dth, Dx];
Eq = LagrangeDynamicEqDeriver(L, q, Dq);

%% Solve Equations

tt = linspace(0,10,200);
[SS, xx] = DynamicEqSolver(Eq, q, Dq, [M m l k g],...
                           [2, 1, 0.5, 50, 9.81], tt, [45/180*pi,0, 0, 0]);
%% Plot and Animate Responses            
figure; 
plot(tt, xx(:,1),'r','linewidth',2); hold on; plot(tt, xx(:,2) + 1,'k', 'linewidth',2);

S1 = sprintf('$ \\theta$'); 
S2 = sprintf('$ x$');
H = legend(S1, S2); 
set(H,'interpreter','latex','fontsize',18,'location','SouthWest');

hx = xlabel('Time (sec)');  set(hx, 'fontsize', 18);
hy = ylabel('Angles (rad)- Lenghth (m)'); set(hy, 'fontsize', 18);
set(gca, 'fontsize', 18);
saveas(gcf, 'Pic/Ex3.png')
%%
Animator3(xx(:,1:2), tt)

