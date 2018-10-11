%   =====================================
%   Leer .bin
%   =====================================
arch_to_read = fopen('./utils/Parcial-02-P01-314.bin', 'r');
data = fread(arch_to_read, 'double');

%   =====================================
%   Crear y llenar matriz
%   =====================================
n = length(data);
cols = n/15;

matriz = zeros(15, cols);

j = 1;

for i = 1:n
    if (mod(i,15) == 0)
        matriz(15, j) = data(i);
        j = j+1;
    else
        matriz(mod(i,15), j) = data(i);
    end
end

%   =====================================
%   Calcular el número de columnas que matriz(i, j) >= 0.75) && ( matriz(i, j) <= 1.10)
%   =====================================

num_cols_res = 0;

for j = 1:30
    counter = 0;
    
    for i = 1:15
        if ( (matriz(i, j) >= 0.75) && ( matriz(i, j) <= 1.10) )
            counter = counter + 1;
        end
    end
    
    if (counter == 4)
        num_cols_res = num_cols_res + 1;
    end
end

%   =====================================
%   Calcular la columna en donde abs( e_hat - matriz(i, j) ) es minima
%   =====================================

e_hat = Taylor_Series_ex(-0.86, 5);
e = exp(-0.86);

err_abs = abs(e_hat - e);
err_rel = (err_abs)/(abs(e));

min_value = inf;
col = -1;

for j = 1:30
    for i = 1:15
        if ( abs( e_hat - matriz(i, j) ) < min_value )
            min_value = ( abs( e_hat - matriz(i, j) ) );
            col = j;
            disp( matriz(i, j) );
            disp( e_hat );
            disp( min_value );
            disp( col );
        end
    end
end