% HH Cable model 
L = 1; % axon length (cm)
dx = 0.01; % x_increment (cm)
M = round(L/dx)+1; % total nodal points
% Cm = 1; % uF/cmˆ2
% g_Na = 120000; % uS/cmˆ2
% g_K = 36000; % uS/cmˆ2
% g_L = 300; % uS/cmˆ2
% rho_i = 0.0006; % Mohm.cm
% r = 0.0025; % cm
Y_init = [];
for j = 1:M-2
    Y_init = [Y_init, -60, 0.3177, 0.0529, 0.5961];
end;
Y_init(1) = 20; % initial conditions at x(0)
[time, Y] = ode15s('HH_cable', [0 0.02], Y_init);
% plot
VV = [Y(:,1), Y(:,1:4:end), Y(:,end-3)]; % V (incl. boundary values)
[TT, XX] = meshgrid(time,0:dx:L);
mesh(XX,TT,VV'), 
xlabel('x (cm)'), 
ylabel('t (s)'), 
zlabel('V (mV)');
