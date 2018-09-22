%%  Carga Lista.mat

load('Lista.mat');
%   Guarda la informacion de pacientes como una matriz de celdas llamada
%   "data".

%%  Generar HealthProfiles

edades = zeros(1, length(data) - 1);
%   vector de edades de los pacientes.

for i = 2:length(data)
    current_patient = data(i,:);
    %   Se recupera el paciente i-esimo de la matriz data.
    
    nombre = string( current_patient(1) );
    apellido = string( current_patient(2) );
    genero = string( current_patient(3) );
    
    fecha_nacimiento(1) = str2double( string( current_patient(4) ) );
    fecha_nacimiento(2) = str2double( string( current_patient(5) ) );
    fecha_nacimiento(3) = str2double( string( current_patient(6) ) );
    
    altura = str2double( string( current_patient(7) ) );
    peso = str2double( string( current_patient(8) ) );
    %   Se da un formato especifico a cada campo del i-esimo paciente.
    
    current_hp = CreateHealthProfile(nombre, apellido, genero, fecha_nacimiento, altura, peso);
    %   Se crea la estructura con los datos formateados del i-esimo
    %   paciente.
    
    [edad, fmc, imc] = HealthIndexes(current_hp);
    %   Se calculan los indices de salud para el i-esimo paciente.
    
    edades(i - 1) = edad;
    %   Se ingresan las edades en el vector de edades.
    
    [min, max, mean] = MinMaxMean(edades);
end