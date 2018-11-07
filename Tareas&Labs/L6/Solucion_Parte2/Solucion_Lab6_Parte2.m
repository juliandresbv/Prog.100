% Laboratorio 8
%% Ejercicios
clear all;close all;clc
Tolerancia=10^-3;
addpath('funciones_Parte2')
%% Punto 1
F=0.04;
intervalo=[0.25,0.26];
f1=@(E)1-(16/7)*(E^(1/2))+(4/3)*E-(1/21)*(E^4) - F;

[raiz_1,matriz_1] = Secante(f1,intervalo,Tolerancia);
imprimirMatriz(matriz_1);

%% Punto 3
SOS_o=3850;
SOS=@(Y) 3383+38.9*Y-0.78*(Y^2)+0.0039*(Y^3)-SOS_o;
Y_ini=45;

[raiz_2,matriz_2]=Newton_Raphson(SOS,Y_ini,Tolerancia);
imprimirMatriz_2(matriz_2);

%% Punto 5
R=0.032;
k=1.9*(10^-4);
D=4*(10^-7);

fi=R*sqrt(k/D);

C=@(ce) (1./ce).*exp(-fi.*(ce-1))-0.5;

ce_1=0:0.1:5;
plot(ce_1,C(ce_1));

intervalo=[1,2];
[raiz_3,matriz_3]=Secante(C,intervalo,Tolerancia);
imprimirMatriz(matriz_3);

%% Punto 6
Km=0.5;
Vmax=5;
So=1;
Tolerancia=10^-6;

% f2=@(S) Km*log(So./S)+(So-S)-Vmax*t;
% S=0:0.001:5;
% plot(S,f2(S));

S_ini=10^-14;
cont=1;

%Cambiar para las 200 iteraciones
% for t=0:0.1:200
for t=0:0.1:2
    f2=@(S) Km*log(So./S)+(So-S)-Vmax*t;
    [raiz_4,matriz_4]=Newton_Raphson(f2,S_ini,Tolerancia);
    imprimirMatriz_2(matriz_4);
    valuesS_t(cont,:)=[raiz_4,t];
    cont=cont+1;
end
valuesS_t
%% Punto 7a
densidad=1000;
visco=0.001;
D=2.8/1000;
vel=1.8;
Re=(D*vel*densidad)/visco;
Tolerancia=10^-6;%Se cambia la tolerancia para que el valor sea mas exaxto

fg=@(b)1./((4*log(Re.*sqrt(b))-0.06).^2);
b=0.00001:0.0001:0.01;
plot(b,fg(b));
hold on
plot(b,b);

b0=0.001;
[raiz_7a,matriz_5]=Punto_Fijo(fg,b0,Tolerancia);
imprimirMatriz(matriz_5);