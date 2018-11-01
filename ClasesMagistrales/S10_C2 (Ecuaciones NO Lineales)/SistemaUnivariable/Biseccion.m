function [x_medio] = Biseccion(f, a, b, tol)
    %   BISECCION Summary of this function goes here
    %   Detailed explanation goes here
    format long g;
    
    i = 0;
    error = (b - a) / 2;
    c = 0;
    
    fprintf('N \t a \t\t\t c \t\t\t b \t\t\t Error \t\t\t f(c)\n');

    while ( error >= tol )
        c = (a + b) / 2;
        i = i + 1;
        
        fa = feval(f, a);
        fc = feval(f, c);
        fb = feval(f, b);
        
        fprintf('%i \t %f \t %f \t %f \t %f \t %f\n', i, a, c, b, error, fc);

        if ( (fa*fc) < 0 )
            b = c;
        elseif ( (fc*fb) < 0 )
            a = c;
        end
        
        error = (b - a) / 2;
    end
    
    x_medio = c;
    w = feval(f, x_medio);
    fprintf('\n La mejor aproximación a la raiz tomando una tolerancia de %f es \n x = %f con \n f(x) = %f\n y se realizaron %i iteraciones\n', tol, x_medio, w, i);
end

