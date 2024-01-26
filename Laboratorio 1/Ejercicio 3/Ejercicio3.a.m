clc; %limpiar la consola

h = logspace(-16, 0, 100); % distribución logarítmica de valores a probar
                           % entre 10^-16 y 10^0

x = 1; % punto a evaluar
y = @tan; % función a derivar
dydx = sec(x).^2; % derivada real de la función

aprox = (y(x+h)-y(x))./h; % aproximación de la derivada por diferencias
                          % finitas hacia adelante

error = abs(aprox - dydx); % error absoluto de la aproximación

[min_e, I] = min(error); % valor mínimo e índice entre los errores calculados
min_h = h(I); % valor de h para el cual se obtuvo el mínimo error
min_v = aprox(I); % mejor aproximación

loglog(h, error, '.'); % graficar los puntos calculados en escala logarítmica
xlabel("h");
ylabel("magnitud del error absoluto");
grid;

printf(">Aproximación por diferencias finitas hacia adelante\n\n");
printf("función a proximar: "); display(y);
printf("para el valor: x=%d\n", x);
printf("valor real: %Le\n", dydx);
printf("mejor aproximación: %Le\n", min_v);
printf("menor error absoluto: %Le\n", min_e);
printf("mejor paso h encontrado: %Le\n", min_h);
printf("paso h sugerido sqrt(eps): %Le\n", sqrt(eps));
printf("diferencia entre los dos pasos h: %Le\n", abs(min_h-sqrt(eps)));


