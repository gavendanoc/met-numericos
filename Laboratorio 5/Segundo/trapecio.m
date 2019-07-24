clear;
clc;

# ingresar intervalo
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
    else 
      ok = true;
    endif 
  catch
    printf("Por favor, inqrese un intervalor valido de la forma [a b]\n\n");
  end_try_catch
endwhile  


# ingresar Ma
ok=false;
while (~ok)
  try
    M = input("Ingrese el numero de subintervalos M: ");
    if (floor(M) != M)
      printf("Favor ingresar un numero entero\n");
    else
      ok = true;
    endif
  catch
    printf("Favor ingresar un numero entero\n");
  end_try_catch
endwhile

  
# probar que la funcion funciona con lista

a = interval(1);
b = interval(2);
h = (b - a) / M;

# ingresar la funcion 
ok = false;
while (~ok)
  try
    fun = input("Ingrese la funcion f(x)= ","s");
    f = inline(fun,'x');#crea la funcion
    
    # verificar si la funcion tiene un valor real en el intervalo
    try 
      subintervals = [ a :  h : b](2 : end-1);
      summation = sum(f(subintervals))
      result = h / 2 * (f(a) + f(b)) + h * summation;
      
      if (result == Inf)
        printf("Error, La funcion que ingresaste no tiene un valor real en el intervalo\n");
      elseif
        ok = true;
      endif
    catch
      msg = lasterror.message;
      if (strfind (msg, "undefined"))
        printf("Error, favor ingresar una funcion de una variable x\n");
      elseif (strfind (msg, "nonconformant"))
        printf("Error, Verifica que la funcion tenga los operadores .* ./ o .^\n");
      endif
     end_try_catch
  catch
    printf("Favor ingresar una funcion apropiada\n");
  end_try_catch
endwhile

printf("\n\n");
printf("Resultado  = h / 2 * (f(a) + f(b)) + h * sumatoria\n");
printf("%.6f  = %.2f / 2 * (f(%.1f) + f(%.1f)) + %.2f * %.4f\n", result, h, a, b, h, summation);

clear;






