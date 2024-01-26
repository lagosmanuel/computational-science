% limpiar la consola
clc;

function [x, i] = pfijo(f, x, ITERACIONES, TOL)
    i = 0;
    while (abs(f(x)-x) > TOL && i < ITERACIONES)
      x = f(x);
      i += 1;
    end
end

% constantes para criterio de parada
ITERACIONES = 1000;
TOL = eps;

% funciones
% f = @(x) (x.^2+2)/3;
% f = @(x) sqrt(3*x-2);

% funcion a obtener f(x) = x
f = @(x) sqrt(3*x-2);

% aproximacion incial
inicial = 2 + 10.^-10;

% calcular aproximacion
tic; % empezar a medir el tiempo
[res, i]= pfijo(f, inicial, ITERACIONES, TOL);
time = toc; % obtener el tiempo de ejecucion

format long;
printf("APROXIMACION CON EL METODO DE PUNTO FIJO \n\n");

% mostrar funcion
printf("funcion a buscar f(x)=x: ");
disp(f);

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
disp(abs(f(res(1))-res(1)));



