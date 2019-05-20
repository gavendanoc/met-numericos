clc #Limpia todo el texto de la ventana de comando
clear all #Limpia todas las variables antes de entrar al programa.

#Se le pide al usuario que ingrese el grado del polinomio intepolador que generará el programa
# de acuerdo al número de nodos que éste entrará.
ok = false;
while (~ok)
  try
    n=input('Ingrese el grado n del polinomio que generará éste programa ');#La variable 'n' representa el grado del polinomio.
    ok = true;
  catch
    printf("Por favor, ingrese un numero válido.\n\n");#Esta función try-catch es para que el usuario solo pueda ingresar números, ya que n es una variable numérica. Esta función se ve frecuentemente en este código.
  end_try_catch
endwhile



disp(['Usted ingresó el número ',num2str(n),' por lo que deberá ingresar ',num2str(n+1),' nodos.'])#Esto le indica al usuario que debe ingresar n+1 nodos.

ok2 = false; #Esta variable sirve para que el usuario solo ingrese los n+1 elementos x necesarios para los n+1 nodos, ya que si ingresa otro numero no correspondería al número de nodos que éste quiso ingresar.
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
   if length(x) ~= n+1#Se confirma que se ingresaron n+1 números por lo explicado arriba.
     disp(['Debes ingresar ',num2str(n+1),' elementos. Por favor vuelvelo a intentar.']);
   else
      for u=1:n #Estos ciclos se usan para confirmar que no se ingrese el mismo número más de una vez en el arreglo de x, ya que se supone que los nodos corresponden a una función.
        for t=u+1:n+1
          if x(u) == x(t)
            disp(['No puedes ingresar el mismo valor más de una vez. Intentalo de nuevo']);
            break;
          endif  
        endfor 
        if t ~= n+1 || x(u) == x(t)
           break;
        endif  
      endfor
      if u == n && x(u) ~= x(t)
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
   if length(y) ~= n+1
     disp(['Debes ingresar ',num2str(n+1),' elementos. Por favor vuelvelo a intentar.']);
   else
      ok2 = true;
   endif   
endwhile   

#Ciclo para mostrar los nodos ingresados por el usuario.
for j=0:n
  disp(['Nodo #',num2str(j+1),': ',num2str(x(j+1)),',',num2str(y(j+1))]);
endfor

#Estos strings son para que se muestre como es la función de interpolación de Lagrange.
str2 = '';
strLNK = '';
strStart = 'La función de interpolación de Lagrange es: P(x)=';

#Ciclos para crear el string que muestra como es la función.
for w=0:n
   for v=0:n
      if w ~= v
         S = {strLNK,'(x-',num2str(x(v+1)),')/(',num2str(x(w+1)),'-',num2str(x(v+1)),')'};
         strLNK = strjoin(S);
      endif   
   endfor
   if w < n
      S = {str2,num2str(y(w+1)),'*',strLNK,'+'};
      str2 = strjoin(S);
      strLNK = '';
   else
      S = {str2,num2str(y(w+1)),'*',strLNK};
      str2 = strjoin(S); #Se van uniendo los términos que se mostrarán en la ventana de comandos.
      strLNK = '';
   endif   
endfor

S = {strStart,str2};
str2 = strjoin(S);
disp([str2]); #Se muestra la función de interpolación como un string.

#Ciclos para crear la función que se graficará
xF=min(x):(max(x)-min(x))/20:max(x);
f=0;
for a=0:n
  fLNK = 1;
  for b=0:n
    if a~=b
      fLNK = fLNK .* (xF - x(b+1))/(x(a+1)-x(b+1));  
    endif  
  endfor
  f = f + y(a+1) * fLNK;
endfor  

#Intrucción para graficar la función de interpolación lineal (f).
plot(xF,f); title('Gráfica polinomio de interpolación lineal.');

#Aquí se le pide al usuario que ingrese el número que desea aproximar
disp(['Qué valor desea aproximar? ']);
ok = false;
while (~ok)
     try
         ValorDeInterpolacion = input('');
         ok = true;
      catch
         printf("Por favor, ingrese un numero válido.\n\n");
      end_try_catch   
endwhile
   

Resultadofuncion = 0;
ResultadoLNK = 0;

#El ciclo(for) exterior sirve para hacer la sumatoria del polinomio interpolador.
for k=0:n
   Numerador = 1;
   Denominador = 1;
   #Este ciclo(for) interior sirve para hacer todas las multiplicaciones que va a tener cada término del polinomio interpolador.
   for l=0:n
      if l ~= k   
         Numerador = Numerador * (ValorDeInterpolacion - x(l+1));
         Denominador = Denominador * (x(k+1) - x(l+1));
      endif 
   endfor
   ResultadoLNK = Numerador/Denominador;#La variable ResultadoLNK representa el LNK que multiplica al valor de la función en cada uno de los nodos ingresados.   
   Resultadofuncion += y(k+1)* ResultadoLNK; 
endfor

#Instrucción que muestra la función aproximada al punto que ingresó el usuario.
disp(['La función en el punto ', num2str(ValorDeInterpolacion),' es aproximadamente ',num2str(Resultadofuncion)]);