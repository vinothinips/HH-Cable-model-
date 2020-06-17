function y_cable = HH_cable(t,y)

% Variables
dx = 0.01; % x_increment (cm)
Cm = 1; % Membrane capacitance uF/cmˆ2
g_Na = 120000; % uS/cmˆ2
g_K = 36000; % uS/cmˆ2
g_L = 300; % uS/cmˆ2
rho_i = 0.0006; % Resistivity Mohm.cm
r = 0.0025; % Radius cm
y_cable = zeros(size(y));
Len = length(y)/4;

for j = 1:Len
    V = y(4*j-3);
    n = y(4*j-2);
    m = y(4*j-1);
    h = y(4*j);
    
    a_n = 10*(V+50)/(1-exp(-(V+50)/10));
    b_n = 125*exp(-(V+60)/80);
    a_m = 100*(V+35)/(1-exp(-(V+35)/10));
    b_m = 4000*exp(-(V+60)/18);
    a_h = 70*exp(-(V+60)/20);
    b_h = 1000/(1+exp(-(V+30)/10));
    
    % Ionic currents
    i_K = g_K*n^4*(V+72);
    i_Na = g_Na*m^3*h*(V-55);
    i_L = g_L*(V+49.387);
    i_ion = i_K+i_Na+i_L;
    
        if (j == 1) % zero-flux b.c.
            y_cable(1) = (r/(2*rho_i*dx^2)*(y(5)-2*y(1)+y(1))-i_ion)/Cm;
        elseif (j == Len) % zero-flux b.c.
            y_cable(4*Len-3) = (r/(2*rho_i*dx^2)*(y(4*Len-7)-2*y(4*Len-3)+y(4*Len-3))-i_ion)/Cm;
        else
            y_cable(4*j-3) = (r/(2*rho_i*dx^2)*(y(4*j-7)-2*y(4*j-3)+y(4*j+1))-i_ion)/Cm;
        end
        
    y_cable(4*j-2) = a_n*(1-n)-b_n*n;
    y_cable(4*j-1) = a_m*(1-m)-b_m*m;
    y_cable(4*j) = a_h*(1-h)-b_h*h;
end