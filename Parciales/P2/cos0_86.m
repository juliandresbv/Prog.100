format long g;

cosx_hat_vector = zeros(1, 6);
err_abs_vector = zeros(1, 6);
err_rel_vector = zeros(1, 6);

for i = 0:5
    cosx_hat = cosx_taylor_series(0.86,i);
    cosx_hat_vector(i + 1) = cosx_hat;
    
    err_abs = abs( cos(0.86) - cosx_hat );
    err_abs_vector(i + 1) = err_abs;
    
    err_rel = ( err_abs )/( abs( cos(0.86) ) );
    err_rel_vector(i + 1) = err_rel;
end

disp(cosx_hat_vector);
disp(err_abs_vector);
disp(err_rel_vector);