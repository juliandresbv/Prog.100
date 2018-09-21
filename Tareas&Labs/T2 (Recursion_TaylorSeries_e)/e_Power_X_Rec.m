function [e] = e_Power_X_Rec(x, n, d)
    %   E_POWER_X_REC Funcion recursiva para calcular el valor de e^x
    %   Parametros:
    %   x := exponente al cual se va a elevar e
    %   n := número de "repeticiones" para el valor de e^x
    %   d := divisor para cada termino de la serie de Taylor
    
    format long;
    e = 1;
    if (n > 0)
        e = e + (x/d)*(e_Power_X_Rec(x, n-1, d+1));
    end
end

