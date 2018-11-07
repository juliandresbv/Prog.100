function [r_fp] = falsa_posicion(f, a, b, tol)
    %   BISECCION Summary of this function goes here
    %   Detailed explanation goes here
    format long g;
    
    i = 1;
    
    fa = feval(f, a);
    fb = feval(f, b);
    
    c = ( (a*fb) - (b*fa) )/( fb - fa );
    fc = feval(f, c);
    
    error = abs( fc );
    
    %fprintf('N \t a \t\t\t c \t\t\t b \t\t\t Error \t\t\t f(c)\n');
    fprintf('N \t c \t f(c)\n');

    while ( error >= tol )
        fa = feval(f, a);
        fb = feval(f, b);

        c = ( (a*fb) - (b*fa) )/( fb - fa );
        fc = feval(f, c);
        
        %fprintf('%i \t %f \t %f \t %f \t %f \t %f\n', i, a, c, b, error, fc);
       disp([i c fc]);

        if ( (fa*fc) < 0 )
            b = c;
        else
            a = c;
        end
        
        error = abs( fc );
        
        i = i + 1;
    end
    
    r_fp = c;
    y = feval(f, r_fp);
    fprintf('\n La mejor aproximación a la raiz tomando una tolerancia de %.18f es \n x = %.18f con \n f(x) = %.18f\n y se realizaron %i iteraciones\n', tol, r_fp, y, i);
end

