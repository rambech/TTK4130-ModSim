clear all
%close all
clc

% Define your initial state, e.g. as:
% state = [position;
%          orientation;
%          velocity;
%          angular velocity];

% "parameters" allows you to pass some parameters to the "SatelliteDynamics" function

time_final = 120; %Final time

% Simulate satellite dynamics
[time,statetraj] = ode45(@(t,x)SatelliteDynamics(t, x, parameters),[0,time_final],state);

% Here below is a template for a real-time animation
tic; % resets Matlab clock
time_display = 0; % time displayed
while time_display < time(end)
    time_animate = toc; % get the current clock time
    % Interpolate the simulation at the current clock time
    state_animate = interp1(time,statetraj,time_animate);
    
    %Fetch proper states from state_animate to display satellite (p, R, omega) 
    
%     p = 
%     R = 
%     omega = 

    ScaleFrame = 5;   % Scaling factor for adjusting the frame size (cosmetic)
    FS         = 15;  % Fontsize for text
    SW         = 0.035; % Arrows size
    
    %Display satellite
    figure(1);clf;hold on
    MakeFrame(zeros(3,1),eye(3),ScaleFrame,FS,SW,'a', 'color', 'k')
    MakeFrame(p,R,ScaleFrame,FS,SW,'b', 'color', 'r')
    MakeArrow(p,R*omega,FS,SW,'$$\omega$$', 'color', [0,0.5,0])
    DrawRectangle(p,R ,'color',[0.5,0.5,0.5]);
    FormatPicture([0;0;2],0.5*[73.8380   21.0967   30.1493])

    if time_display == 0
        display('Hit a key to start animation')
        pause
        tic
    end
    time_display = toc; % get the current clock time
end
