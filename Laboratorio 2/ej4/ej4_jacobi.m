clc; % limpiar la consola

% generar la matriz A y el vector b del enunciado
function [A, b] = generarMatriz(n)
  A = zeros(n);
  b = zeros(n, 1);

  for i = 1:n
    b(i) = pi;

    for j = 1:n
      el = 0;
      if j == i
        el = 2 * i;
      elseif j == i+2 && i<=78
        el = 0.5 * i;
      elseif j == i-2 && i>=3
        el = 0.5 * i;
      elseif j == i+4 && i<=76
        el = 0.25 * i;
      elseif j == i-4 && i>=5
        el = 0.25 * i;
      end
      A(i, j) = el;
    end
  end
end

% chequear si A es simétrica
function res = esSimetrica(A)
    res = A==A';
end

% chequear si A es definida positiva
function res = esDefPos(A)
    res = true;
    [n, m] = size(A);

    if n == m
        for i = 1:n
          if (det(A(1:i, 1:i)) <= 0)
           res = false;
           break
          end
        end
    end
end

% chequear si A es diagonal estricta por filas
function res = esDiagonalEstrictaFilas(A)
  [n, m] = size(A);
  res = true;

  for i = 1:n
    el = abs(A(i,i));
    sum = 0;

    for j = 1:m
      if i != j
        sum += abs(A(i, j));
      end
    end

    if sum >= el
      res = false;
    end
  end
end

% descomponer A en A = L + D + U
function [L, D, U] = descomponerLDU(A)
  D = A .* eye(size(A));
  L = A .* tril(ones(size(A)));
  U = A .* triu(ones(size(A)));
  L = L - D;
  U = U - D;
end

% comprobar si Jacobi converge
function res = convergeJacobi(A)
  res = false;

  [n, m] = size(A);
  if n != m
   return;
  end
                                         % el método de Jacobi converge si:
  if (esDiagonalEstrictaFilas(A))        % 1. A es diag. estric. por filas (cond. suf.)
    res = true;
  else
    [L, D, U] = descomponerLDU(A);
    Mitr = -1 * inv(D) * (L + U);        % 2. ||Mitr|| < 1 (cond. suf.)
    if (norm(Mitr) < 1)
        res = true;
    elseif (max(abs(eig(Mitr))) < 1)     % 3. ρ(Mitr) < 1 (cond. nec. y suf.)
        res = true;
    end
  end
end

% resolver Ax=b con el método de Jacobi a partir del x_anterior dado y hasta obtener cierto error.
function x_siguiente = jacobi(A, b, x_anterior, error)
   [n, m] = size(A);
   resto = 0;
   x_siguiente=x_anterior;

   if (n != m || n != size(b)(1) || size(b) != size(x_anterior)) % chequear las dimensiones de los argumentos
     fprintf("ERROR: La matriz debe ser cuadrada y coincidir con la dimensión de b y x_anterior\n");
   elseif convergeJacobi(A) % comprobar si el método de Jacobi converge
     resto = norm((A*x_siguiente)-b, Inf); % calcular el resto con norma infinito

     while (resto > error) % iterar hasta obtener el error deseado
       for i = 1:n
         aux = 0; %calculo auxiliar para la fórmula de xi_k+1
         for j = 1:n
           if (j != i)
             aux += (A(i, j) * x_anterior(j));
           end
         end

         x_siguiente(i) = (1/A(i, i)) * (b(i) - aux); % fórmula de xi_k+1
       end

       resto = norm(A*x_siguiente-b, Inf); % volver a calcular el resto
       x_anterior = x_siguiente; % actualizar el anterior
     end
   else
     fprintf("ERROR: La matriz no converge con el método de Jacobi\n");
   end
end

% setear los parámetros
n = 80;
[A, b] = generarMatriz(n);
x_inicial = zeros(n, 1);
error = 10^-5;

tic % comenzar a medir el tiempo de ejecucin

% resolver por el método de Jacobi
x = jacobi(A, b, x_inicial, error);

toc % obtener el tiempo de ejecucin

%informar resultados
format("long");

printf("El x obtenido es: \n\n");
display(x);

printf("El resultado de Ax es: \n\n");
display(A*x);

printf("El resto en norma infinito ||Ax-b||∞ es: \n\n");
display(norm(A*x-b, Inf));
