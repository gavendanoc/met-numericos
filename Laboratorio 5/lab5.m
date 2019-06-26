clc #Limpia todo el texto de la ventana de comando
clear all #Limpia todas las variables antes de entrar al programa.

#Se le pide al usuario que ingrese el valor x del nodo x.
ok = false;
while (~ok)
  try
    t0=input('Ingrese el valor X del primer nodo. ');#La variable 't0' representa el valor de la coordenada x del primer nodo.
    ok = true;
  catch
    printf("Por favor, ingrese un numero válido.\n\n");#Esta función try-catch es para que el usuario solo pueda ingresar números, ya que n es una variable numérica. Esta función se ve frecuentemente en este código.
  end_try_catch
endwhile

#Se le pide al usuario que ingrese el valor x del nodo x.
ok = false;
while (~ok)
  try
    printf("1. Fórmula de diferencias progresivas. \n2. Fórmula de diferencias regresivas \n3. Fórmula de diferencias centradas \n");
    fd=input('Ingrese la fórmula de derivación que desea usar. ');#La variable 'fd' representa el valor de la formula que usará el programa.
    ok = true;
  catch
    printf("Por favor, ingrese un numero válido.\n\n");#Esta función try-catch es para que el usuario solo pueda ingresar números, ya que n es una variable numérica. Esta función se ve frecuentemente en este código.
  end_try_catch
  if fd ~= 1 && fd ~= 2 && fd ~= 3
    ok = false;
    printf("Recuerde que debe ingresar un número entre 1 y 3.\n");
  endif
endwhile

xF=t0-4:4/25:t0+4;

#Con este switch se calculan los valores de x y de la funcion en los nodos.
switch fd
  case 1
    for i = 1:5
      f(i) = 0;
      for j = 1:5 # Con estos ciclos se asignan los valores a las coordenadas 'x' y 'y' de los nodos, para así calcular los coeficientes
        x(i,j) = t0 + (j-1) * 10^(1-i);
        y(i,j) = cos(x(i,j));
      endfor
    endfor
  case 2
    for i = 1:5
      f(i) = 0;
      for j = 1:5 #Lo mismo sucede con los otros casos de este switch
        x(i,j) = t0 - (j-1) * 10^(1-i);
        y(i,j) = cos(x(i,j));
      endfor
    endfor
  case 3
    for i = 1:5
      f(i) = 0;
      for j = 1:5
        if mod(j,2) == 1
          x(i,j) = t0 + ((1-j)/2) * 10^(1-i);
          y(i,j) = cos(x(i,j))#Las coordenadas y se igualan al coseno de las x
        else
          x(i,j) = t0 + (j/2) * 10^(1-i);
          y(i,j) = cos(x(i,j));
        endif
      endfor
    endfor  
endswitch


for k = 1:5#Este for es para hallar los coeficientes
  a(k,1) = (y(k,2)-y(k,1))/(x(k,2)-x(k,1));
  a(k,2) = ((y(k,3)-y(k,2))/(x(k,3)-x(k,2)) - a(k,1))/(x(k,3)-x(k,1));
  a(k,3) = (((y(k,4)-y(k,3))/(x(k,4)-x(k,3))-(y(k,3)-y(k,2))/(x(k,3)-x(k,2)))/(x(k,4)-x(k,2))-a(k,2))/(x(k,4)-x(k,1));
  a(k,4) = ((((y(k,5)-y(k,4))/(x(k,5)-x(k,4))-(y(k,4)-y(k,3))/(x(k,4)-x(k,3)))/(x(k,5)-x(k,3))-((y(k,4)-y(k,3))/(x(k,4)-x(k,3))-(y(k,3)-y(k,2))/(x(k,3)-x(k,2)))/(x(k,4)-x(k,2)))/(x(k,5)-x(k,2))-a(k,3))/(x(k,5)-x(k,1));
endfor

#Columnas de la tabla que se muestra al final
Incremento = [1;0.1;0.01;0.001;0.0001];
fprima_3_nodos=[a(1,1)+a(1,2)*(x(1,1)-x(1,2));a(2,1)+a(2,2)*(x(2,1)-x(2,2));a(3,1)+a(3,2)*(x(3,1)-x(3,2));a(4,1)+a(4,2)*(x(4,1)-x(4,2));a(5,1)+a(5,2)*(x(5,1)-x(5,2))];

fprima_5_nodos=[a(1,1)+a(1,2)*(x(1,1)-x(1,2))+a(1,3)*(x(1,1)-x(1,2))*(x(1,1)-x(1,3))+a(1,4)*(x(1,1)-x(1,2))*(x(1,1)-x(1,3))*(x(1,1)-x(1,4));
                a(2,1)+a(2,2)*(x(2,1)-x(2,2))+a(2,3)*(x(2,1)-x(2,2))*(x(2,1)-x(2,3))+a(2,4)*(x(2,1)-x(2,2))*(x(2,1)-x(2,3))*(x(2,1)-x(2,4));
                a(3,1)+a(3,2)*(x(3,1)-x(3,2))+a(3,3)*(x(3,1)-x(3,2))*(x(3,1)-x(3,3))+a(3,4)*(x(3,1)-x(3,2))*(x(3,1)-x(3,3))*(x(3,1)-x(3,4));
                a(4,1)+a(4,2)*(x(4,1)-x(4,2))+a(4,3)*(x(4,1)-x(4,2))*(x(4,1)-x(4,3))+a(4,4)*(x(4,1)-x(4,2))*(x(4,1)-x(4,3))*(x(4,1)-x(4,4));
                a(5,1)+a(5,2)*(x(5,1)-x(5,2))+a(5,3)*(x(5,1)-x(5,2))*(x(5,1)-x(5,3))+a(5,4)*(x(5,1)-x(5,2))*(x(5,1)-x(5,3))*(x(5,1)-x(5,4))];
                
E3nodos = fprima_3_nodos + sin(0.8);

E5nodos = fprima_5_nodos + sin(0.8);
                
printf("   Incremento  Fp 3 nodos   Fp 5 nodos   Error 3       Error 5 ");
                
table = [Incremento fprima_3_nodos fprima_5_nodos E3nodos E5nodos]

xF = (t0-5):1/50:(t0+5);
f3 = a(5,1)+a(5,2)*(xF-x(5,2));
f5 = a(5,1)+a(5,2)*(xF-x(5,2))+a(5,3)*(xF-x(5,2)).*(xF-x(5,3))+a(5,4)*(xF-x(5,2)).*(xF-x(5,3)).*(xF-x(5,4));

#Instrucción para graficar la función.
plot(xF,f3,xF,f5,xF,-1*sin(xF)); title('Gráfica polinomio interpolador de newton.');


