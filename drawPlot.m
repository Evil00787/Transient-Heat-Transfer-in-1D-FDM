function[] = drawPlot(vec, Y, n, dt)
    figure(1), clf
    plot(Y, vec);
    xlabel('Odległość [m]')
    ylabel('Temperatura [C]')
title({['Temperatura po '], [num2str(round(n*dt)), ' sekundach'] [num2str(round(n*dt/60)), 'minutach'],[num2str(round(n*dt/3600)), ' godzinach '], [num2str(round(n*dt/(3600*24))), ' dniach']})
end

