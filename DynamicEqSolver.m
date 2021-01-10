function [SS, xx] = DynamicEqSolver(Eq, q, Dq, ParamList, ParamVal, tspan, InitCnd)
% Author: Mansour Torabi
% Email: smtoraabi@ymail.com

%% [1.1]: Convert Eq To State-Space Form:

N = length(Eq);

DDq = sym(zeros(1, N));
for ii = 1:N
    DDq(ii) = sym(['DD', char(q(ii))]);
end
%

% AA * X = BB;

AA = jacobian(Eq, DDq);
BB = -simplify(Eq - AA*DDq.');

DDQQ   = sym(zeros(N, 1));
DET_AA = det(AA);

for ii = 1:N   
    AAn       = AA;
    AAn(:,ii) = BB;
    DDQQ(ii)  = simplify(det(AAn) / DET_AA);
end

%% [1.2]: State Space formation - Final Step

SS = sym(zeros(N, 1));

for ii = 1:N
   SS (ii) = Dq(ii);
   SS (ii + N) = DDQQ(ii);   
end

%% [1.3]: Change variables from q to x

Q = [q, Dq];
X = sym('x_',[1 2*N]);
SS = subs(SS, Q, X);

%% [2.1] Solving ODEs
syms t
% Preparation of SS Eq for ODE Solver: Creating Anonymous Fcn

SS_0 = subs(SS, ParamList,ParamVal);
SS_ode0 = matlabFunction(SS_0,'vars',{X, t});

SS_ode  = @(t, x)SS_ode0(x(1:2*N)',t);
[ts, xx] = ode45(SS_ode, tspan, InitCnd); 


