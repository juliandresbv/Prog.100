%   Leer datos guardados en double
arch_xi = fopen('XDatos.bin', 'r');
Xi = fread(arch_xi, 'double');

arch_yi = fopen('YDatos.bin', 'r');
Yi = fread(arch_yi, 'double');

X_media = mean(Xi);
Y_media = mean(Yi);

covarianza_XY = cov(Xi, Yi);
varianza_X = var(Xi);

a_1 = covarianza_XY/varianza_X;

figure;
plot(Xi, Yi, '.');