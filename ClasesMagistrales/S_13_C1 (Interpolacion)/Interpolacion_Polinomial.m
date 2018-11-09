%   Cantidad de puntos (x, y)
n_puntos = 20;

%   Valores de x en el rango [0, 100], posteriormente ordenados
x = rand(1, n_puntos) * 90 + 10;
x = sort(x);

%   Valores de y en el rango [0, 10]
y = rand(1, n_puntos) * 10 + rand(1, n_puntos);

%   Rango pseudo-continuo de x en el rango de [0, 100]
x_res = x(1):0.01:x(end);

%   Ajuste polinomial de los puntos con un polinomio de grado n_puntos - 1
p = polyfit(x, y, n_puntos  - 1);

%   Valores de y tales que corresponden al ajuste polinomial para los
%   valores de x en x_res
y_res = polyval(p, x_res);

%   Grafica
figure;
plot(x, y, 'o');
hold on;
plot(x_res, y_res, 'r');
hold off;

A = zeros(n_puntos, n_puntos);

for i = 1:n_puntos
    for j = 1:n_puntos
        A(i,(n_puntos - j) + 1) = x(i).^(n_puntos - j);
    end
end