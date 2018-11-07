function [ solucion, matrizRes ] = Secante( funcion, limites, tolerancia )
    % Secante:  Función que calcula la solución de un sistema no lineal
    % usando el método de la secante
    % Entradas:
    %   funcion - Función no lineal
    %   limites - Vector con las condiciones iniciales de los límites x0 y x1 
    %   tolerancia - Condición de parada 

    x0 = limites(1);
    x1 = limites(2);

    fx0 = feval (funcion,x0);
    fx1 = feval (funcion, x1);

    error = inf;             % Error 
    iteracion = 0;           % Número de la iteración
    matrizRes = zeros(1,4);  % Matriz para guardar los resultados:
                             % 1. Número de iteración
                             % 2. x2 Calculado
                             % 3. Función evaluada en x2
                             % 4. Error para la iteración

    while error > tolerancia % Ciclo hasta llegar a la tolerancia deseada 
        x2 = x0 - ((x1 - x0)/(fx1 - fx0)) * fx0; % Calcular el x2
        fx2 = feval(funcion,x2);                 % Evaluar la función en x2  

        error = abs(x2 - x1)/x2;       % Calcular el error asociado a esta iteración
        iteracion = iteracion + 1;  % Actualizar el valor de las iteraciones
        matrizRes(iteracion, :) = [iteracion x2 fx2 error]; % Actualizar la matriz de resultados 

        x0 = x1;   % Actualizar el valor de x0
        x1 = x2;   % Actualizar el valor de x1
        fx0 = fx1; % Actualizar la función evaluada en x0
        fx1 = fx2; % Actualizar la función evaluada en x1
    end
        solucion = x2;
end

