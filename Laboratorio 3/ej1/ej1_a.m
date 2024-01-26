clf; %limpiar el gráfico

% puntos dato
x = [1, 2, 3, 4, 5, 6]
y = [2.3, 6.1, 10.7, 16.0, 21.9, 28.3]

% graficar los puntos dato
p = plot(x, y, '*');

% graficar la función de aproximación hallada g(x)
hold on;
fplot("1.994 * e^(0.4796*x)", [0 6 0 30])

% graficar la función de aproximación hallada h(x)
hold on;
fplot("2.303 * x^(1.34)",  [0 6 0 30])

% configurar los ejes y las referencias
axis([0 6.5 0 40])
legend('puntos dato','g(x)', 'h(x)')
