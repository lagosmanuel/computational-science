x = 0; % inicializar x
y = 0; % inicializar y

function coeficientes = polinomio_cm(n, x, y)
  if (size(x) != size(y) || n < 0)
    printf("ERROR: las dim. de x e y no coinciden o n no es un num nat.\n");
    return;
  end

  m = size(x)(2);  % cantidad de datos
  A = zeros(n, n); % matriz A
  b = zeros(1, n); % vector b
  Q = {n};         % arreglo de vectores Qi
  coeficientes = zeros(1, n); % inicializar el vector resultado

  % calcular vectores Qi
  for i=1:n+1
    Q{i} = ones(1, m) .* (x.^(i-1));
  end

  % calcular A y b
  for i=1:n+1
    for j=1:n+1
      A(i, j) = dot(Q{i}, Q{j}); % producto punto
    end
    b(i) = dot(Q{i}, y); % producto punto
  end

  coeficientes = linsolve(A, b'); % resolver el sistema Ax=b
end

% recibe un valor x y un vector de coeficientes de menor a mayor grado
% para computar un polinomio
function y = computarPolinomio(x, coeficientes)
  y = 0;

  for i=0:size(coeficientes)(1)-1
    y += (x^i) * coeficientes(i+1);
  end
end

% calcula el residuo cuadrado de una aproximación polinomial dada por los coeficientes
function err = obtenerResiduoCuadrado(x, y, coeficientes)
  if (size(x) != size(y))
    printf("ERROR: las dim. de x e y no coinciden o n no es un num nat.\n");
    return;
  end

  err = 0;

  for i=0:size(x)(2)-1
    err += (computarPolinomio(x(i+1), coeficientes)-y(i+1))^2;
  end
end

% convierte un vector de coeficientes de un polinomio, de menor a mayor grado
% en una cadena de caracteres para ser graficada con fplot
function str = polinomioToString(coeficientes)
  str = "";

  for i=0:size(coeficientes)(1)-1
    aux = "";

    if (i!=size(coeficientes)(1)-1)
      aux = "+";
    end

    str = strcat(str, num2str(coeficientes(i+1)), "*", "x", "^", num2str(i), aux);
  end
end

clc; %limpiar la consola
clf; %limpiar el gráfico

% cargar valores
n = 5;
x = [0, 1, 2, 3, 4, 5];
y = [1, 2.7, 5.8, 6.6, 7.5, 9.9];

% n es la el grado del polinomio de la aproximación
% x es un vector fila con los valores de la variable independiente
% y es un vector fila con los valores de la variable dependiente

% computar aproximación y residuo cuadrado
coeficientes = polinomio_cm(n, x, y);
err = obtenerResiduoCuadrado(x, y, coeficientes);

% graficar aproximación
fplot(polinomioToString(coeficientes));
hold on; % manter el gráfico anterior
plot(x, y, '*'); % graficar puntos dato

axis([-1 6 0 12]) % establecer límites para los ejes
legend('datos',strcat('g_',num2str(n),'(t)')); % cambiar la leyenda del gráfico

% mostrar como título el residuo cuadrado
txt = strcat("residuo cuadrado: ", num2str(err));
t = title({strcat("f(x)=", polinomioToString(coeficientes)), txt});

% mostrar resultados por consola
printf("polinomio encontrado de grado %d: %s\n", n, polinomioToString(coeficientes));
printf("residuo cuadrado: %E\n", err);
