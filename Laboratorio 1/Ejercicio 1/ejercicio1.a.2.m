clf; % limpiar la gráfica del plano

delta = 0.000025;

x = linspace(1-delta, 1+delta, 640); % tomar 640 puntos linealmente espaciados cerca de 1
y = (x.^3)-(3*(x.^2))+(3*x)-1;

plot(x, y, '.'); % graficar los puntos
xlabel('X');
ylabel('Y');
grid;
