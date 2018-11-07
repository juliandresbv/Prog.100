format long g;

%   Constantes
h = pi / 2;
c = pi / 2;

%   Funcion
f = @(w) ( ( -3.65 .* log(w / 5.33) ) + ( sqrt(2) .* exp( -(c.^2) - 4.25 ) ) + ( 10.54 .* cos(w - 2.2) ) - ( 6.67 .* h ) );

%   Rango de w
w = 0.01:10^-7:10;

%%   Literal a.
falsa_posicion(f, 0.01, 0.1, 1*10.^-7);

%%   Literal b.
biseccion(f, 0.01, 0.1, 1*10.^-7);

%%  Literal c.
%   Funcion propuesta
g = @(w) log(w) +  cos(w);