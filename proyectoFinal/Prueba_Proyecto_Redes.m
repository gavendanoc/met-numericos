% Programa que calcula el coeficiente de Fricción
% para la fórmula de HW.

clear;
clc;
re=300000;      % Número de Reynolds
<<<<<<< HEAD
e=0.002;        % Rugosidad Absoluta
d=0.5;          % Diámetro interno
=======
e=0.0024;        % Rugosidad Absoluta
d=0.1;          % Diámetro interno
>>>>>>> c640a632bf0ea11fdc579f46f0812f29b396595c

% variables de la ecuacion HW
L = 50;
g = 9.8;
hf = 100;


% proponemos valores de a y b
a=0.0;
b=10;

% Proponemos un valor de f inicial para que entre al ciclo
f=1;

cont = 1;

while abs(f)>0.00001
    % Calculamos el valor de C
    c=(a+b)./2;   
    % Evaluamos en C
    f = colebrook(e , d, re, c);
    if f>0
        b=c;
    else
        a=c;
    end
    Vf(cont) = c;
    cont = cont + 1;  
end



fprintf('Factor de Pérdida de carga =%8.9f \n', c)
fprintf('Velocidad del agua por el tubo =%8.9f \n', (2* hf*d*g/(c*L))^0.5 )

<<<<<<< HEAD
Vv = (2* hf*d*g./(Vf*L)).^0.5;

plot(Vf,Vv, 'o');
xlabel('F');
ylabel('Velocidad');
 title('Gráfica velocidad en función de f');





=======
Xf = [-2:0.02:2];
plot(Xf, colebrook(e , d, re, Xf) )
>>>>>>> c640a632bf0ea11fdc579f46f0812f29b396595c






