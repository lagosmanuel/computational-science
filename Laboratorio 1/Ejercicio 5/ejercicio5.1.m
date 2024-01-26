clc; % limpiar la consola

n = 50;

function resultado = obtener_matriz(n)
  x1 = (n+2)/(2*n+2);
  x2 = 1/(2*n+2);
  x3 = [-1/2, 1, -1/2];

  primera_fila = [x1, x3(3), zeros(1, n-3), x2];

  medio = [];
  for i=1:n-2
    nueva_fila = [zeros(1, i-1), x3, zeros(1, n-(i-1)-3)];
    medio = [medio; nueva_fila]; % agregar la nueva fila
  endfor

  ultima_fila = [x2, zeros(1, n-3), x3(1), x1];

  resultado = [primera_fila; medio; ultima_fila];
endfunction

A = obtener_matriz(n);
B = inv(A); % obtener la inversa de A

C = A*B;
suma = 0;

for i=1:n
  for j=1:n
    suma += C(i, j);
  endfor
endfor

printf(">Calcular la inversa de la matriz A\n");
display(B); % imrpimir la matriz B
printf("Se calculó la inversa con un error de: %Le\n", abs(n-suma));

