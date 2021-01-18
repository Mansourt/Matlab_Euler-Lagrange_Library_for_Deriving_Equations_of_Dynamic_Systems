% Author: Mansour Torabi
% Email: smtoraabi@ymail.com
%%

syms th Dth x Dx
syms m l k g t 

%% Kinetic and Potential Energy
T = 1/2*m*(Dx^2 + (l + x)^2*Dth^2);
V = -m*g*(l+x)*cos(th) + 1/2*k*x^2;

L = T - V;
%% Derive Equations
q = [th, x]; Dq = [Dth, Dx];
Eq = LagrangeDynamicEqDeriver(L, q, Dq);

%% Solve Equations

tt = linspace(0,10,300);
[SS, xx] = DynamicEqSolver(Eq, q, Dq, [m l k g],...
                           [1 1 10 9.81], tt, [45/180*pi,0.1, 0, 0]);
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
saveas(gcf, 'Pic/Ex2.png')
%%
Animator2(xx(:,1:2), tt)

