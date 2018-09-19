%%   Creacion de archivo

buffer_w = round(rand(1, 1000)*100);
arch_w = fopen('thousand.bin', 'w');
fwrite(arch_w, int8(buffer_w), 'int16');
fclose(arch_w);

%%   Lectura de archivos

arch_r = fopen('thousand.bin', 'r');
buffer_r = fread(arch_r, 'int8');
fclose(arch_r);

%%   Grafica de buffer_w - buffer_r
%   buffer_w(:) - buffer_r(:)

figure;
plot(buffer_w(:) - buffer_r(:));