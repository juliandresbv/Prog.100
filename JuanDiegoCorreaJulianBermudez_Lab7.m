%%  Nombres
%   Juan Diego Correa Arredondo 201613818
%   Julian Andres Bermudez Valderrama 201519648
%%  Punto 1
%   Cantidad de puntos (x, y)
n_puntos = 7;

%   Valores de x en el rango [0, 100], posteriormente ordenados
x = (0:5:30);
x = sort(x);

%   Valores de y en el rango [0, 10]
y = [100 89.556 78.4905 67.2706 56.3897 46.2842 37.2687];

%   Rango pseudo-continuo de x en el rango de [0, 100]
x_res = x(1):0.01:x(end);

%   Ajuste polinomial de los puntos con un polinomio de grado n_puntos - 1
p = polyfit(x, y, n_puntos  - 1);

%   Valores de y tales que corresponden al ajuste polinomial para los
%   valores de x en x_res
y_res = polyval(p, x_res);
YSplines = interp1(x, y, x_res, 'spline');



%   Funcion real
p = @(t) (300./( 2 + exp(t.*0.06) ));

%   Grafica
figure;

subplot(4 ,1, 1);
plot(x, y, 'o');

subplot(4, 1, 2);
plot(x_res, y_res, 'r');

subplot(4, 1, 3);
plot(x_res, YSplines, 'g');

subplot(4, 1, 4);
plot(x, p(x), 'b');

tasaR=p(9)-p(8.99);
tasaP=y_res(1000)-y_res(999);
tasaS=YSplines(1000)-YSplines(999);

disp('Tasa de cambio real es de:');
disp(tasaR);
disp('Tasa de cambio polinomial es de:');
disp(tasaP);
disp('Tasa de cambio splines cubico es de:');
disp(tasaS);

%%  Punto 2
%   Cantidad de puntos (x, y)
n_puntos = 7;

%   Valores de x en el rango [0, 100], posteriormente ordenados
x = (1940:10:2000);
x = sort(x);

%   Valores de y en el rango [0, 10]
y = [132.165 151.326 179.323 203.302 226.542 248.71 281.422];

%   Rango pseudo-continuo de x en el rango de [0, 100]
x_res = x(1):0.01:x(end);

%   Ajuste polinomial de los puntos con un polinomio de grado n_puntos - 1
p = polyfit(x, y, n_puntos  - 1);

%   Valores de y tales que corresponden al ajuste polinomial para los
%   valores de x en x_res
y_res = polyval(p, x_res);
YSplines = interp1(x, y, x_res, 'spline');

%   Poblacion en 1995 para interpolacion
p1995 = y_res(5600);
disp('Población por polinomial:');
disp(p1995);
tasa=p1995-y_res(5599);
disp('Tasa de cambio polinomial es de:');
disp(tasa);
%   Poblacion en 1995 para splines
p1995splines = YSplines(5600);
disp('Población por Splines cubico:');
disp(p1995splines);
tasaslines=p1995splines-YSplines(5599);
disp('Tasa de cambio splines cubico es de:');
disp(tasa);

%   Grafica
figure;

subplot(3, 1, 1);
plot(x, y, 'o');

subplot(3, 1, 2);
plot(x_res, y_res, 'r');

subplot(3, 1, 3);
plot(x_res, YSplines, 'g');

%%  Punto 3
x = [0 pi/8 pi/2];
x_res = x(1):0.01:x(end);
y = [sin(x(1)) sin(x(2)) sin(x(3))];

ySplines = interp1(x, y, x_res, 'spline');
subplot(2, 1, 1);
plot(x_res, sin(x_res), 'r');

subplot(2, 1, 2);
plot(x_res, ySplines, 'g');