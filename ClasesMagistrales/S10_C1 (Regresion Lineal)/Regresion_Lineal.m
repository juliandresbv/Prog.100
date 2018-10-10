%   Leer datos guardados en double
arch_xi = fopen('XDatos.bin', 'r');
Xi = fread(arch_xi, 'double');

arch_yi = fopen('YDatos.bin', 'r');
Yi = fread(arch_yi, 'double');

%   Calcular Covarianza y Varianza de los datos para posteriormente
%   calcular el valor de a_1

covarianza_XY = cov(Xi, Yi);
covarianza_XY = covarianza_XY(2, 1);
varianza_X = var(Xi);

a_1 = covarianza_XY/varianza_X;

%   Calcular la media para calcular el valor de a_0 con X_media, Y_media y
%   a_1

X_media = mean(Xi);
Y_media = mean(Yi);

a_0 = Y_media - (a_1  * X_media);

%   Calucular los puntos aproximados Yi_hat, los cuales corresponden a los
%   valores de Y en la regresion lineal.

Yi_hat = (a_1 * Xi) + a_0;

figure;
plot(Xi, Yi, '.');
hold on;
plot(Xi, Yi_hat, 'r');