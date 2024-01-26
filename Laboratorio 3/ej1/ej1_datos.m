clf; %limpiar el gráfico

% puntos dato
x = [1, 2, 3, 4, 5, 6]
y = [2.3, 6.1, 10.7, 16.0, 21.9, 28.3]

% graficar los puntos dato
p = plot(x, y, '*');

% configurar los ejes y la referencia
axis([0 6.5 0 35])
legend('puntos dato');
