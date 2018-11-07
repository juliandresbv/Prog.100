function [ solucion, matrizRes ] = Secante( funcion, limites, tolerancia )
    % Secante:  Funci�n que calcula la soluci�n de un sistema no lineal
    % usando el m�todo de la secante
    % Entradas:
    %   funcion - Funci�n no lineal
    %   limites - Vector con las condiciones iniciales de los l�mites x0 y x1 
    %   tolerancia - Condici�n de parada 

    x0 = limites(1);
    x1 = limites(2);

    fx0 = feval (funcion,x0);
    fx1 = feval (funcion, x1);

    error = inf;             % Error 
    iteracion = 0;           % N�mero de la iteraci�n
    matrizRes = zeros(1,4);  % Matriz para guardar los resultados:
                             % 1. N�mero de iteraci�n
                             % 2. x2 Calculado
                             % 3. Funci�n evaluada en x2
                             % 4. Error para la iteraci�n

    while error > tolerancia % Ciclo hasta llegar a la tolerancia deseada 
        x2 = x0 - ((x1 - x0)/(fx1 - fx0)) * fx0; % Calcular el x2
        fx2 = feval(funcion,x2);                 % Evaluar la funci�n en x2  

        error = abs(x2 - x1)/x2;       % Calcular el error asociado a esta iteraci�n
        iteracion = iteracion + 1;  % Actualizar el valor de las iteraciones
        matrizRes(iteracion, :) = [iteracion x2 fx2 error]; % Actualizar la matriz de resultados 

        x0 = x1;   % Actualizar el valor de x0
        x1 = x2;   % Actualizar el valor de x1
        fx0 = fx1; % Actualizar la funci�n evaluada en x0
        fx1 = fx2; % Actualizar la funci�n evaluada en x1
    end
        solucion = x2;
end

