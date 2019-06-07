clc
clear all

#crear matriz

ok = false;
while (~ok)
  try
    n=input('Inqrese tamaño de la matriz ');#se crea la funcion
    ok = true;
  catch
    printf("Por favor, inqrese un numero válido.\n\n");
  end_try_catch
endwhile

for i=1:n
  for j=1:n
    disp(['Inqrese el elemento ', num2str(i),',',num2str(j),' de la matriz. ']);
    ok = false;
    while (~ok)
      try
        M(i,j) = input('');
        ok = true;
      catch
        printf("Por favor, inqrese un numero válido.");
      end_try_catch
    endwhile
    Co(i,j) = 1;
  endfor
endfor

#M = [1 4 -2 ; 3 -2 5; 2 3 1] ;
disp(M)


for k=1:n
  disp(['Inqrese el elemento ',num2str(k),' del vector solución.']);
  ok = false;
  while (~ok)
    try
      S(k) = input('');
      ok = true;
    catch
      printf("Por favor, ingrese un numero válido.");
    end_try_catch
  endwhile
endfor


disp(['///////']);
disp(S);

if (det(M) == 0)
  printf("Error: La matriz no es invertible\n");
  return;
endif


L=[];
for q=1:n
  L(q, q) = 1;
  for r=q+1:n
    L(r, q) = M(r, q) / M(q, q);
    #a(r, q) = 0;
    for c=q+1:n
      M(r, c) = M(r, c) - L(r, q) * M(q, c);
    endfor
  endfor
endfor

for e=1:n
  for f=1:n
    if e == f
      U(e,f) = M(e,f);
    else
      if e > f
        U(e,f) = 0;
      else
        U(e,f) = M(e,f);
      endif
    endif
  endfor
endfor

disp(['///  L   ///']);
disp(L);
disp(['///  U  ////']);
disp(U);

for r=1:n
  for c=1:r-1
    S(r) -= L(r,c)*S(c);
  endfor
endfor
disp(['/////  Y   ////']);
disp(S);

w=n;
z=w;

while w >=1
  while z <= n
    if  z == w
      S(w) /= M(w,z);
    else
      S(w) -= M(w,z)*S(z)/M(w,w);
    endif
    z++;
  endwhile
  w--;
  z = w;
endwhile

disp(['/////  X   ////']);
disp(S);