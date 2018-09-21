function [b] = dectobin(d)
    % DECTOBIN
    % Esta funcion convierte un numero decimal a binario.
    % Formato de entrada: numero double.
    b = [];
    while d >= 2
        r = mod(d,2);
        b = [r, b];
        d = fix(d/2);
    end
    if d == 1
        b = [d,b];
    end
end

