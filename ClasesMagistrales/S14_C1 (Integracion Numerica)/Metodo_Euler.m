%%  Integracion Numerica

%   Metodo de Euler
%   I. Definir un valor para h    
%   II. Proceso iterativo (Se halla el valor de y_hat correspondiente a cada iteracion)
    
dydt = @(t, y) ( 4*t.^2 + y*t.^2 );             %   Corresponde a dy/dt igual a f(t, y)
y = @(t) ( 6*exp(-1/3)*exp((t.^3)/3) - 4 );     %   Solucion de la EDO

t_0 = 0;                                        %   t_0
t_f = 2;                                        %   t_f
h = 0.001;                                      %   Delta: h = t_k+1 - t_k
vector_y = [];

for t = t_0:h:t_f
    y_hat_t_k = y(t);
    y_hat_t_kplus1 = y_hat_t_k + h.*( dydt(t, y_hat_t_k) );
    vector_y = [vector_y y_hat_t_kplus1];
end

figure;
plot((t_0:h:t_f), vector_y);

figure;
%plot((0:t:2), [y(t)]);