%%  1. Una función que convierta de binario a base decimal.
function [d] = bintodec(b)
    % BINTODEC
    % Esta funcion convierte un numero binario a decimal.
    % Formato de entrada: arreglo de numeros binarios ([(0|1) (0|1) ... (0|1) (0|1)]).
    d = 0;
    for i = length(b):-1:1
        if(b(i) == 1)
            d = d + (2^(length(b) - i));
        end
    end
end