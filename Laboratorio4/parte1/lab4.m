clc #Limpia todo el texto de la ventana de comando
clear all #Limpia todas las variables antes de entrar al programa.

#Se le pide al usuario que ingrese el grado M del polinomio que generará el programa
ok = false;
while (~ok)
  try
    m=input('Ingrese el grado M del polinomio que generará éste programa ');#La variable 'm' representa el grado del polinomio.
    ok = true;
  catch
    printf("Por favor, ingrese un numero válido.\n\n");#Esta función try-catch es para que el usuario solo pueda ingresar números, ya que n es una variable numérica. Esta función se ve frecuentemente en este código.
  end_try_catch
endwhile


disp(['Usted ingreso ',num2str(m),', por lo que el programa tomará en cuenta ',num2str(m+1),' funciones linealmente independientes.']);

ok = false;
while (~ok)
  try
    n=input('Ingrese el número n de nodos que desea ingresar.');#La variable 'n' representa el grado del polinomio.
    ok = true;
  catch
    printf("Por favor, ingrese un numero válido.\n\n");#Esta función try-catch es para que el usuario solo pueda ingresar números, ya que n es una variable numérica. Esta función se ve frecuentemente en este código.
  end_try_catch
endwhile

ok2 = false; #Esta variable sirve para que el usuario solo ingrese los n elementos x necesarios para los n nodos, ya que si ingresa otro numero no correspondería al número de nodos que éste quiso ingresar.
while ~ok2
   x = [];
   indice = '';
   xIN = input('Por favor ingrese los elementos x de todos los nodos. ','s');
   expression = '[-0123456789.]+';
   indice= regexp(xIN,expression);
   for i=1:length(indice)#Este for asigna los números presentes en el string ingresados por el usuario para luego pasarlos a un arreglo numérico.
     if i < length(indice)
        x(i) = str2num(xIN(indice(i):indice(i+1)-2));
     else
        x(i) = str2num(xIN(indice(i):length(xIN)));
     endif   
   endfor
   if length(x) ~= n#Se confirma que se ingresaron n+1 números por lo explicado arriba.
     disp(['Debes ingresar ',num2str(n),' elementos. Por favor vuelvelo a intentar.']);
   else
      for u=1:n-1 #Estos ciclos se usan para confirmar que no se ingrese el mismo número más de una vez en el arreglo de x, ya que se supone que los nodos corresponden a una función.
        for t=u+1:n
          if x(u) == x(t)
            disp(['No puedes ingresar el mismo valor más de una vez. Intentalo de nuevo']);
            break;
          endif  
        endfor 
        if t ~= n || x(u) == x(t)
           break;
        endif  
      endfor
      if u == n - 1 && x(u) ~= x(t)
        ok2 = true;
      endif        
   endif   
endwhile

#Aquí abajo se hace básicamente lo mismo para ingresar las coordenadas y de los nodos.
ok2 = false;
while ~ok2
   y = []; 
   indice2 = '';  
   yIN = input('Por favor ingrese los elementos y de todos los nodos. ','s');
   indice2= regexp(yIN,expression);
   for i=1:length(indice2)
        if i < length(indice2)
           y(i) = str2num(yIN(indice2(i):indice2(i+1)-2));
        else
           y(i) = str2num(yIN(indice2(i):length(yIN)));
        endif   
   endfor
   if length(y) ~= n
     disp(['Debes ingresar ',num2str(n),' elementos. Por favor vuelvelo a intentar.']);
   else
      ok2 = true;
   endif   
endwhile 

disp(['La matriz F es: ']);

#Este ciclo sirve para asignar los valores a la matriz F y F transpuesta, y esos valores se hallan con las
#funciones linealmente independientes y los nodos x que ingresó el usuario.
for n1=1:n
  for m1=1:m+1
    f(n1,m1) = x(n1)^(m1-1); #El exponente al que se eleva el componente x de los nodos es j-1 para cada función j
                             #que tiene en cuenta el programa de acuerdo al grado que ingresó el usuario. 
    fp(m1,n1) = x(n1)^(m1-1);
  endfor
endfor

disp(f);

disp(['La matriz F´ es: ']);

disp(fp);

fm = fp*f; #fm es F multiplicado por su transpuesta

y1 = y.';

disp(['La matriz y que se multiplica con F´ es: ']);

disp(y1); 

fy = fp*y1;#fy es f transpuesta multiplicado por el vector de los componentes y de los nodos.

#Aquí se usa el método de factorización triangular para el resolver sistemas de ecuaciones lineales,
#ya que al realizar las multiplicaciones a un lado queda una matriz cuadrada y al otro una vector de números.
for g=1:m
  for o=g+1:m+1
    for p=g:m+1
      if p == g
        fm(o,p) = fm(o,p)/fm(p,p);
      else
        fm(o,p) = fm(o,p) - fm(o,g)*fm(g,p);
      endif
    endfor
  endfor
endfor

for e=1:m+1
  for f=1:m+1
    if e == f
      L(e,f) = 1;
      U(e,f) = fm(e,f);
    else
      if e > f
        L(e,f) = fm(e,f);
        U(e,f) = 0;
      else
        U(e,f) = fm(e,f);
        L(e,f) = 0;
      endif
    endif
  endfor
endfor

for r=1:m+1
  for c=1:r-1
    fy(r,1) -= fm(r,c)*fy(c);
  endfor
endfor
w=n;
z=w;

while w >=1
  while z <= m+1
    if  z == w
      fy(w,1) /= fm(w,z);
    else
      fy(w,1) -= fm(w,z)*fy(z,1)/fm(w,w);
    endif
    z++;
  endwhile
  w--;
  z = w;
endwhile

disp(['/////  El vector solución es   ////']);
disp(fy);

disp(['Por ende el polinomio que se aproxima a los nodos es: '])

pol = '';

#Ciclo para crear la funcion en forma de string
for u = 1:m+1
  if u ~= m+1 # Esta condición se usa para que no que un signo de + al final.
    str1 = {pol,num2str(fy(u,1)),'*x^',num2str(u-1),'+'};
    pol = strjoin(str1);
   else
    str1 = {pol,num2str(fy(u,1)),'*x^',num2str(u-1)};
    pol = strjoin(str1);
   endif
endfor

disp([pol]);

#Ciclos para crear la función que se graficará
xF=min(x):(max(x)-min(x))/50:max(x);
f=0;
for a=1:m+1
  f = f + fy(a,1)*xF.^(a-1);
endfor  

#Intrucción para graficar la función de aproximación (f).
plot(xF,f); title('Gráfica polinomio de aproximación.');