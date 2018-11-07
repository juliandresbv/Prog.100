format long g;

%   Carga de datos
arch_xi = fopen('./utils/Taller-01-P03-X-214.bin', 'r');
Xi = fread(arch_xi, 'double');

arch_yi = fopen('./utils/Taller-01-P03-Y-214.bin', 'r');
Yi = fread(arch_yi, 'double');

%   Calculo de covarianza y varianza para calcular a1
covarianza_XY = cov(Xi, Yi);
covarianza_XY = covarianza_XY(2, 1);
varianza_X = var(Xi);

a1 = covarianza_XY / varianza_X;

%   Calculo de promedios de X y de Y para calcular a0

X_media = mean(Xi);
Y_media = mean(Yi);

a0 = Y_media - (X_media * a1);

%   Calculo de Yi_hat, recta de regresion lineal.

Yi_hat = (a1 * Xi) + a0;

%   Grafica
figure
plot(Xi, Yi, '.');
hold on;
plot(Xi, Yi_hat, 'r');
xlabel('X');
ylabel('Y');
hold off;

%%   Literal a.
%   Se tiene la matriz [1 m12; 10.55166 m22]*[a0 a1] = [67.46714875 b2]
%   Hallar los valores de m12, m22, a0, a1, b2

%   En la fila 1, expandiendo el producto de matrices se tiene que: (a0).*(1) + (a1).*(m12) = 67.46714875
%   Se despeja m12. El valor 67.46714875 corresponde a la media de los
%   datos de Y. Entonces:

m12 = ( 67.46714875 - (a0) .* (1) ) / a1;  %   Este valor corresponde a la media de los datos de X

%   De lo anterior se concluye que b2 = Y_media = 67.46714875.
%   En la fila 2, expandiendo el producto de matrices se tiene que: (a0).*(10.55166) + (a1).*(m12) = 67.46714875
%   Se despeja m22. El valor 67.46714875 corresponde a la media de los
%   datos de Y. Entonces:

b2 = 67.46714875;
m22 = ( 67.46714875 - (a0) .* (10.55166) ) / a1;

m = [1 m12;10.55166 m22];
ai = [a0;a1];
b = [67.46714875;b2];

fprintf('Matriz\n\n');
disp([m ai b]);

fprintf('m12: %.18f \n', m12);
fprintf('m22: %.18f \n', m22);
fprintf('b2: %.18f \n', b2);

%%   Literal b.
fprintf('\n');
fprintf('a1: %.18f \n', a1);
fprintf('a0: %.18f \n', a0);
