% Programa que calcula el coeficiente de Fricción
% para la fórmula de HW.

clear;
clc;


re = 300000;      % Número de Reynolds
e = 0.0024;        % Rugosidad Absoluta
d = 0.1;          % Diámetro interno

% variables de la ecuacion HW
L = 50;
g = 9.8;
hf = 600;


% proponemos valores de a y b
p0 = 9;
p1 = 10;

% Proponemos un valor de f inicial para que entre al ciclo
n = 10;


while n-- > 0
    % Calculamos el valor de C
    % Evaluamos en C
    pTemp = p1 - ( colebrook (e , d, re, p1) * (p1 - p0)) /  ( colebrook (e , d, re, p1) - colebrook (e , d, re, p0) )
    p0 = p1;
    p1 = pTemp;
    
    
    if p0 < 0
      p0 = 0;  
    endif
    if p1 < 0
      p1 = 0;
    endif
end

p1

fprintf('Factor de Pérdida de carga =%8.9f \n', p1)
fprintf('Velocidad del agua por el tubo =%8.9f \n', (2* hf*d*g/(p1*L))^0.5 )


