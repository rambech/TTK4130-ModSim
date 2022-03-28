% ODE(6)

x2 = ode45(@(x2) myroot(x2), [t0 tend], x0(2));

% Plot
figure(1); clf; hold on; grid on;
plot(t, x2, 'displayname', 'x1');
%plot(t, x(:,2), 'displayname', 'x2');
legend();
xlabel('t');
ylabel('x');

figure(2); clf; hold on; grid on;
plot(x2, 'displayname', '1');

legend();
xlabel('x1');

function dx = myroot(x)
     dx = sqrt(abs(x));
end