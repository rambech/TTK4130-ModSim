clear all
close all
clc

time_final = 20; %Final time

%%%%%% MODIFY. Initial state values and parameter values
init_state = [0;0;0]; % We start with zero as initial angle
parameters = [3;1;2]; % We start with zero velocity

% Simulate dynamics
try
    %%%%%% MODIFY THE FUNCTION "Kinematics" TO PRODUCE SIMULATIONS OF THE SOLID ORIENTATION
    %%%%%%
    %%%%%% Hints:
    %%%%%% - "parameters" allows you to pass some parameters to the "Kinematic" function.
    %%%%%% - "state" will contain representations of the solid orientation (SO(3)).
    %%%%%% - use the "reshape" function to turn a matrix into a vector or vice-versa.
    
    [time,statetraj] = ode45(@(t,x) Kinematics(t, x, parameters), [0,time_final], init_state);

catch message
    display('Your simulation failed with the following message:')
    display(message.message)
    display(' ')

    %Assign dummy time and states if simulation failed
    time = [0,10];
    statetraj = [0,0];
end

%Below is a template for a real-time animation
ScaleFrame = 5;   % Scaling factor for adjusting the frame size (cosmetic)
FS         = 15;  % Fontsize for text
SW         = 0.035; % Arrows size

time_display = 0; % initialise time_display
while time_display < time(end)

    state_animate = interp1(time,statetraj,time_display); %interpolate the simulated state at the current clock time

    p     = [5;5;5];  % Position of the single body

    %%%%%% MODIFY THE FOLLOWING LINES TO PRODUCE AN "omega" AND "R" FROM YOUR SIMULATION STATE

    %omega = [0;0;4];  % Some random Omega

    %R     = [   -0.8603    0.4343   -0.2670
     %           -0.4771   -0.8705    0.1213
      %          -0.1797    0.2317    0.9560]; % Some random rotation matrix
    
    omega = parameters; % Fetches parameters from ODE45
    R = Rotations(state_animate.'); % Fetches animation states and transforms the frame from b to a
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %3D below this point
    figure(1);clf;hold on
    MakeFrame( zeros(3,1),eye(3),ScaleFrame,FS,SW,'a', 'color', 'k')
    MakeFrame( p,R,ScaleFrame,FS,SW,'b', 'color', 'r')
    MakeArrow( p,R*omega,FS,SW,'$$\omega$$', 'color', [0,0.5,0])
    DrawRectangle(p,R ,'color',[0.5,0.5,0.5]);
    FormatPicture([0;0;2],0.5*[73.8380   21.0967   30.1493])

    if time_display == 0
        display('Hit a key to start animation')
        pause
        tic
    end
    time_display = toc; %get the current clock time
end
