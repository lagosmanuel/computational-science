clf; % limpiar la gráfica del plano

delta = 1;

x = linspace(1-delta, 1+delta);
y = (x.^3)+(2*(x.^2))-x-2;

plot(x, y);

xlabel('Eje X');
ylabel('Eje Y');
grid;
