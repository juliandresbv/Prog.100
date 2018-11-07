function [x_medio] = biseccion(f, a, b, tol)
    %   BISECCION Summary of this function goes here
    %   Detailed explanation goes here
    format long g;
    
    i = 0;
    error = (b - a) / 2;
    c = 0;
    
    %fprintf('N \t a \t\t\t c \t\t\t b \t\t\t Error \t\t\t f(c)\n');
    fprintf('N \t c \t f(c)\n');

    while ( error >= tol )
        c = (a + b) / 2;
        i = i + 1;
        
        fa = feval(f, a);
        fc = feval(f, c);
        %   fb = feval(f, b);
        
        disp([i c fc]);

        if ( (fa*fc) < 0 )
            b = c;
        else
            a = c;
        end
        
        error = (b - a) / 2;
    end
    
    x_medio = c;
    w = feval(f, x_medio);
    fprintf('\n La mejor aproximación a la raiz tomando una tolerancia de %.18f es \n x = %.18f con \n f(x) = %.18f\n y se realizaron %i iteraciones\n', tol, x_medio, w, i);
end

