% Programa que calcula el coeficiente de Fricci�n
% para la f�rmula de HW.

clear;
clc;

%Se ingresa el N�mero de Reynolds: re
ok = false;
while (~ok)
  try
    re = input("Ingrese el numero de Reynolds ");
    ok = true;
  catch
    printf("Favor ingresar una funcion apropiada \n");
  end_try_catch
endwhile

%Se ingresa la rugosidad absoluta: e
ok = false;
while (~ok)
  try
    e = input("Ingrese la rugosidad absoluta ");
    ok = true;
  catch
    printf("Favor un valor apropiado \n");
  end_try_catch
endwhile

%Se ingrese el diametro interno: d
ok = false;
while (~ok)
  try
    d = input("Ingrese el diametro interno en metros ");
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
    L = input("Ingrese la longitud L en metros ");
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
    hf = input("Ingrese la perdida de calor en joules ");
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
      printf("Error, dimension incorrecta de tama�o %d, favor ingresar unicamente valores [a b]\n" , columns);
    elseif (rows != 1)
     printf("Error, se necesita un solo intervalo [a b], favor no agregar mas.\n");
    else
      ok = true;
    endif
#------ verificar que el signo de f(a) es diferente del signo de f(b)--------
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
fprintf('Factor de P�rdida de carga =%8.9f \n', c)
fprintf('Velocidad del agua por el tubo =%8.9f \n', (2* hf*d*g/(c*L))^0.5 )

#Graficas

#Grafica 1
Xf = [-2:0.02:2];
plot(Xf, colebrook(e , d, re, Xf))

#Grafica 2
Vv = (2* hf*d*g./(Vf*L)).^0.5;
plot(Vf,Vv, 'o');
xlabel('F');
ylabel('Velocidad');
title('Gr�fica velocidad en funci�n de f');