clear;
ok = false;
while (~ok)
  try
    fun = input("Ingrese la funcion f(x)= ","s");
    f = inline(fun,'x');#crea la funcion
    ok = true;
  catch
    printf("Favor ingresar una funcion apropiada\n");
  end_try_catch
endwhile

ok = false;
while (~ok)
  try 
    valEq = input("Valor de f(x) para el que desea hallar la aproximacion de x, f(x)=");
    ok = true;
catch
    printf("Favor ingresar un numero real\n");
  end_try_catch
endwhile


ok = false;
while (~ok)
  try
    l = input("Interevalo izquierdo: ");
    ok = true;
catch
    printf("Favor ingresar un numero real\n");
  end_try_catch
endwhile


ok = false;
while (~ok)
  try
    r = input("Interevalo derecho: ");
    ok = true;
catch
    printf("Favor ingresar un numero real\n");
  end_try_catch
endwhile


ok = false;
while (~ok)
  try
    option = input("1. para finalizar por ancho de intervalo.\n   Otra tecla para finalizar por cantidad de iteraciones. ");
    ok = true;
  catch
    option = 2;
  end_try_catch
endwhile

    
it = 0;
anch = 0;
if option==1
  anch = input("Ancho maximo del intevervalo final ");
else
  it = input("Cantidad de iteraciones ");
endif  

printf("%20s %20s %20s %20s %20s %20s %20s \n","k","Extremo iz(l)","Punto medio(m)","Extremo der(r)","f(l)","f(m)","f(r)");

i=0;

while (anch<abs(r-l) && option == 1) || (option != 1 && it>=i)#dependiendo de la opcion escoje si finaliza con intervalo o con numero de iteracione
  m = (r+l)/2;
  fr = f(r)-valEq;
  fl = f(l)-valEq;
  fm = f(m)-valEq;
  
  printf("%20d %20d %20d %20d %20d %20d %20d \n",i,l,m,r,fl,fm,fr);
  
  if fm == 0
    break;
  endif
  
  if fl .* fm>0 #identificar si tienen el mismo signo
    l = m;
  else
    r = m;
  endif
  
  i++;
endwhile