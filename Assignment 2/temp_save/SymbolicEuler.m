clear all
close all
clc

%%% FILL IN ALL PLACES LABELLED "complete"

syms rho theta psi real
syms drho dtheta dpsi real

A     = [rho;theta;psi];
dA    = [drho;dtheta;dpsi];

% rotation about x
R{1} = [1 0 0;
        0 cos(A(1)) -sin(A(1));
        0 sin(A(1)) cos(A(1))];

% rotation about y
R{2} = [cos(A(2)) 0 sin(A(1));
        0 1 0;
        -sin(A(2)) 0 cos(A(1))];

% rotation about z
R{3} = [cos(A(3)) -sin(A(3)) 0;
        sin(A(3)) cos(A(3)) 0;
        0 0 1];

%Rotation matrix
Rba = simplify(R{1}*R{2}*R{3});

% Time deriviatve of the rotation matrix (Hint: use the function "diff"
% (the one from the Symbolic Math Toolbox) to differentiate the matrix w.r.t. the
% angles rho, theta, psi one by one, and form the whole time derivative using the
% chain rule and summing the deriviatives)
dRba = diff(Rba, A(1))*dA(1) + diff(Rba, A(2))*dA(2) + diff(Rba, A(3))*dA(3)

% Use the formulat relating Rba, dRba and Omega (skew-symmetric matrix
% underlying the angular velocity omega)
Omega = simplify(Rba.'*dRba); % Is on the form [ 0  -w_3  w_2;
                                              % w_3   0  -w_1;
                                              %-w_2  w_1   0];

% Extract the angular veloticy vector omega (3x1) from the matrix Omega (3x3)
%Pulling the angular velocity out of the skew-symmertic matrix
omega = [Omega(3, 2); % omega_1
         Omega(1, 3); % omega_2
         Omega(2, 1)]% omega_3 
% This line generates matrix M in the relationship omega = M*dA
M = jacobian(omega,dA);

% This line creates a Matlab function returing Rba and M for a given
% A  = [rho;theta;psi], can be called using [Rba,M] = Rotations(state);
matlabFunction(Rba,M,'file','Rotations','vars',{A});
