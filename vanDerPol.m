clear; clc; 


t0 = 0;
tend = 10; % end time 

x0 = [1.5; 1.5]; %[1; 1]; % [1.5; 1.5]; % ; % initial value


param = @(t) 4 + 0*(log(t+3));

u = @(t) 0*(2 + 3*sin(t));

[t, x] = ode45(@(t, x) vdpDynamics(t, x, u, param), [t0 tend], x0); 

param2 = @(t) 0.1*param(t);
[tau, xp] = ode45(@(t, x) vdpDynamics(t, x, u, param2), [t0 tend], x0); 
%% plot
figure(1); clf; hold on; grid on;
plot(t, x(:,1), 'displayname', 'x1');
plot(t, x(:,2), 'displayname', 'x2');
legend();
xlabel('t');
ylabel('x');

figure(2); clf; hold on; grid on;
plot(x(:,1), x(:,2), 'displayname', '1');

plot(xp(:, 1), xp(:, 2), 'displayname','0.1');
legend();
xlabel('x1');
ylabel('x2');

%%

function dx = vdpDynamics(t, x, u, param)
    mu = param;
    dx1 = x(2); 
    dx2 = mu(t)*(1-x(1)^2)*x(2) - x(1) + u(t);
    dx = [dx1;dx2];
end 
