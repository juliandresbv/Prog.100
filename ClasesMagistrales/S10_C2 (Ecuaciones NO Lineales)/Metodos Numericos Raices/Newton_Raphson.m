function [ solucion, matrizRes ] = Newton_Raphson( funcion, x0, tolerancia )
    % Newton_Raphson: Funci�n que calcula la soluci�n de un sistema no lineal
    % usando el m�todo de Newton-Raphson
    % Entradas:
    %   funcion - Funci�n no lineal f(x)
    %   x0 - Condici�n inicial de x0
    %   tolerancia - Condici�n de parada
    
    syms x                                     % Necesario para calcular la derivada 
    fx = feval(funcion, x0);                   % Evaluar la funci�n en x0
    fderiv = matlabFunction(diff(funcion(x))); % Hallar la derivada de la funcion
                                               % Se una matlabFunction para que el resultado sea un handle
    fderivx = feval(fderiv, x0);               % Derivada evaluada en x0
    
    error = inf;             % Error
    iteracion = 0;           % N�mero de la iteraci�n
    matrizRes = zeros(1,5);  % Matriz para guardar los resultados:
                             % 1. N�mero de iteraci�n
                             % 2. x1 Calculado
                             % 3. Funci�n evaluada en x1
                             % 4. Derivada de la funci�n evaluada en x1
                             % 5. Error para la iteraci�n

    while error > tolerancia % Ciclo hasta llegar a la tolerancia deseada
        
        x1 = x0 - fx/fderivx;       % Calcular x1
        fx = feval(funcion, x1);    % Evaluar la funci�n en x1
        fderivx = feval(fderiv, x1);% Evaluar la derivada en x1
        
        error = abs(x1 - x0)/x1;       % Calcular el error asociado a esta iteraci�n
        x0 = x1;                    % Actualizar el valor de x0
        iteracion = iteracion + 1;  % Actualizar el valor de las iteraciones
        matrizRes(iteracion, :) = [iteracion x1 fx fderivx error]; % Actualizar la matriz de resultados
        
    end
    
    solucion = x1; % Guardar la soluci�n en la variable de salida
end

