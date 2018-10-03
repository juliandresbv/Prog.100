format long g;

arch_r2 = fopen('./utils/Parcial-02-P04-XY-214.bin', 'r');
buffer_arch2 = fread(arch_r2, 'single');

num_datos_X = length(buffer_arch2)/2;
num_datos_Y = length(buffer_arch2) - ( length(buffer_arch2)/2 );

x = zeros(1, num_datos_X);
y = zeros(1, num_datos_Y);

for  i = 1:num_datos_X
    x(i) = buffer_arch2(i);
end

for  j = (num_datos_Y + 1):length(buffer_arch2)
    y(j - 10001) = buffer_arch2(j);
end

figure;
plot(x, y);
