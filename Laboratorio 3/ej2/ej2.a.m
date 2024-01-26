clf; %limpiar el gráfico
clc; %limpiar la consola

% grafica spline cúbica bsada en tres puntos
% que fue calculada a mano en el informe

% graficar puntos dato
plot([-3, 0, 3], [0.1, 1, 0.1], '*');

% graficar s_0
hold on;
fplot("-0.0167 * x^3 -0.15 * x^2 + 1", [-3 0]);

% graficar s_1
hold on;
fplot("0.0167 * x^3 -0.15 * x^2 + 1", [0 3]);

% graficar f(x)
hold on;
fplot("1/(1+x^2)", [-3 3]);

% mostrar referencias
legend("puntos dato", "S_0(x)", "S_1(x)", "f(x)");

