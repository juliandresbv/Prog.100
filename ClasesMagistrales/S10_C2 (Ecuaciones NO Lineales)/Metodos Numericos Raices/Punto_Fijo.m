function [ solucion, matrizRes ] = Punto_Fijo( funciong, x0, tolerancia )
    % Punto_Fijo: Función que calcula la solución de un sistema no lineal
    % usando el método de punto fijo
    % Entradas:
    %   funcion - Función no lineal f(x)
    %   funciong - Función g(x)
    %   x0 - Condición inicial de x0
    %   tolerancia - Condición de parada

    error = inf;             % Error
    iteracion = 0;           % Número de la iteración
    matrizRes = zeros(1,4);  % Matriz para guardar los resultados:
                             % 1. Número de iteración
                             % 2. x1 Calculado
                             % 3. Función g evaluada en x0
                             % 4. Error para la iteración

    while error > tolerancia % Ciclo hasta llegar a la tolerancia deseada
        gx0 = feval(funciong,x0);   % Evaluar la funcion g en x0
        x1 = gx0;                   % Actualizar el valor de x0

        error = abs(x1 - x0)/x1;       % Calcular el error asociado a esta iteración
        x0 = x1;                    % Actualizar el valor de x0
        iteracion = iteracion + 1;  % Actualizar el valor de las iteraciones
        matrizRes(iteracion, :) = [iteracion x1 gx0 error]; % Actualizar la matriz de resultados
    end

    solucion = x1; % Guardar la solución en la variable de salida

end

