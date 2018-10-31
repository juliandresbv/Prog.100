%   Combinaciones de valores para x1 y x2 aleatorias definidas en los
%   rangos
[x1, x2] = meshgrid(-5:0.01:5, -5:0.01:5);

%   Funciones (f1 y f1)
f1 = x1.^2 - x2.^2 + 3;
f2 = (x1 + 2).^2 - x2;

%   Lineas de contorno o lineas de isovalor, combinaciones de x1 y x2 para
%   que f1 = 0 y f2 = 0
[c1, h1] = contour(x1, x2, f1, [0 0], 'b');
clabel(c1, h1);

hold on;

[c2, h2] = contour(x1, x2, f2, [0 0], 'r');
clabel(c2, h2);

xlabel('x1');
ylabel('x2');
grid