function [ solucion, matrizRes ] = Falsa_Posicion( funcion, limites, tolerancia )
    % Falsa_Posicion: Función que calcula la solución de un sistema no lineal
    % usando el método de falsa posición
    % Entradas:
    %   funcion - Función no lineal
    %   limites - Vector con las condiciones iniciales de los límites a y b
    %   tolerancia - Condición de parada 

     x0 = limites(1); % Obtener el x0 inicial 
     x1 = limites(2); % Obtener el x1 inicial 

     fx0 = feval(funcion, x0); % Evaluar la función en x0
     fx1 = feval(funcion, x1); % Evaluar la función en x1

     error = inf;              % Error
     iteracion = 0;            % Número de la iteración
     x2Anterior = 0;           % Estimado x2 de la iteración anterior
     matrizRes = zeros(1,4);   % Matriz para guardar los resultados:
                               % 1. Número de iteración
                               % 2. x2 Calculado
                               % 3. Función evaluada en x2
                               % 4. Error para la iteración

    while error > tolerancia % Ciclo hasta llegar a la tolerancia deseada 

        x2 = x1-((fx1*(x1-x0))/(fx1-fx0)); % Calcular x2 
        fx2 = feval(funcion,x2);           % Evaluar la funcion en x2

        if(fx0 * fx2 <0)           % Si fx0*fx2<0 la raíz está en este rango
            x1 = x2;               % Cambiar el valor del límite x1
            fx1 = fx2;             % Cambiar el valor de la función en x1
        else                       % Si fx0*fx2>0 la raíz está en el otro rango
            x0 = x2;               % Cambiar el valor del límite x0
            fx0 = fx2;             % Cambiar el valor de la función en x0
        end 

        error = abs(x2 - x2Anterior)/x2; % Calcular el error asociado a esta iteración
        x2Anterior = x2;              % Actualizar el valor de cAnterior
        iteracion = iteracion + 1;    % Actualizar el valor de las iteraciones

        matrizRes(iteracion, :) = [iteracion x2 fx2 error]; % Actualizar la matriz de resultados

    end
    solucion = x2; % Guardar la solución en la variable de salida

end

