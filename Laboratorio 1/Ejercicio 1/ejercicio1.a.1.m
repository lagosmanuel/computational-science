clf; % limpiar la gráfica del plano

delta = 1;

x = linspace(1-delta, 1+delta);
y = (x.^3)-(3*(x.^2))+(3*x)-1;

plot(x, y);
xlabel('X');
ylabel('Y');
grid;
