function [ex] = Taylor_Series_ex(x, n)
    %TAYLOR_SERIES_EX Summary of this function goes here
    %   Detailed explanation goes here
    ex = 1;
    if ( n > 0 )
        ex = ( (x^n)/(factorial(n)) ) + ( Taylor_Series_ex(x, (n - 1)) );
    end
end

