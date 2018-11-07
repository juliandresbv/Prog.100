function [ solucion, matrizRes ] = Biseccion( funcion, limites, tolerancia)
    % Biseccion:  Función que calcula la solución de un sistema no lineal
    % usando el método de bisección
    % Entradas:
    %   funcion - Función no lineal
    %   limites - Vector con las condiciones iniciales de los límites a y b
    %   tolerancia - Condición de parada 

    a = limites(1);         % Límite a 
    b = limites(2);         % Límite b 

    fa = feval(funcion,a);   % Función evaluada en a
    fb = feval(funcion,b);   % Función evaluada en b  

    error = inf;             % Error 
    iteracion = 0;           % Número de la iteración
    cAnterior = 0;           % Estimado c de la iteración anterior
    matrizRes = zeros(1,4);  % Matriz para guardar los resultados:
                             % 1. Número de iteración
                             % 2. c Calculado
                             % 3. Función evaluada en c
                             % 4. Error para la iteración

    while error > tolerancia % Ciclo hasta llegar a la tolerancia deseada 
%         a1=a;b1=b;
        
        c = (a + b)/2;         % Calcular el c como el punto medio de los límites
        fc = feval(funcion,c); % Evaluar la función en c 

        if(fc * fa <0)       % Si fc*fa es menor a cero es porque ahí esta el cruce
            fb = fc;         % Cambiar el límite b por c 
            b = c;
        else                 % Si fc*fb es menor a cero es porque ahí esta el cruce  
            fa = fc;         % Cambiar el límite a por c
            a = c;
        end

        error = abs(c - cAnterior)/c; % Calcular el error asociado a esta iteración
        cAnterior = c;              % Actualizar el valor de cAnterior 
        iteracion = iteracion + 1;  % Actualizar el valor de las iteraciones

        matrizRes(iteracion, :) = [iteracion c fc error]; % Actualizar la matriz de resultados 
%         matrizRes(iteracion, :) = [iteracion a1 b1 c fc error];
    end

    solucion = c; % Guardar la solución en la variable de salida

end

