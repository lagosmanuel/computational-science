clf; % limpiar la gráfica del plano

delta = 0.000025;

x = linspace(1-delta, 1+delta, 300); % tomar 300 puntos linealmente espacios cerca de 1
y = (x.^3)+(2*(x.^2))-x-2;

plot(x, y, '.'); % graficar los puntos

xlabel('X');
ylabel('Y');
grid;
