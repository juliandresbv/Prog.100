function [edad, fcm, imc] = HealthIndexes(hp)
    %   HEALTHINDEXES Funcion que calcula los indices de salud para un
    %   HealthProfile dado.
    %   Detailed explanation goes here
    current_date = clock;
    current_year = double( current_date(1) );
    anio_hp = double( hp.fecha_nacimiento(3) );
    
    edad = double( current_year - anio_hp );
    fcm = double( 220 - edad );
    %rfmo = double( 50 - ((0.85)*(fcm)) );
    imc = double( hp.peso/((hp.altura)^2) );
end

