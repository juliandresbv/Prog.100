format long g;

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

%   Grafica.

figure;
plot(Xi, Yi, '.');
hold on;
plot(Xi, Yi_hat, 'r');

%   Valores de a_0, a_1, Yi_hat determinados por MATLAB.
p = polyfit(Xi, Yi, 1);
Yi_hat_MATLAB = polyval(p, Xi);

%   Calcular coeficiente de determinacion.
Yi_minus_Yi_hat = zeros(length(Yi), 1);

for i = 1:length(Yi)
    Yi_minus_Yi_hat(i) = ( Yi(i) - Yi_hat(i) ).^2;
end

Yi_minus_Y_media = zeros(length(Yi), 1);

for j = 1:length(Yi)
    Yi_minus_Y_media(j) = ( Yi(j) - Y_media ).^2;
end

sum_Yi_minus_Yi_hat = sum( Yi_minus_Yi_hat );
sum_Yi_minus_Y_media = sum( Yi_minus_Y_media );

%   Coeficiente de determinacion. Valor entre el intervao (0,1).
%   Si es cercano a cero (0), la regresion lineal no es buena.
%   Si es cercano a cero (0), la regresion lineal es buena.
r_sq = 1 - ( sum_Yi_minus_Yi_hat/sum_Yi_minus_Y_media );