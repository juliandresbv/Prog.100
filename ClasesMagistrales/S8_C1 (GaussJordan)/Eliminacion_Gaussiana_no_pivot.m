function [Au] = GaussJordan_no_pivot(A, B)
    %   GAUSSJORDAN. Funcion que calcula la matriz de GaussJordan para una
    %   matriz A(NxN) con soluciones en la matriz B(NxM).
    
    %   I. Crear matriz aumentada Au = [A B eye(size(A, 1))]
    %      Alojar espacio en memoria.
    Au = zeros(size(A, 1), 2*size(A, 2) + size(B, 2));
    
    %      Llenar matriz acorde a Au = [A B eye(size(A, 1))]
    Au = [A B eye( size(A, 1) )];
    
    %   II. Proceso iterativo por filas.
    %       Escoger un pivote y convertirlo en 1 (Multiplicar la fila por 
    %       el inverso multiplicativo del pivote).
    for row_count = 1:size(A, 1)
        %   En este caso, se asume que los valores en la diagonal no son
        %   0.
        
        %   Se selecciona el pivote.
        pivote = Au(row_count, row_count);
        
        %   Se verifica que el pivote no sea 0.
        %   En caso de que sea 0, se debe intercambiar la fila actual por
        %   la fila con el mayor valor en la columna.
        %   TO-DO
        if (pivote == 0)
            current_col = Au(:, row_count);
            [~, pivot_index] = max( abs(current_col) );
            
            row_with_pivot_zero = Au(row_count, :);
            Au(row_count, :) = Au(pivot_index, :);
            Au(pivot_index, :) = row_with_pivot_zero;
            
            pivote = Au(row_count, row_count);
        end
        
        %   II.I. Se convierte el pivote (y su fila correspondiente) en 1 (uno).
        %Au(row_count, :) = Au(row_count, :).*( 1/pivote );
        
        %   Aqui en el metodo de Gauss el indice inner_row_count puede 
        %   tomar el valor de inner_row_count = row_count + 1.
        %   Para GaussJordan, el indice va de 1 a size(A, 1), ya que revisa
        %   todas las filas.
        for inner_row_count = (row_count + 1):size(A, 1)
            if (inner_row_count == row_count)
                 continue;
            end
            
            %   II.II Se convierte en 0 los elementos de la columna del
            %   pivote.
            Au(inner_row_count, :) = Au(inner_row_count, :) + ( -Au(inner_row_count, row_count) / pivote ).*( Au(row_count, :) );
        end
    end
end

%   Test cases:
%   A = [4 3 2;-1 -1/2 4;-3/4 4 25]
%   B = [5 7;3 1;13 2]

