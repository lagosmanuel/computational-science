n = 11;    % cantidad de puntos dato
ini = -3;  % valor inicial
fin = 3;   % valor final
y = @(x) 1./(1+(x.^2)); % defini la función

x = linspace(ini, fin, n); % generar n puntos datos
y = y(x);                  % evaluar la función en los puntos dato

xx = ini:.1:fin;           % puntos donde evaluar la spline
yy = spline(x,y,xx);       % calcular la spline

% mostrar el resultado de la spline
plot(x,y,'*',xx,yy);

% graficar f(x)
hold on;
fplot("1/(1+x^2)", [ini fin]);

% mostrar referencias
legend("puntos dato", "spline", "f(x)");

