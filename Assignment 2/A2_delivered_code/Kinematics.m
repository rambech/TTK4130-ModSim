function [ state_dot ] = Kinematics( t, state, parameters )
    % state_dot is time derivative of your state.
    % Hints:
    % - "parameters" allows you to pass some parameters to the "Kinematic" function.
    % - "state" will contain representations of the solid orientation (SO(3)).
    % - use the "reshape" function to turn a matrix into a vector or vice-versa.

    % Code your equations here...
    euler_params = parameters;      % Is the current angular velocity
    [R, M] = Rotations(state);     % Takes current state as argument
    %dx = M\euler_params;        % Modelled dynamics of the system
    
    state_dot = M\euler_params;
end
