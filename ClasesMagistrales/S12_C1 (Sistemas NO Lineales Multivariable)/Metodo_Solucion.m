%   I. Definir el punto inicial
x1i = -0.5;
x2i = 2;

%   II. Definir las funciones correspondientes a f1(x1, x2); f2(x1, x2) y
%   la matriz Jacobiana.

f1 = @(x1, x2) x1.^2 - x2.^2 + 3;
f2 = @(x1, x2) (x1 + 2 ).^2 - x2;

d11 = @(x1, x2) 2.*x1;
d12 = @(x1, x2) -2.*x2;
d21 = @(x1, x2) 2.*(x1 + 2);
d22 = -1;

%   III. Proceso iterativo
    %   III.I Construir matriz Jacobiana
    
tolX = 10^-10;
tolF = 10^-10;

while (1)
    J = zeros(2, 2);
    
    J(1, 1) = d11;
    J(1, 2) = d12;
    J(2, 1) = d21;
    J(2, 2) = d22;
    
    b = zeros(2, 1);
    
    b(1) = -f1(x1i, x2i);
    b(2) = -f2(x1i, x2i);
    
    dx = J \ b;
    
    x1sig = x1i + dx(1);
    x2sig = x2i + dx(2);
    
    if ( ((x1sig - x1i) > tolF) )
    else
        x1i = x1sig;
        x2i = x2sig;
    end
    
end