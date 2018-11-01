function [x_nplus1] = Secante(f, x_0, x_1, tol)
    %   SECANTE Summary of this function goes here
    %   Detailed explanation goes here
    format long g;
    
    i = 1;
    fx0 = feval(f, x_0);
    fx1 = feval(f, x_1);
    
    x_nplus1 = x_1 - ((x_1 - x_0) / (fx1 - fx0)) * (fx1);
    
    error = abs( x_1 - x_0 );

    fprintf('N \t x_n-1 \t\t x_n \t\t x_n+1\n');
    fprintf('%i \t %f \t %f \t %f\n', i, x_0, x_1, x_nplus1);

    while error >= tol
        x_1 = x_0;
        x_0 = x_nplus1;
        fx1 = feval(f,x_1);
        fx0 = feval(f,x_0);
        x_nplus1 = x_1 - ((x_1 - x_0)/(fx1 - fx0))*fx1;
        error = abs( x_1 - x_0 );
        i = i + 1;
        fprintf('%i \t %f \t %f \t %f \n', i, x_0, x_1, x_nplus1);
    end
    
    w = feval(f, x_nplus1);
    fprintf('\n La mejor aproximación x_0 la raiz tomando una tolerancia de %f es \n x = %f con \n f(x) = %f\n y se realizaron %i iteraciones\n',tol, x_nplus1, w, i);
end