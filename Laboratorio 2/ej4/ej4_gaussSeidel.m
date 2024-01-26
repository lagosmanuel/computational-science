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
  el = A(i, i);

    for j = 1:m
      if j != i && A(i, j)>=el
        res = false;
        break;
      end
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

% comprobar si Gauss Seidel converge
function res = convergeGaussSeidel(A)
  res = false;

  [n, m] = size(A);
  if n != m
    return;
  end
                                      % el método de Gauss Seidel converge si:
  if (esSimetrica(A) && esDefPos(A))  % 1. A es simétrica y definida positiva (cond. suf.)
    res = true;
  elseif (esDiagonalEstrictaFilas(A)) % 2. A es diag. estric. por filas (cond. suf.)
    res = true;
  else
    [L, D, U] = descomponerLDU(A);
    Mitr = -1 * inv(L + D) * U;
    if (norm(Mitr) < 1)               % 3. ||Mitr|| < 1 (cond. suf.)
        res = true;
    elseif (max(abs(eig(Mitr))) < 1)  % 4. ρ(Mitr) < 1 (cond. nec. y suf.)
        res = true;
    end
  end
end

% resolver Ax=b con el método de Gauss Seidel a partir del x1 dado y hasta obtener cierto error.
function x = gaussSeidel(A, b, x, error)
   [n, m] = size(A);
   resto = 0;

   if (n != m || n != size(b)(1) || size(b) != size(x)) % chequear las dimensiones de los argumentos
     fprintf("ERROR: La matriz debe ser cuadrada y coincidir con la dimensión de b y x1\n");
   elseif convergeGaussSeidel(A) % comprobar si el método de Gauss Seidel converge
     resto = norm((A*x)-b, Inf); % calcular el resto con norma infinito

     while (resto > error) % iterar hasta obtener el error deseado
       for i = 1:n
         aux1 = 0; %calculo auxiliar 1 para la fórmula de xi_k+1
         for j = 1:i-1
           aux1 += (A(i, j) * x(j));
         end

         aux2 = 0; %calculo auxiliar 2 para la fórmula de xi_k+1
         for j = i+1:n
           aux2 += (A(i, j) * x(j));
         end

         x(i) = (1/A(i, i)) * (b(i) - aux1 - aux2); % fórmula de xi_k+1
       end

       resto = norm(A*x-b, Inf); % volver a calcular el resto
     end
   else
     fprintf("ERROR: La matriz no converge con el método de Gauss Seidel\n");
   end
end

% setear los parámetros
n = 80;
[A, b] = generarMatriz(n);
x_inicial = zeros(n, 1);
error = 10^-5;

tic % comenzar a medir el tiempo de ejecucin

% resolver por el método de Gauss Seidel
x = gaussSeidel(A, b, x_inicial, error);

toc  % obtener el tiempo de ejecucin

%informar resultados
format("long");

printf("El x obtenido es: \n\n");
display(x);

printf("El resultado de Ax es: \n\n");
display(A*x);

printf("El resto en norma infinito ||Ax-b||_inf es: \n\n");
display(norm(A*x-b, Inf));



