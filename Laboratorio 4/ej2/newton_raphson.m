% limpiar la consola
clc;

function dfdx = difcentr(f, x)
    h = sqrt(eps); % segun la regla del pulgar
    dfdx = (f(x+h)-f(x-h))/(2*h);
end

function [siguiente, i] = newton(f, anterior, ITERACIONES, TOL)
    i = 0;
    siguiente = anterior;

    while (abs(f(anterior)) > TOL && i < ITERACIONES)
      aux = siguiente;
      siguiente = anterior - f(anterior)/difcentr(f, anterior);
      anterior = aux;
      i += 1;
    end
end

% constantes para criterio de parada
ITERACIONES = 100000;
TOL = eps;

% funciones
% f = @(x) x.^4 - x - 10;
% f = @(x) e^(-x) - sin(x);
% f = @(x) x.^3 - 8*x.^2 + 17*x - 10;
% f = @(x) log(x)-cos(x);
% f = @(x) x.^4 - 5*x.^3 - 12*x.^2 + 76 * x - 79;

% f = @(x) x.^3 -2*x - 5;
% f = @(x) e.^(-x) - x;
% f = @(x) x * sin(x) - 1;
% f = @(x) x.^3 -3*x.^2+3*x-1;

% funcion a obtener f(x) = 0
f = @(x) x.^4 - x - 10;

% aproximacion incial
inicial = -2;

% calcular aproximacion
tic; % empezar a medir el tiempo
[res, i]= newton(f, inicial, ITERACIONES, TOL);
time = toc; % obtener el tiempo de ejecucion

format long;
printf("APROXIMACION CON EL METODO DE NEWTON-RAPHSON \n");

% mostrar funcion
printf("funcion a buscar ceros: ");
disp(f);

% mostrar x_0 inicial
printf("a partir de x_0 inicial: ");
disp(inicial);

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

tic;
fz = fzero(f, inicial);
time = toc;

disp(fz);

% mostrar tiempo de ejecucion de fzero
printf("tiempo de ejecucion de fzero en segundos: ");
disp(time)

% diferencia resultado con fzero
printf("diferencia con fzero: ");
disp(abs(res - fz));


