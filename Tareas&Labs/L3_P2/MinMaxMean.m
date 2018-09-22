function [min, max, mean] = MinMaxMean(nums_vector)
    %   MINMAXMEAN. Funcion que calcula el minimo, maximo y la media en un
    %   conjunto de datos de tipo numerico.
    %   Detailed explanation goes here
    
    max = intmin('int64');
    for i = 1:length(nums_vector)
        if ( nums_vector(i) > max )
            max = nums_vector(i);
        end
    end
    %   Calcula el maximo elemento en el vector.
    
    min = intmax('int64');
    for i = 1:length(nums_vector)
        if ( nums_vector(i) < max )
            min = nums_vector(i);
        end
    end
    %   Calcula el minimo elemento en el vector.
    
    sum = 0;
    for i = 1:length(nums_vector)
        sum = sum + nums_vector(i);
    end
    mean = sum/(length(nums_vector));
    %   Calcula el promedio del conjunto de datos.
end

