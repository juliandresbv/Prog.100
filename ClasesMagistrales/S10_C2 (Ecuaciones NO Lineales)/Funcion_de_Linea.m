%   Un sistema de ecuaciones de una sola variable (digamos, x_1) se puede definir como una
%   funcion de linea ( f( ) ). El objetivo de definirlo de esta forma es encontrar
%   los valores de x_1 tal que, f(x_1) = 0. Es decir, se desea encontrar
%   las raices de f(x_1).

%   Definir f( ).
f = @(x) ( sin(x).*x.^2 + 3.*x.*log(x) - 3 );
x = 0.001:10^-6:2;                          %   Rango para x

%   Grafica
figure;
plot(x, f(x));
grid;
%   Encontrar una raíz mediante "fuerza bruta". 
[s_min, s_ind] = min( abs( f(x) ) );
x(s_ind);
