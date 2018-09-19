%%   Creacion de archivo binario

buffer_w = round(rand(1, 1000)*100);        %   Se CREAN 1000 datos de tipo double entre 0 - 100
arch_w = fopen('arch.bin', 'w');        %   Se crea un MANEJADOR de archivo (arch_w).
                                            %   creando un archivo con nombre "thosand.bin"
fwrite(arch_w, int8(buffer_w), 'int8');     %   Se crea el archivo guardando cada valor de buffer
                                            %   en format int8, cada valor ocupa 8 BITS (1 BYTE).
fclose(arch_w);                             %   Se CIERRA el manejador

%%   Lectura de archivos

arch_r = fopen('thousand.bin', 'r');
buffer_r = fread(arch_r, 'int8');
fclose(arch_r);

%%   Grafica de buffer_w - buffer_r
%   buffer_w(:) - buffer_r(:)

figure;
plot(buffer_w(:) - buffer_r(:));