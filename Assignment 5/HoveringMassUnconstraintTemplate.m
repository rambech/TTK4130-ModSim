clear all
clc

% Parameters
syms m1 m2 L g real
% Force
u = sym('u',[3,1]);

% Position point mass 1
pm1 = sym('p1',[3,1]);
dpm1 = sym('dp1',[3,1]);
ddpm1 = sym('d2p1',[3,1]);
% Angles for point mass 2
a  = sym('a',[2,1]);
da = sym('da',[2,1]);
dda = sym('d2a',[2,1]);
% Generalized coordinates
q  = [pm1;a];
dq = [dpm1;da];
ddq = [ddpm1;dda];

% Position of point mass 2
pm2  = pm1 + [];
% Velocity of point mass 2
dpm2 = jacobian(pm2,q)*dq;
% Generalized forces
Q = [];
% Kinetic energy
T = ;
T = simplify(T);
% Potential energy
V = ;
% Lagrangian
Lag = ;

% Derivatives of the Lagrangian
Lag_q = simplify(jacobian(Lag,q)).';
Lag_qdq = simplify(jacobian(Lag_q.',dq));
Lag_dq = simplify(jacobian(Lag,dq)).';
Lag_dqdq = simplify(jacobian(Lag_dq.',dq)); % W

% Matrices for problem 1
M = Lag_dqdq;
b = Q + simplify(Lag_q - Lag_qdq*dq);
