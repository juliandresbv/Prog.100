format long;
%%  Calcular e^1 con 20 llamadas recursivas
e_hat = zeros(1,20);

for i=1:20
    e_hat(i) = e_Power_X(1,i);
end

%%  Calcular error absoluto y err relativo
abs_err = zeros(1,20);
rel_err = zeros(1,20

for i=1:20
    abs_err(i) = abs(exp(1) - e_hat(i));
    rel_err(i) = abs_err(i)/exp(1);
end

%%  Graficar abs_err VS e^1
figure;
plot(e_hat, abs_err);
xlabel('e^1 mediante serie de Taylor');
ylabel('Error absoluto');

%%  Graficar rel_err VS e^1
figure;
plot(e_hat, rel_err);
xlabel('e^1 mediante serie de Taylor');
ylabel('Error relativo');
