function [ state_dot ] = SatelliteDynamics( t, x, parameters )

    % Code your equations here...

    % The code must return in the order you selected, e.g.:
    %    state_dot =  [velocity;
    %                  orientation_dot;
    %                  acceleration (ac);
    %                  angular acceleration (omega dot)];
    pos = x(1:3); % Position of the satellite in x, y, z coordinates
    vel = x(13:15); % Velocity of the satellite in x, y, z coordinates
    omega = x(16:18); % Angular velocity around the x, y, z axes
    R = reshape(x(4:12), [3, 3]); % Rotational matrix
    omega_skew = [0, -omega(3), omega(2);
                  omega(3), 0, -omega(1);
                  -omega(2), omega(1), 0];
    
    G = parameters(1);
    m_T = parameters(2);
    norm_of_r = parameters(3);
    M = parameters;
    
    gravity = - G * m_T / norm_of_r^3;
    omega_b_wb = -M\omega_skew*M*omega;
    
    
    state_dot = [vel;
                reshape(R*omega_skew, 9, 1);
                gravity;
                omega_b_wb]   
end
