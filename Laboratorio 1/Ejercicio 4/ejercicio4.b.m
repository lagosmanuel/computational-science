n = 1; % comienzar en la iteración 1

anterior = 1;
siguiente = 0;
parciales = [];

tic(); % empezar el contador

while(anterior != siguiente)
  anterior = siguiente;
  siguiente = anterior + (1/n);
  parciales(n++) = siguiente; % guardar sumas parciales
endwhile

tiempo_total = toc(); % obtener el tiempo demorado
plot([1:n-1], parciales) % graficar suma parcial en función de la iteración n
xlabel('n');
ylabel('suma parcial');
grid;

printf(">Serie Armónica en doble precisión\n");
printf("El resultado de la sumatoria es: %Le\n", siguiente);
printf("se realizaron %ld iteraciones y demoró %Le horas", n, tiempo_total/3600);







