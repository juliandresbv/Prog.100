function imprimirMatriz_2( matriz )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

fprintf('n\t Cn     \t F(Cn) \t      dF(Cn) \t    Error relativo\n');
for i=1:size(matriz,1)
fprintf('%d \t %.4f \t %.4f \t %.4f \t %.4f\n',matriz(i,1),matriz(i,2),...
    matriz(i,3),matriz(i,4),matriz(i,5));
end

fprintf('\n\n')

end