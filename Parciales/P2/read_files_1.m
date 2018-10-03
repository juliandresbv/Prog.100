arch_r = fopen('./utils/Parcial-02-P02-214.bin', 'r');
buffer_arch = fread(arch_r, 'int16');

num_datos = length(buffer_arch);
mult_siete = 0;
ge_menostre_le_diezyseis = 0;

for i = 1:num_datos
    if (mod( buffer_arch(i), 7 ) == 0)
        mult_siete = mult_siete + 1;
    end
end

for i = 1:num_datos
    if ( ( buffer_arch(i) >= -3 ) && ( buffer_arch(i) <= 16 ) )
        ge_menostre_le_diezyseis = ge_menostre_le_diezyseis + 1;
    end
end