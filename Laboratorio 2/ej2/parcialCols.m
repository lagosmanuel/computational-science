clc; % limpiar la pantalla

function [A, b, VP] = gaussConPivoteoParcialColumnas(A, b)
  [n, m] = size(A);
  VP = [1:n]; % vector de permutaciones de cols

  if n != m || n != size(b)
    A = zeros(n,m);
    printf("ERROR: la matriz debe ser cuadrada y coincidir con la dimensión de b\n");
    return;
  end

  for i=1:n
    % pivotear por columnas
    max = abs(A(i, i));
    col = i;
    P = eye(n, n);

    for m=i:n
        if abs(A(i, m)) > max
          max = abs(A(i, m));
          col = m;
        end
    end

    % permutar columnas
    aux = A(1:n, i);
    A(1:n, i) = A(1:n, col);
    A(1:n, col) = aux;

    % guardar vector de permutación para las incógnitas
    aux = VP(i);
    VP(i) = VP(col);
    VP(col) = aux;

    % triangular
    for k=i+1:n
      escalar = (A(k, i)/A(i, i));
      A(k, 1:n) = A(k, 1:n) -  (A(i, 1:n) .* escalar);
      b(k) = b(k) - (b(i) * escalar);
    end
  end

  VP = VP';
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

% permutar un vector según un vector de permutación VP
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

