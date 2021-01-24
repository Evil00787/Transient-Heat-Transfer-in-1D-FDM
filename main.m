clear 
drawDynamic = 0; % draw plot after each time steps? 0 - false, 1 - true

L = 3; % length
k = 127e-6; % Thermal diffusivity
dt = 0.4; % change in time
nx = 240; % Number of gridpoints in x-direction
dx = L/(nx-1); % Spacing of grid
nt = 1200*2; % timesteps
gridcopy = zeros(nt, nx);
X = (1:1:nt) * dt;
Y = (1:1:nx) * dx;
% Stability - Courant–Friedrichs–Lewy condition
CFL = k*dt/dx^2;
if 0.5 < CFL
    disp("Unstable parameters!")
end
% Initial parameters
gridcopy(1,:) =  0;
gridcopy(1,80:160) =  20;
% 3 methods - 1. Dirichlett, 2. Neumann (isolation), 3. Heat flux
L = 3;
R = 3;
    % 3 method - variables
fluxL = 0.1;
fluxR = 0.02;
    % 1 method variables
TL = 0;
TR = 0;


for n=2:nt
    for i=2:nx-1
       gridcopy(n, i) = gridcopy(n-1,i) + k*dt*(gridcopy(n-1,i-1) - 2*gridcopy(n-1,i) + gridcopy(n-1,i+1))/dx^2;
    end
    if L == 1
        gridcopy(n, 1) = TL*2 - gridcopy(n, 2);
    elseif L == 2
        gridcopy(n, 1) = gridcopy(n, 2);
    else
        gridcopy(n, 1) = fluxL*dx/k + gridcopy(n, 2);
    end
    
    if R == 1
        gridcopy(n, end) = TR*2 - gridcopy(n, end-1);
    elseif R == 2
        gridcopy(n, end) = gridcopy(n, end-1);
    else
        gridcopy(n, end) = fluxR*dx/k + gridcopy(n, end-1);
    end
    
    if drawDynamic
        drawPlot(gridcopy(n, :), Y, n, dt);
    end
end

mesh(Y, X, gridcopy)
xlabel('Distance [m]')
ylabel('Time [s]')
zlabel('Temperature [C]')
title({['Temperature after '], [num2str(round(nt*dt)), ' s'] [num2str(round(nt*dt/60)), ' min'],[num2str(round(nt*dt/3600)), ' h '], [num2str(round(nt*dt/(3600*24))), ' d']})

