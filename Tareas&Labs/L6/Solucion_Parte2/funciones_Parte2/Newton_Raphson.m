function [ solucion, matrizRes ] = Newton_Raphson( funcion, x0, tolerancia )
    % Newton_Raphson: Función que calcula la solución de un sistema no lineal
    % usando el método de Newton-Raphson
    % Entradas:
    %   funcion - Función no lineal f(x)
    %   x0 - Condición inicial de x0
    %   tolerancia - Condición de parada
    
    syms x                                     % Necesario para calcular la derivada 
    fx = feval(funcion, x0);                   % Evaluar la función en x0
    fderiv = matlabFunction(diff(funcion(x))); % Hallar la derivada de la funcion
                                               % Se una matlabFunction para que el resultado sea un handle
    fderivx = feval(fderiv, x0);               % Derivada evaluada en x0
    
    error = inf;             % Error
    iteracion = 0;           % Número de la iteración
    matrizRes = zeros(1,5);  % Matriz para guardar los resultados:
                             % 1. Número de iteración
                             % 2. x1 Calculado
                             % 3. Función evaluada en x1
                             % 4. Derivada de la función evaluada en x1
                             % 5. Error para la iteración

    while error > tolerancia % Ciclo hasta llegar a la tolerancia deseada
        
        x1 = x0 - fx/fderivx;       % Calcular x1
        fx = feval(funcion, x1);    % Evaluar la función en x1
        fderivx = feval(fderiv, x1);% Evaluar la derivada en x1
        
        error = abs(x1 - x0)/x1;       % Calcular el error asociado a esta iteración
        x0 = x1;                    % Actualizar el valor de x0
        iteracion = iteracion + 1;  % Actualizar el valor de las iteraciones
        matrizRes(iteracion, :) = [iteracion x1 fx fderivx error]; % Actualizar la matriz de resultados
        
    end
    
    solucion = x1; % Guardar la solución en la variable de salida
end

