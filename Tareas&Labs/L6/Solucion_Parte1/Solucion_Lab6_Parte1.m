% Laboratorio 8
clear all,clc,close all;
%% regresion
ID=fopen('pobreza.txt','r');
Values=textscan(ID,'%s %s %s');
fclose(ID);
for i=2:size(Values{1},1)
    X(i-1)=str2double(Values{2}{i});
    Y(i-1)=str2double(Values{3}{i});
end

meanX=mean(X);
meanY=mean(Y);
N=length(X);

% Mat*A=B
Mat=[1,meanX;meanX,(1/N)*(sum(X.^2))];
B=[meanY;(1/N)*(sum(X.*Y))];
A=inv(Mat)*B;
Y_est_1=A(2)*X+A(1);

%A1=covarianza(X,Y)/Varianza(X)
covar=cov(X,Y);
A1=covar(2,1)/covar(1,1);
A0=meanY-meanX*A1;
Y_est_2=A1*X+A0;

%polyfit
p=polyfit(X,Y,1);
Y_poly=polyval(p,X);

%graphics
figure()
subplot(1,3,1);plot(X,Y,'*');
hold on
plot(X,Y_est_1,'b');
title('Forma matricial');
ecuacion=['Y = ' num2str(A(2)) 'X + ' num2str(A(1))];
legend('Data',ecuacion)
ylabel('PovPct');
xlabel('Brth15to17');

subplot(1,3,2);plot(X,Y,'*');
hold on
plot(X,Y_est_2,'r');
title('A1=covarianza(x,y)/variaza(x)');
ecuacion=['Y = ' num2str(A1) 'X + ' num2str(A0)];
legend('Data',ecuacion)
ylabel('PovPct');
xlabel('Brth15to17');

subplot(1,3,3);plot(X,Y,'*');
hold on
plot(X,Y_poly,'g');
title('Polyfit-polyval');
ecuacion=['Y = ' num2str(p(1)) 'X + ' num2str(p(2))];
legend('Data',ecuacion)
ylabel('PovPct');
xlabel('Brth15to17');

fig=gcf;
fig.Units = 'normalized';
fig.OuterPosition = [0 0 1 1];

%R^2
R1=1-((sum((Y-Y_est_1).^2))./(sum((Y-meanY).^2)));
R1_2=1-((sum((Y-Y_est_2).^2))./(sum((Y-meanY).^2)));
R2=corrcoef(X,Y);
R2=R2(1,2)^2;

%Imprimir valores de R^2
fprintf('R2 calculado con la forma matricial: %.3f y R2 con funcion de matlab: %.3f',R1,R2);
fprintf('R2 calculado con la formula de covariaza: %.3f y R2 con funcion de matlab: %.3f',R1_2,R2);

%% Ejercicios
% clear all;close all;clc
Tolerancia=10^-3;
addpath('funciones_Parte1')
%% Punto 2

% a.
Sow=1;
f1=@(T)-139.34411+((1.575701*10^5)./(T+273.15))-((6.642308*10^7)./((T+273.15).^2))+...
    ((1.243800*10^10)./((T+273.15).^3))-((8.621949*10^11)./((T+273.15).^4))-log(Sow);

T1=100;
T2=200;

[raiz_1a,matriz]=Biseccion(f1,[T1 T2],Tolerancia);
imprimirMatriz(matriz);

% b.
Sow=8;
f2=@(T)-139.34411+((1.575701*10^5)./(T+273.15))-((6.642308*10^7)./((T+273.15).^2))+...
    ((1.243800*10^10)./((T+273.15).^3))-((8.621949*10^11)./((T+273.15).^4))-log(Sow);

[raiz_1b_1,matriz]=Biseccion(f2,[T1 T2],Tolerancia);
imprimirMatriz(matriz);

Sow=10;
f3=@(T)-139.34411+((1.575701*10^5)./(T+273.15))-((6.642308*10^7)./((T+273.15).^2))+...
    ((1.243800*10^10)./((T+273.15).^3))-((8.621949*10^11)./((T+273.15).^4))-log(Sow);

[raiz_1b_2,matriz]=Biseccion(f2,[T1 T2],Tolerancia);
imprimirMatriz(matriz);

Sow=14;
f4=@(T)-139.34411+((1.575701*10^5)./(T+273.15))-((6.642308*10^7)./((T+273.15).^2))+...
    ((1.243800*10^10)./((T+273.15).^3))-((8.621949*10^11)./((T+273.15).^4))-log(Sow);

[raiz_1b_3,matriz]=Biseccion(f4,[T1 T2],Tolerancia);
imprimirMatriz(matriz);

%% Punto 4
Fo=480;
tau=180;
F=@(t) 480*sin((pi*t)/tau)+160*(1-(t/tau))-Fo;
intervalo=[1,75];

[raiz_4,matriz]=Falsa_Posicion(F,intervalo,Tolerancia);
imprimirMatriz(matriz);

%% Punto 7
densidad=1000;
visco=0.001;
D=2.8/1000;
vel=1.8;
Re=(D*vel*densidad)/visco;
Tolerancia=10^-6;%Se cambia la tolerancia para que el valor sea mas exaxto

f=@(b)(1./sqrt(b))-4.07*log(Re*sqrt(b))+0.06;
% b=-0.1:0.0001:0.1;
% plot(b,f(b));

intervalo=[0.001,0.01];
[raiz_7b,matriz]=Falsa_Posicion(f,intervalo,Tolerancia);
imprimirMatriz(matriz);
