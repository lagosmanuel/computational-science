clf; % limpiar el gráfico
clc; % limpiar la consola

% t es un valor donde evaluar la función
% x son las absisas de los puntos dato
% y son las ordenadas de los puntos dato

function res = lagrange(t, x, y)
  if (size(x) != size(y))
    printf("ERROR: las dim. de x e y deben coincidir\n");
  end

  n = size(x)(2);
  h = abs(x(1)-x(2));
  suma = 0;

  for i=0:n-1
    prod1 = 1;
    prod2 = 1;

    for k=0:n-1
      if (k != i)
        prod1 *= t - x(k+1);
        prod2 *= x(i+1) - x(k+1);
      end
    end

    suma += (prod1/prod2) * y(i+1);
  end

  res = suma;
end

% función de correlación que aproxima a los datos
%aprox = @(T) 0.02424 * (T/303.16)^(1.27591);

% calcula el residuo cuadrado
function err = obtenerResiduoCuadrado(x, y, f)

  if (size(x) != size(y))
    printf("ERROR: las dim. de x e y no coinciden o n no es un num nat.\n");
    return;
  end

  err = 0;

  for i=0:size(x)(2)-1
    err += (f(x(i+1))-y(i+1))^2
  end
end

% puntos dato
x_0 = [300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000];
y_0 = [0.024, 0.035, 0.046, 0.058, 0.067, 0.083, 0.097, 0.111, 0.125, 0.140, 0.155, 0.170, 0.186, 0.202, 0.219, 0.235, 0.252, 0.269];

%x_0 = [300, 350, 400, 450, 500, 550, 600, 650, 700, 750, 800, 850, 900, 950, 1000, 1050, 1100, 1150, 1200, 1250, 1300, 1350, 1400, 1450, 1500, 1550, 1600, 1650, 1700, 1750, 1800, 1850, 1900, 1950, 2000];
%y_0 = [0.024, aprox(350), 0.035, aprox(450), 0.046, aprox(550), 0.058, aprox(650), 0.067, aprox(750), 0.083, aprox(850), 0.097, aprox(950), 0.111, aprox(1050), 0.125, aprox(1150), 0.140, aprox(1250), 0.155, aprox(1350), 0.170, aprox(1450), 0.186, aprox(1550), 0.202, aprox(1650), 0.219, aprox(1750), 0.235, aprox(1850), 0.252, aprox(1950), 0.269];

% graficar puntos dato
hold on;
plot(x_0, y_0, '*');

% puntos utilizados
x = [300, 1100, 2000];
y = [0.024, 0.125, 0.269];

% graficar puntos usados
hold on;
plot(x, y, '*');

% graficar la interpolación
x_eval = linspace(300, 2000, 1000);
y_eval = zeros(size(x_eval));

for i = 1:length(x_eval)
    y_eval(i) = lagrange(x_eval(i), x, y);
end

plot(x_eval, y_eval);

% calcular residuo cuadrado
err = obtenerResiduoCuadrado(x_0, y_0, @(t) lagrange(t, x, y))

% establecer las referencias
legend("puntos dato", "puntos usados", "interpolación");
title(strcat("residuo cuadrado: ", num2str(err)), 'FontSize', 15);
