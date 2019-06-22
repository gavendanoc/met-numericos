clc;
clear all;
ok = false;
while (~ok)
  try
    fun = input("Ingrese la funcion f(x)= ","s");
    f = inline(fun,'x');#crea la funcion
    ok = true;
  catch
    printf("Favor ingresar una funcion apropiada \n");
  end_try_catch
endwhile

ok = false;
while (~ok)
  try 
    v_i = input("Igrese valor del intervalor izquierdo: ");
    ok = true;
catch
    printf("Favor ingresar un numero valido\n");
  end_try_catch
endwhile

ok = false;
while (~ok)
  try 
    v_d = input("Igrese valor del intervalor derecho: ");
    ok = true;
catch
    printf("Favor ingresar un numero valido\n");
  end_try_catch
endwhile

disp(['Su intervalo es [',num2str(v_i),',',num2str(v_d),']']);

ok = false;
while (~ok)
  try 
		nodos = input("Cantidad de nodos a ingresar: ");
    if (mod(nodos,2)== 1 && nodos> 1)
			ok = true;
		else
			printf("Debe ingresar un numero impar mayor a uno\n");
    endif
catch
    printf("Favor ingresar un numero valido\n");
  end_try_catch
endwhile

#valor de h
h=(v_d-v_i)/(nodos-1);

disp(['La distancia entre cada punto de su intervalo es h=',num2str(h),' con lo cual tiene los siguientes puntos:']);

#Imprimiendo los X's
temp = 0;
printf("%8s","");
while temp < nodos
		printf("X%d%8s",temp,"");
		temp++;
endwhile

printf("\n");

#Imprimiendo el valor correspondiente a cada X's
temp = 0;
temp_val = v_i;
while temp < nodos	
		printf("%10d",temp_val);
		temp_val += h;
		temp++;
endwhile

printf("\n");

#Ejecucion de la aproximacion a la integral por el metodo de regla compuesta de simpson

#valor de m
m = (nodos-1)/2;

#Calculando la sumatoria de los numeros impares
temp = 1;
temp_val = v_i+h;
sum_imp = 0;
while temp < nodos-1
		if mod(temp,2)==1
			sum_imp += f(temp_val);
		endif
		temp_val += h;
		temp++;
endwhile

temp = 1;
temp_val = v_i+h;
sum_par = 0;

#Calculando la sumatoria de los numeros pares
while temp < nodos-1
		if mod(temp,2)==0
			sum_par += f(temp_val);
		endif
		temp_val += h;
		temp++;
endwhile

#Aplicando la formula de la regla compuesta de Simpson
rta = (h/3)*(f(v_i)+f(v_d))+(2/3)*h*sum_par+(4/3)*h*sum_imp;
disp(['La aproximacion a la integral de f(x)= ',fun,' usando la regla compuesta de Simpson es:']);
disp(['S(f,h)=',num2str(rta)]);