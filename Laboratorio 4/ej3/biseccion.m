% limpiar la consola
clc;

function [res, i] = bisecc(f, a, b, ITERACIONES, TOL)
    i = 0;
    res = a + ((b-a)./2);

    while (abs(f(res)) > TOL && i < ITERACIONES)
      res = a + ((b-a)./2);

      if (f(a) * f(res) > 0)
        a = res;
      else
        b = res;
      end

      i += 1;
    end
end

% constantes para criterio de parada
ITERACIONES = 100000;
TOL = eps;

% funciones
% f = @(x) x.^3 -2*x - 5;
% f = @(x) e.^(-x) - x;
% f = @(x) x * sin(x) - 1;
% f = @(x) x.^3 -3*x.^2+3*x-1;

% funcion a obtener f(x) = 0
f = @(x) x.^3 -3*x.^2+3*x-1;

% aproximacion incial
a = 0;
b = 2;

% calcular aproximacion
tic; % empezar a medir el tiempo
[res, i]= bisecc(f, a, b, ITERACIONES, TOL);
time = toc; % obtener el tiempo de ejecucion

format long;
printf("APROXIMACION CON EL METODO DE BISECCION \n");

% mostrar funcion
printf("funcion a buscar ceros: ");
disp(f);

% mostrar invervalo
printf("intervalo a buscar ceros: [%d, %d]\n", a, b);

% mostrar cantidad de iteraciones
printf("cantidad de iteraciones: ");
disp(i);

% mostrar tiempo de ejecucion
printf("tiempo de ejecucion en segundos: ");
disp(time)

% mostrar error
printf("resultado: ");
disp(res(1));

% mostrar resultado
printf("error absoluto: ");
disp(abs(f(res)));

% mostrar resultado con fzero
printf("resultado de fzero: ");
disp(fzero(f, (b-a)/2));

% diferencia resultado con fzero
printf("diferencia con fzero: ");
disp(abs(res - fzero(f, (b-a)/2)));


