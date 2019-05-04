clear;
% read the input into a string variable
printf("Muy buenos dias.Me presento, soy un asistente para \nresolver esas horrendas ecuaciones lineales de hasta\n5, 7 o 10 variables que nadie las acaba en la vida.\nUsando el metodo de Jaccobi :)\n\n\n");


ok = false;
while (~ok)
  try
    n = input("Cuantas variables son? n: ");#se crea la funcion
    ok = true;
  catch
    printf("Por favor señor, necesito que ingrese un numero real. Intentemoslo de nuevo, confio en ti <3\n\n");
  end_try_catch
endwhile

printf("\n\nBuen trabajo! sigamos con el ingreso de las componentes de la matriz\n\n");

M=[];
for i=1: n
  ok = false;
  while (~ok)
    try
      v = input(strcat("Fila  ", num2str(i), " : "),"s");
      % split the string delimited by space and convert each string to number 
      s = cellfun("str2num",strsplit(v," "));
      
      if (length(s) != n)
        printf("Señor recuerde que son %d variables, vuelvelo a intentar\n", n);
      else
        ok = true;  
      endif
    catch
      printf("Oops,  señor hubo un error al ingresar esa fila, vuelvelo a intentar\n");
    end_try_catch
  endwhile
  M = [M;s]
endfor

if (!has_ded(M, n))
  printf("Error: No se puede porque la matriz no tiene una diagonal estrictamente dominante\n");
  return;
endif

if (det(M) == 0)
  printf("Error: La matriz no es invertible\n");
  return;
endif


printf("\n\nExcelente trabajo! Eres un maquina en esto. \nSigamos con el ingreso de las igualdades\n\n");

b=[];
for i=1:n
  ok = false;
  while (~ok)
    try
      res = input(strcat("Fila  ", num2str(i), " = "));
      b(i) = res;
      ok = true;
    catch
      printf("Por favor señor, necesito que ingrese un numero real. Intentemoslo de nuevo, confio en ti <3\n\n");
    end_try_catch
  endwhile
endfor


printf("\n\nPerfecto! Ya casi terminamos, \ningresa un punto inicial por donde pueda empezar la busqueda\n\n");

p=[];
for i=1:n
  ok = false;
  while (~ok)
    try
      res = input(strcat("X", num2str(i), " = "));
      p(i) = res;
      ok = true;
    catch
      printf("Por favor señor, necesito que ingrese un numero real. Intentemoslo de nuevo, confio en ti <3\n\n");
    end_try_catch
  endwhile
endfor


printf("\n\nEso! Solo falta esto, \n Las iteraciones... \n\n");

ok = false;
while (~ok)
  try
    repeticiones = input("Cuantas Iteraciones hago? ");#se crea la funcion
    ok = true;
  catch
    printf("Por favor señor, necesito que ingrese un numero real. Intentemoslo de nuevo, confio en ti <3\n\n");
  end_try_catch
endwhile


%v=input("your vector please? ","s");
% split the string delimited by space and convert each string to number 
%m=cellfun("str2num",strsplit(v," "));
%m
% M = [M;[9 8 7]]

% M = [[4 -1 1] ; [4 -8 1] ; [-2 1 5] ];
% p = [ 1 1 1 ];

% a = a(a~=1.3)



printf("k", j);
for j=1:n
  printf("\t\tX%d", j);
  
endfor

printf("\n");

for i=1:repeticiones 
  printf("%d", i - 1);
  
  for j=1:n
    printf("\t\t%.4f", p(j));
  endfor
    
  printf("\n");
  p = nextPoint(M, b, p, n);
endfor


printf("\n\nFue un placer haberle servido señor. \nEspero este satisfecho con mis servicios\n");
  

