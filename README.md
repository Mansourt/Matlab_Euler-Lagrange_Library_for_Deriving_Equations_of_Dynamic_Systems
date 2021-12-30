[![View Matlab Euler-Lagrange Library  on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://de.mathworks.com/matlabcentral/fileexchange/86563-matlab-euler-lagrange-library)
# Matlab: Euler-Lagrange Library for Derving Equations of Dynamic Systems

Using the above library, one can derive differential equations for any dynamic systems and solve response of the system for a given conditions.

Functinality of the library has been Illustrated by the following examples:

1. Double Pendulum
2. Spring Pendulum
3. Pendulum with Spring-loaded support
4. Double Pendulum with free support

## Example 1: Double Pendulum

**Problem Definition:**
<table style="width:100%">
  <tr>
		<td width="10%"> </td>
		<td width="80%">
			<img src="../master/Pic/Ex1A.gif" />
		</td>
		<td width="10%"> </td>
  </tr>
</table>

**How to solve:**

Just run the ```EVAL1.m``` to **derive equations** and solve intial condition problem:

### Usage:
``` Matlab
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
````


<table style="width:100%">
   <tr>
        <th>Anlges of double pendulum:</th>
		<th>Animated Response:</th>
  </tr>
  <tr>
		<td width="50%">
			<img src="../master/Pic/Ex1.png" />
		</td>
		<td width="50%">
			<img src="../master/Pic/Anim1.gif" />
		</td>
  </tr>
</table>

	
## Example 2: Spring Pendulum

Just run the ```EVAL2.m``` to derive equations and solve intial condition problem:

### Usage:
``` MATLAB
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
```

<table style="width:100%">
   <tr>
        <th>Angle and length of spring pendulum:</th>
		<th>Animated Response:</th>
  </tr>
  <tr>
		<td width="50%">
			<img src="../master/Pic/Ex2.png" />
		</td>
		<td width="50%">
			<img src="../master/Pic/Anim2.gif" />
		</td>
  </tr>
</table>


## Example 3: Pendulum with Spring-loaded support

Just run the ```EVAL3.m``` to derive equations and solve intial condition problem:

### Usage:
``` MATLAB
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
```


<table style="width:100%">
   <tr>
        <th>Slider Position and Pendulum Anlge:</th>
		<th>Animated Response:</th>
  </tr>
  <tr>
		<td width="50%">
			<img src="../master/Pic/Ex3.png" />
		</td>
		<td width="50%">
			<img src="../master/Pic/Anim3.gif" />
		</td>
  </tr>
</table>


## Example 4: Double Pendulum with free support

Just run the ```EVAL4.m``` to derive equations and solve intial condition problem:

``` MATLAB
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
```
Slider Position, Pendulum Anlges:
<table style="width:100%">
   <tr>
        <th>Slider Position, Pendulum Anlges:</th>
		<th>Animated Response:</th>
  </tr>
  <tr>
		<td width="50%">
			<img src="../master/Pic/Ex4.png" />
		</td>
		<td width="50%">
			<img src="../master/Pic/Anim4.gif" />
		</td>
  </tr>
</table>					   


# Contact
Email: smtoraabi@ymail.com