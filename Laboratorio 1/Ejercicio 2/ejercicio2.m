clc; % limpiar la consola

n = 20; % definir la dimensión
A = zeros(n); % crear la matriz A

% generar la matriz de Hilbert para n en A
for i = 1:n
  for j = 1:n
    A(i, j) = 1/((i+j)-1);
  endfor
endfor

[autovectores, autovalores] = eig(A) % obtener los autovectores y autovalores de A


