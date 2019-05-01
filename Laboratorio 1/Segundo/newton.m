clear;
warning('off','all');
pkg load symbolic
syms x;

ok = false;
while (~ok)
  try
    fun(x) = input("Ingrese la funcion f(x)= ");#se crea la funcion
    ok = true;
  catch
    printf("Favor ingresar una funcion apropiada\n");
  end_try_catch
endwhile

ok = false;
while (!ok)
  try
    valIn = input("Valor inicial de x, p0= ");
    ok = true;
  catch
    printf("Favor ingresar un numero real\n");
  end_try_catch
endwhile


try
  option = input("1. para finalizar por ancho de intervalo.\n   Otra tecla para finalizar por cantidad de iteraciones. ");
catch
  option = 2;
end_try_catch


it = 0;#evitar errores en caso de que no se seleccione esta opcion
anch = 0;#evitar errores en caso de que no se seleccione esta opcion
if option==1
  anch = input("Ancho maximo del intevervalo final ");
else
  it = input("Cantidad de iteraciones ");
endif  

printf("%20s %20s %20s %20s \n","k","Tiempo pk","Altura f(pk)","f'(pk)");

i=0;

dfun = diff(fun);
fpk = fun(valIn);

while (anch<abs(fpk) && option == 1) || (option != 1 && it>=i)#dependiendo de la opcion escoje si finaliza con intervalo o con numero de iteracione
  fpk = double(fun(valIn));
  fdpk = double(dfun(valIn));
  
  printf("%20d %20d %20d %20d \n",i,valIn,fpk,fdpk);
  
  valIn = valIn - fpk/fdpk;
  
  if fpk == 0
    break;
  endif
  
  i++;
endwhile