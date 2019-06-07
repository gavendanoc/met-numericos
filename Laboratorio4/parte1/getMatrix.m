function M = getMatrix ()
  ok = false;
  while (~ok)
    try
      M = input('Inqrese la matris : ');
      rows = size(M)(1);
      columns = size(M)(2);
      if (columns != 2) 
        printf("Error, se ingresaron vectores de tamaño %d, favor ingresar unicamente tuplas (x, y)\n" , columns);
      elseif (rows <= 1)
       printf("Error, no se puede hacer una regresion lineal con un punto.\n");
      else 
        ok = true;
      endif 
    catch
      printf("Por favor, inqrese una matris valida de la\nforma [[x1, y1] ; [x2, y2] ; ... ; [Xn Yn]]\n\n");
    end_try_catch
  endwhile
endfunction