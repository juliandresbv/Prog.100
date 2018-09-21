function [hp] = CreateHealthProfile(nombre, apellido, genero, fecha_nacimiento, altura, peso)
    %   HEALTHPROFILE. Crea una estructura para representar el perfil de
    %   salud.
    %   Params:
    %       nombre (String). El nombre de la persona
    %       apellido (String). El apellido de la persona
    %       genero (String). Genero de la persona (M o F)
    %       fecha_nacimiento (Array (double)). Fecha de nacimiento de la persona [dd MM yyyy].
    %       altura (double). La altura en metros de la persona
    %       peso (double). Peso de la persona.
    
    hp = struct('nombre',nombre, 'apellido',apellido, 'genero',genero, 'fecha_nacimiento',fecha_nacimiento, 'altura',altura, 'peso',peso);
end
