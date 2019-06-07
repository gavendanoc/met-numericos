clc
clear all

X_pos = 1;
Y_pos = 2;

printf("Recta de regresion y = Ax + B usando minimos cuadrados.\n\n");
printf("Favor insertar valores de la forma : [[x1 y1] ; [x2 y2] ; ... ; [Xn Yn]]\n\n");


M = [[-1 10] ; [0 9] ; [1 7] ; [2 5] ; [3 4] ; [4 3] ; [5 0] ; [6, -1]];
X = M( : , X_pos);
Y = M( : , Y_pos);
number_points = size(M)(1); 

#{
# lectura de puntos
ok = false;
while (~ok)
  M = getMatrix();
  X = M( : , X_pos);
  Y = M( : , Y_pos);
  number_points = size(M)(1); 

  # imprimir la puntos
  printf("Estos son los puntos que ingreso : \n\n");
  printf("\tX\tY\n");
  for i = 1 : number_points
    printf("\t%.2f\t%.2f\n", X(i), Y(i));
  endfor 
  printf("\n");
  
  # confirmacion de datos
  ok = yes_or_no("Estos datos son correctos? ");
  if (ok == false)
     printf("Por favor insertar de nuevo los valores de la forma : [[x1 y1] ; [x2 y2] ; ... ; [Xn Yn]] \n\n"); 
  endif
endwhile
#}

sum_X = sum(X);
sum_Y = sum(Y);

X_pow_2 = X .^ 2;
X_times_Y = X .* Y; 
sum_X_pow_2 = sum(X_pow_2);
sum_X_times_Y = sum(X_times_Y);

# sistema de ecuaciones
solution_vector = [ sum_X_times_Y ; sum_Y];
values_matrix = [[sum_X_pow_2 sum_X] ; [sum_X number_points]];

if (det(values_matrix) == 0)
  printf("Errorr");
endif

parameters = values_matrix^(-1) * solution_vector;
A = parameters(1);
B = parameters(2);

# imprimir tabla
printf("k\tX\tY\tX^2\tX*Y\n");
for i = 1 : number_points
  printf("%d\t%.2f\t%.2f\t%.2f\t%.2f\n",i,  X(i), Y(i), X_pow_2(i), X_times_Y(i));
endfor
printf("________________________________________\n");
printf("Total:\t%.2f\t%.2f\t%.2f\t%.2f\n", sum_X, sum_Y, sum_X_pow_2, sum_X_times_Y);

# imprimir ecuaciones lineales 
printf("\n\n\nSistema de ecuaciones:\n");
printf("%.2f A + %.2f B = %.2f\n", values_matrix(1, 1), values_matrix(1, 2), solution_vector(1));
printf("%.2f A + %.2f B = %.2f\n", values_matrix(2, 1), values_matrix(2, 2), solution_vector(2));

% imprimir solucion
printf("\nSolucion:\n");
printf("A = %f\n", A);
printf("B = %f\n", B);

printf("\nEcuacion de la recta : Y = %f X + %f\n", A, B);




