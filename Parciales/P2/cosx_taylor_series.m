function [cos] = cosx_taylor_series(x, n)
    %   COS_TAYLOR_SERIES Summary of this function goes here
    %   Detailed explanation goes here
    format long g;
    
    cos = 1;
    if (n > 0)
        cos = ( ( (-1)^n)*(x^(2*n) ) )/( factorial(2*n) ) + cosx_taylor_series(x, n-1);
    end
end
