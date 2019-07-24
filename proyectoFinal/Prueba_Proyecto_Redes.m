% Programa que calcula el coeficiente de Fricci�n
% para la f�rmula de HW.
clear;
clc;
% re=input('N�mero de Reynolds (Adim.): ')
% e=input('Rugosidad Absoluta (m): ')
% d=input(' Di�metro (m): ');
re=300000; % N�mero de Reynolds
e=0.0002;    % Rugosidad Absoluta
d=0.7;          % Di�metro interno
% proponemos valores de a y b
a=0.0;
b=10;
% Proponemos un valor de f inicial para que entre al ciclo
f=1;
while abs(f)>0.00001
    % Calculamos el valor de C
    c=(a+b)./2;
    % Evaluamos en C
    fa=1/sqrt(c);
    fb=-2*(log((e/d)/3.71+2.51/(re*sqrt(c))))*0.434294481903252000;
    f=fb-fa;
    if f>0
        b=c;
    else
        a=c;
    end
end
fprintf('Factor de P�rdida de carga =%8.9f \n', c)