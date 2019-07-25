% Programa que calcula el coeficiente de Fricción
% para la fórmula de HW.

clear;
clc;

%Se ingresa el Número de Reynolds: re
ok = false;
while (~ok)
  try
    re = input("Ingrese el numero de Reynolds Re : ");
    ok = true;
  catch
    printf("Favor ingresar una funcion apropiada \n");
  end_try_catch
endwhile

%Se ingresa la rugosidad absoluta: e
ok = false;
while (~ok)
  try
    e = input("Ingrese la rugosidad absoluta e(mm) : ");
    ok = true;
  catch
    printf("Favor un valor apropiado \n");
  end_try_catch
endwhile

%Se ingrese el diametro interno: d
ok = false;
while (~ok)
  try
    d = input("Ingrese el diametro interno de la tuberia (m) : ");
    ok = true;
  catch
    printf("Favor un valor apropiado \n");
  end_try_catch
endwhile




% variables de la ecuacion HW
%Se ingresa la longitud: L
ok = false;
while (~ok)
  try
    L = input("Ingrese la longitud L (m) : ");
    ok = true;
  catch
    printf("Favor un valor apropiado \n");
  end_try_catch
endwhile

g = 9.8;

printf("La graverdad es de: %d m/s^2 \n",g);

#Se ingresa el valor de la perdida de calor: hf
ok = false;
while (~ok)
  try
    hf = input("Ingrese la perdida de calor (J) : ");
    ok = true;
  catch
    printf("Favor un valor apropiado \n");
  end_try_catch
endwhile

# Se reciven los valores del intevarlo: [a b]
ok = false;
while (~ok)
  try
    interval = input('Inqrese el intervalo [a b] : ');
    rows = size(interval)(1);
    columns = size(interval)(2);
    if (columns != 2)
      printf("Error, dimension incorrecta de tamaño %d, favor ingresar unicamente valores [a b]\n" , columns);
    elseif (rows != 1)
      printf("Error, se necesita un solo intervalo [a b], favor no agregar mas.\n");
    elseif (colebrook(e , d, re, interval(1)) * colebrook(e , d, re, interval(2)) > 0)
      printf("La funcion evaluada en a y b debe tener signos distintos\n");
    else
      ok = true;
    endif
  catch
    printf("Por favor, inqrese un intervalor valido de la forma [a b]\n\n");
  end_try_catch
endwhile

% Se asignan los valores de: a y b
a = interval(1);
b = interval(2);



% Proponemos un valor de f inicial para que entre al ciclo
f=1;
cont = 1;
while abs(f)>0.00001
    % Calculamos el valor de C
    c=(a+b)./2;
    % Evaluamos en C
    f = colebrook(e , d, re, c);
    if f>0
        b=c;
    else
        a=c;
    end
		Vf(cont) = c;
    cont = cont + 1;  
end

#Impresiones
fprintf('\n\n----------- Resultados ---------------\n\n');
fprintf('Intervalo Final [a, b]: [%f, %f] \n', a , b);
fprintf('Factor de Pérdida de carga f = %8.9f +- %.10f\n', c, abs(a - b));
fprintf('Velocidad del agua por el tubo = %8.9f +- %.10f  m/s \n', V(hf, d, g, c, L), abs( V(hf, d, g, a, L) - V(hf, d, g, b, L)) );

#Graficas

#Grafica 1
figure (1);
plot(Vf, colebrook(e , d, re, Vf), '*;punto (f, C(f));', "markersize", 10, [0 5],[0 0], 'k');
axis([0, 1]);
grid('on');
xlabel('f');
ylabel('Funcion Colebrook');
title('Gráfica del comportamiento de la funcion  Colebrook');
box("off");
legend_f1 = legend("location", "northeast");
set(gca,'fontsize',20);
set(legend_f1, "fontsize", 20);

#Grafica 2 --- Gráfica velocidad en función de f
figure (2);
plot(Vf, V (hf, d, g, Vf, L) , 'o;(f, Vf(f));', "markersize", 8, "markerfacecolor", "auto");
grid('on');
xlabel('valor de f');
ylabel('Velocidad (m/s)');
title('Gráfica velocidad en función de f');
box("off");
legend_f2 = legend("location", "northeast");
set(gca,'fontsize',20);
set(legend_f2, "fontsize", 20);

#Grafica 3 ---- Gráfica velocidad en función de f ampliada
figure (3);
plot(Vf, V(hf, d, g, Vf, L), 'or;(f, Vf(f));', "markersize", 13, "markerfacecolor", "auto");
grid('on');
axis ([0.048, 0.06, 8, 9], "square");
%axis ([0.0295, 0.0306, 24.5, 26], "square");
xlabel('valor de f');
ylabel('Velocidad (m/s)');
title('Gráfica velocidad en función de f ampliada');
box("off");
legend_f3 = legend("location", "northeast");
set(gca,'fontsize',20); 
set(legend_f3, "fontsize", 20);


