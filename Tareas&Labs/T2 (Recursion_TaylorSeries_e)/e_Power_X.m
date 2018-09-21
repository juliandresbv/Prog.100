function [e] = e_Power_X(x, n)
    %   E_POWER_X Funcion auxiliar para hacer el llamado a la funcion
    %   recursiva E_POWER_X_REC
    %   Parametros:
    %   x := exponente al cual se va a elevar e
    %   n := número de "repeticiones" para el valor de e^x
    
    format long;
    e = e_Power_X_Rec(x, n, 1);
end


