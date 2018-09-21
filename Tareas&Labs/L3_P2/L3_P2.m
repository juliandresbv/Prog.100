for i = 2:length(data)
    current_pacient = data(i,:);
    
    nombre = current_pacient(1);
    apellido = current_pacient(2);
    genero = current_pacient(3);
    
    fecha_nacimiento = zeros(1,3);
    fecha_nacimeinto(1) = current_pacient(4);
    fecha_nacimeinto(2) = current_pacient(5);
    fecha_nacimeinto(3) = current_pacient(6);
    
    altura = current_pacient(7);
    peso = current_pacient(8);
    
    current_hp = CreateHealthProfile(nombre, apellido, genero, fecha_nacimiento, altura, peso);
    
end