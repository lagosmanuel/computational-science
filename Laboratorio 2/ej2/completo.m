clc; % limpiar la pantalla

function [A, b, VP] = gaussConPivoteoCompleto(A, b)
  [n, m] = size(A);
  VP = [1:n]; % vector de permutaciones de cols

  if n != m || n != size(b)
    A = zeros(n,m);
    printf("ERROR: la matriz debe ser cuadrada y coincidir con la dimensión de b\n");
    return;
  end

  for i=1:n
    % pivotear completo
    max = abs(A(i, i));
    pos = [i, i];
    P = eye(n, n);

    for k=i:n
      for m=i:n
        if abs(A(k, m)) > max
          max = abs(A(k, m));
          pos = [k, m];
        end
      end
    end

    % permutar filas
    aux = A(i, 1:n);
    A(i, 1:n) = A(pos(1), 1:n);
    A(pos(1), 1:n) = aux;
    aux = b(i);
    b(i) = b(pos(1));
    b(pos(1)) = aux;

    % permutar columnas
    aux = A(1:n, i);
    A(1:n, i) = A(1:n, pos(2));
    A(1:n, pos(2)) = aux;

    % guardar vector de permutación para las incógnitas
    aux = VP(i);
    VP(i) = VP(pos(2));
    VP(pos(2)) = aux;

    % triangular
    for k=i+1:n
      escalar = (A(k, i)/A(i, i));
      A(k, 1:n) = A(k, 1:n) -  (A(i, 1:n) .* escalar);
      b(k) = b(k) - (b(i) * escalar);
    end
  end
end

function x = sustHaciaAtras(A, b)
  [n, m] = size(A);
  x = zeros(1, n); % vector de resultados

  if n != m || n != size(b)
    A = zeros(n,m);
    printf("ERROR: la matriz debe ser cuadrada y coincidir con la dimensión de b\n");
    return;
  end

  for i= [n:-1:1] % recorrer la matriz de abajo hacia arriba
    aux = 0; % suma de cada x_j de la fila por cada coeficiente
             % en base a resultados anteriores

    for j=i+1:n   % recorrer la fila hacia derecha
      if j != i
        aux += A(i, j) * x(j); % agregar x_j * a(i, j)
      end
    end

    x(i) = (b(i)- aux)/A(i, i); % calcular el nuevo x_i
  end
  x = x'; % devolver como vector columna
end

% permutar un vector según un vector de permutacion VP
function xp = permutarVector(x, VP)
  [n, m] = size(x);

  if size(x) != size(VP)
    printf("ERROR: las dimensiones del vector y el vec. de permutación no coinciden\n");
    return;
  end

  xp = zeros(1, n); % vector permutado

  for i=1:n
    xp(VP(i)) = x(i); % reescribir el vector x según el vector de permutación
  end

  xp = xp'; % devolver como vector columna
end

function [] = testear(n)
  display("probando el método de eliminaciín gauss para sistemas lineales con pivoteo parcial");

  tic % controlar tiempo de ejecución

  A = [ 1, 0, 0, 0, 1;
     -1, 1, 0, 0, 1;
     -1,-1, 1, 0, 1;
     -1,-1,-1, 1, 1;
     -1,-1,-1,-1, 1 ];

  for i=1:n
     b = rand(1,5)'; % generar un vector aleatorio para los térs. ind.
     x = inv(A) * b; % obtener la solución del sistema

     [A2, b2, PV] = gaussConPivoteoCompleto(A, b); % obtener el pivoteo
     x2 = sustHaciaAtras(A2, b2); % realizar la sustitución
     x2 = permutarVector(x2, PV');
     error = norm(x - x2); % computar el error
     residuo = norm((A * x2) - b); % computar el residuo

     printf("exp %d. la norma del error es %E y la norma del residuo %E\n", i, error, residuo);
  end

  toc % fin tiempo de ejecución
end

testear(20);


