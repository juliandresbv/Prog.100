% p_Taller02Sol.m

clc
close all hidden

% Punto 1
% y' - t^2 y = 4 t^2 con y(1) = 2
% y' = t^2 y + 4 t^2
% y(t) = 6 exp(-1/3) exp(t^3/3)-4;

s_T0 = 1;
s_TN = 2;
s_Y0 = 2;
v_H = [0.1 0.01 0.001 0.0001];
f1 = @(t, y) t.^2.* y + 4.* t.^2;
f1EulerBack = @(x, t, y, h) y + h.* (t.^2.* x + 4.* t.^2) - x;
f1EulerMod = @(x, t, t0, y, h) y + (h/ 2).* ((t0.^2.* y + 4.* t0.^2) + (t.^2.* x + 4.* t.^2)) - x;

str_FileRoot = 'Taller02_Punto01';
str_FileName = sprintf('%s_Y.txt', str_FileRoot);
s_Fil1 = fopen(str_FileName, 'wt');
fprintf(s_Fil1, 'h\tYAnalitic(N)\tYEulerFor(N)\tYEulerBack(N)\tYEulerMod(N)\tYRK2(N)\tYRK4(N)\n');

str_FileName = sprintf('%s_Err.txt', str_FileRoot);
s_Fil2 = fopen(str_FileName, 'wt');
fprintf(s_Fil2, 'h\tGEYEulerFor\tGEYEulerBack\tGEYEulerMod\tGEYRK2\tGEYRK4GE\n');

for s_HCount = 1:numel(v_H)
    
    v_T = s_T0:v_H(s_HCount):s_TN;
    
    v_YAnalitic = 6.* exp(-1/3).* exp(v_T.^3./ 3) - 4;
    v_YEulerFor = zeros(1, numel(v_T));
    v_YEulerBack = zeros(1, numel(v_T));
    v_YEulerMod = zeros(1, numel(v_T));
    v_YRK2 = zeros(1, numel(v_T));
    v_YRK4 = zeros(1, numel(v_T));
    
    v_YEulerFor(1) = s_Y0;
    v_YEulerBack(1) = s_Y0; 
    v_YEulerMod(1) = s_Y0;
    v_YRK2(1) = s_Y0;
    v_YRK4(1) = s_Y0;
    
    for s_IterCount = 2:numel(v_T)
        v_YEulerFor(s_IterCount) = v_YEulerFor(s_IterCount - 1) + ...
            v_H(s_HCount).* f1(v_T(s_IterCount - 1), v_YEulerFor(s_IterCount - 1));
        
        f_Fun = @(x) f1EulerBack(x, v_T(s_IterCount), v_YEulerBack(s_IterCount - 1), v_H(s_HCount));
        v_YEulerBack(s_IterCount) = fzero(f_Fun, v_YEulerBack(s_IterCount - 1));
%         v_YEulerBack(s_IterCount) = (v_YEulerBack(s_IterCount - 1) + ...
%             v_H(s_HCount).* 4.* v_T(s_IterCount).^2)./ (1 - v_H(s_HCount).* v_T(s_IterCount).^2);
        
        f_Fun = @(x) f1EulerMod(x, v_T(s_IterCount), v_T(s_IterCount - 1), ...
            v_YEulerMod(s_IterCount - 1), v_H(s_HCount));
        v_YEulerMod(s_IterCount) = fzero(f_Fun, v_YEulerMod(s_IterCount - 1));
%         v_YEulerMod(s_IterCount) = (v_YEulerMod(s_IterCount - 1) + ...
%             (v_H(s_HCount)./ 2).* (f1(v_T(s_IterCount - 1), v_YEulerMod(s_IterCount - 1)) + ...
%             4.* v_T(s_IterCount).^2))./ (1 - (v_H(s_HCount) / 2).* v_T(s_IterCount).^2);

        s_K1 = f1(v_T(s_IterCount - 1), v_YRK2(s_IterCount - 1));
        s_K2 = f1(v_T(s_IterCount - 1) + v_H(s_HCount), v_YRK2(s_IterCount - 1) + s_K1 * v_H(s_HCount));
        v_YRK2(s_IterCount) = v_YRK2(s_IterCount - 1) + (v_H(s_HCount) / 2).* (s_K1 + s_K2);
        
        s_K1 = f1(v_T(s_IterCount - 1), v_YRK4(s_IterCount - 1));
        s_K2 = f1(v_T(s_IterCount - 1) + 0.5.* v_H(s_HCount), v_YRK4(s_IterCount - 1) + 0.5.* s_K1 * v_H(s_HCount));
        s_K3 = f1(v_T(s_IterCount - 1) + 0.5.* v_H(s_HCount), v_YRK4(s_IterCount - 1) + 0.5.* s_K2 * v_H(s_HCount));
        s_K4 = f1(v_T(s_IterCount - 1) + v_H(s_HCount), v_YRK4(s_IterCount - 1) + s_K3 * v_H(s_HCount));
        v_YRK4(s_IterCount) = v_YRK4(s_IterCount - 1) + (v_H(s_HCount) / 6).* ...
            (s_K1 + 2 * s_K2 + 2 * s_K3 + s_K4);
    end
    
    v_YEulerForErr = abs(v_YEulerFor - v_YAnalitic);
    v_YEulerBackErr = abs(v_YEulerBack - v_YAnalitic); 
    v_YEulerModErr = abs(v_YEulerMod - v_YAnalitic);
    v_YRK2Err = abs(v_YRK2 - v_YAnalitic);
    v_YRK4Err = abs(v_YRK4 - v_YAnalitic);
    
    v_YEulerForErr = cumsum(v_YEulerForErr);
    v_YEulerBackErr = cumsum(v_YEulerBackErr); 
    v_YEulerModErr = cumsum(v_YEulerModErr);
    v_YRK2Err = cumsum(v_YRK2Err);
    v_YRK4Err = cumsum(v_YRK4Err);

    fprintf(s_Fil1, '%.04f\t%.020f\t%.020f\t%.020f\t%.020f\t%.020f\t%.020f\n', v_H(s_HCount), ...
        v_YAnalitic(end), v_YEulerFor(end), v_YEulerBack(end), v_YEulerMod(end), v_YRK2(end), v_YRK4(end));
    
    fprintf(s_Fil2, '%.04f\t%.020f\t%.020f\t%.020f\t%.020f\t%.020f\n', v_H(s_HCount), ...
        v_YEulerForErr(end), v_YEulerBackErr(end), v_YEulerModErr(end), v_YRK2Err(end), ...
        v_YRK4Err(end));

    s_Fig = figure;
    set(s_Fig, 'Color', 'w');
    plot(v_T, [v_YAnalitic(:) v_YEulerFor(:) v_YEulerBack(:) v_YEulerMod(:) v_YRK2(:) v_YRK4(:)])
    grid;
    xlabel('Time')
    ylabel('Y')
    title(sprintf('h=%.04f', v_H(s_HCount)));
    legend('YAnalitic', 'YEulerFor', 'YEulerBack', 'YEulerMod', 'YRK2', 'YRK4');
    
    str_FigName = sprintf('%s_h_%d.png', str_FileRoot, s_HCount);
    print(s_Fig, str_FigName, '-dpng');
    close(s_Fig);
end
fclose(s_Fil1);
fclose(s_Fil2);

return;

% Punto 2
% y'' - 6 y' - 7 y = 6 exp(2 t) con y(0) = 5, y'(0) = -3
% y1 = y --> y1'' - 6 y1' - 7 y1 = 6 exp(2 t)
% y1' = y2 --> y2' - 6 y2 - 7 y1 = 6 exp(2 t)
% y2' = 6 y2 + 7 y1 + 6 exp(2 t)
% y(t) = 5 exp(-t) + (2/5) exp(7 t) - (2/5) exp(2 t);

s_T0 = 0;
s_TN = 1;
s_Y10 = 5;
s_Y20 = -3;
v_H = [0.1 0.01 0.001 0.0001];
f1 = @(t, y1, y2) y2;
f2 = @(t, y1, y2) 6.* y2 + 7.* y1 + 6.* exp(2.* t);

f2EulerBack = @(x, t, y1, y2, h) y2 + h.* (6.* x + 7.* (y1 + h.* x) + 6.* exp(2.* t)) - x;
f2EulerMod = @(x, t, t0, y1, y2, h) y2 + (h/ 2).* ((6.* y2 + 7.* y1 + 6.* exp(2.* t0)) + ...
    (6.* x + 7.* (y1 + h.* x) + 6.* exp(2.* t))) - x;

str_FileRoot = 'Taller02_Punto02';
str_FileName = sprintf('%s_Y.txt', str_FileRoot);
s_Fil1 = fopen(str_FileName, 'wt');
fprintf(s_Fil1, 'h\tYAnalitic(N)\tYEulerFor(N)\tYEulerBack(N)\tYEulerMod(N)\tYRK2(N)\tYRK4(N)\n');

str_FileName = sprintf('%s_Err.txt', str_FileRoot);
s_Fil2 = fopen(str_FileName, 'wt');
fprintf(s_Fil2, 'h\tGEYEulerFor\tGEYEulerBack\tGEYEulerMod\tGEYRK2\tGEYRK4GE\n');

for s_HCount = 1:numel(v_H)
    
    v_T = s_T0:v_H(s_HCount):s_TN;
    
    v_Y1Analitic = 5.* exp(-v_T) + (2/5).* exp(7.* v_T) - (2/5).* exp(2.* v_T);
    v_Y1EulerFor = zeros(1, numel(v_T));
    v_Y1EulerBack = zeros(1, numel(v_T));
    v_Y1EulerMod = zeros(1, numel(v_T));
    v_Y1RK2 = zeros(1, numel(v_T));
    v_Y1RK4 = zeros(1, numel(v_T));
    
    v_Y2EulerFor = zeros(1, numel(v_T));
    v_Y2EulerBack = zeros(1, numel(v_T));
    v_Y2EulerMod = zeros(1, numel(v_T));
    v_Y2RK2 = zeros(1, numel(v_T));
    v_Y2RK4 = zeros(1, numel(v_T));

    v_Y1EulerFor(1) = s_Y10;
    v_Y1EulerBack(1) = s_Y10; 
    v_Y1EulerMod(1) = s_Y10;
    v_Y1RK2(1) = s_Y10;
    v_Y1RK4(1) = s_Y10;
    
    v_Y2EulerFor(1) = s_Y20;
    v_Y2EulerBack(1) = s_Y20; 
    v_Y2EulerMod(1) = s_Y20;
    v_Y2RK2(1) = s_Y20;
    v_Y2RK4(1) = s_Y20;

    for s_IterCount = 2:numel(v_T)
        v_Y1EulerFor(s_IterCount) = v_Y1EulerFor(s_IterCount - 1) + ...
            v_H(s_HCount).* f1(v_T(s_IterCount - 1), v_Y1EulerFor(s_IterCount - 1), ...
            v_Y2EulerFor(s_IterCount - 1));
        v_Y2EulerFor(s_IterCount) = v_Y2EulerFor(s_IterCount - 1) + ...
            v_H(s_HCount).* f2(v_T(s_IterCount - 1), v_Y1EulerFor(s_IterCount - 1), ...
            v_Y2EulerFor(s_IterCount - 1));
        
        f_Fun = @(x) f2EulerBack(x, v_T(s_IterCount), v_Y1EulerBack(s_IterCount - 1), ...
            v_Y2EulerBack(s_IterCount - 1), v_H(s_HCount));
        v_Y2EulerBack(s_IterCount) = fzero(f_Fun, v_Y2EulerBack(s_IterCount - 1));
        v_Y1EulerBack(s_IterCount) = v_Y1EulerBack(s_IterCount - 1) + v_H(s_HCount).* v_Y2EulerBack(s_IterCount);
        
        f_Fun = @(x) f2EulerMod(x, v_T(s_IterCount), v_T(s_IterCount - 1), ...
            v_Y1EulerMod(s_IterCount - 1), v_Y2EulerMod(s_IterCount - 1), v_H(s_HCount));
        v_Y2EulerMod(s_IterCount) = fzero(f_Fun, v_Y2EulerMod(s_IterCount - 1));
        v_Y1EulerMod(s_IterCount) = v_Y1EulerMod(s_IterCount - 1) + (v_H(s_HCount) / 2).* ...
            (v_Y2EulerMod(s_IterCount - 1) + v_Y2EulerMod(s_IterCount));

        s_K11 = f1(v_T(s_IterCount - 1), v_Y1RK2(s_IterCount - 1), v_Y2RK2(s_IterCount - 1));
        s_K21 = f2(v_T(s_IterCount - 1), v_Y1RK2(s_IterCount - 1), v_Y2RK2(s_IterCount - 1));
        s_K12 = f1(v_T(s_IterCount - 1) + v_H(s_HCount), v_Y1RK2(s_IterCount - 1) + s_K11 * v_H(s_HCount), ...
            v_Y2RK2(s_IterCount - 1) + s_K21 * v_H(s_HCount));
        s_K22 = f2(v_T(s_IterCount - 1) + v_H(s_HCount), v_Y1RK2(s_IterCount - 1) + s_K11 * v_H(s_HCount), ...
            v_Y2RK2(s_IterCount - 1) + s_K21 * v_H(s_HCount));
        v_Y1RK2(s_IterCount) = v_Y1RK2(s_IterCount - 1) + (v_H(s_HCount) / 2).* (s_K11 + s_K12);
        v_Y2RK2(s_IterCount) = v_Y2RK2(s_IterCount - 1) + (v_H(s_HCount) / 2).* (s_K21 + s_K22);
        
        s_K11 = f1(v_T(s_IterCount - 1), v_Y1RK4(s_IterCount - 1), v_Y2RK4(s_IterCount - 1));
        s_K21 = f2(v_T(s_IterCount - 1), v_Y1RK4(s_IterCount - 1), v_Y2RK4(s_IterCount - 1));
        s_K12 = f1(v_T(s_IterCount - 1) + 0.5.* v_H(s_HCount), ...
            v_Y1RK4(s_IterCount - 1) + 0.5.* s_K11 * v_H(s_HCount), ...
            v_Y2RK4(s_IterCount - 1) + 0.5.* s_K21 * v_H(s_HCount));
        s_K22 = f2(v_T(s_IterCount - 1) + 0.5.* v_H(s_HCount), ...
            v_Y1RK4(s_IterCount - 1) + 0.5.* s_K11 * v_H(s_HCount), ...
            v_Y2RK4(s_IterCount - 1) + 0.5.* s_K21 * v_H(s_HCount));
        s_K13 = f1(v_T(s_IterCount - 1) + 0.5.* v_H(s_HCount), ...
            v_Y1RK4(s_IterCount - 1) + 0.5.* s_K12 * v_H(s_HCount), ...
            v_Y2RK4(s_IterCount - 1) + 0.5.* s_K22 * v_H(s_HCount));
        s_K23 = f2(v_T(s_IterCount - 1) + 0.5.* v_H(s_HCount), ...
            v_Y1RK4(s_IterCount - 1) + 0.5.* s_K12 * v_H(s_HCount), ...
            v_Y2RK4(s_IterCount - 1) + 0.5.* s_K22 * v_H(s_HCount));
        s_K14 = f1(v_T(s_IterCount - 1) + v_H(s_HCount), ...
            v_Y1RK4(s_IterCount - 1) + s_K13 * v_H(s_HCount), ...
            v_Y2RK4(s_IterCount - 1) + s_K23 * v_H(s_HCount));
        s_K24 = f2(v_T(s_IterCount - 1) + v_H(s_HCount), ...
            v_Y1RK4(s_IterCount - 1) + s_K13 * v_H(s_HCount), ...
            v_Y2RK4(s_IterCount - 1) + s_K23 * v_H(s_HCount));
        v_Y1RK4(s_IterCount) = v_Y1RK4(s_IterCount - 1) + (v_H(s_HCount) / 6).* ...
            (s_K11 + 2 * s_K12 + 2 * s_K13 + s_K14);
        v_Y2RK4(s_IterCount) = v_Y2RK4(s_IterCount - 1) + (v_H(s_HCount) / 6).* ...
            (s_K21 + 2 * s_K22 + 2 * s_K23 + s_K24);
    end
    
    v_Y1EulerForErr = abs(v_Y1EulerFor - v_Y1Analitic);
    v_Y1EulerBackErr = abs(v_Y1EulerBack - v_Y1Analitic); 
    v_Y1EulerModErr = abs(v_Y1EulerMod - v_Y1Analitic);
    v_Y1RK2Err = abs(v_Y1RK2 - v_Y1Analitic);
    v_Y1RK4Err = abs(v_Y1RK4 - v_Y1Analitic);
    
    v_Y1EulerForErr = cumsum(v_Y1EulerForErr);
    v_Y1EulerBackErr = cumsum(v_Y1EulerBackErr); 
    v_Y1EulerModErr = cumsum(v_Y1EulerModErr);
    v_Y1RK2Err = cumsum(v_Y1RK2Err);
    v_Y1RK4Err = cumsum(v_Y1RK4Err);

    fprintf(s_Fil1, '%.04f\t%.020f\t%.020f\t%.020f\t%.020f\t%.020f\t%.020f\n', v_H(s_HCount), ...
        v_Y1Analitic(end), v_Y1EulerFor(end), v_Y1EulerBack(end), v_Y1EulerMod(end), ...
        v_Y1RK2(end), v_Y1RK4(end));
    
    fprintf(s_Fil2, '%.04f\t%.020f\t%.020f\t%.020f\t%.020f\t%.020f\n', v_H(s_HCount), ...
        v_Y1EulerForErr(end), v_Y1EulerBackErr(end), v_Y1EulerModErr(end), v_Y1RK2Err(end), ...
        v_Y1RK4Err(end));

    s_Fig = figure;
    set(s_Fig, 'Color', 'w');
    plot(v_T, [v_Y1Analitic(:) v_Y1EulerFor(:) v_Y1EulerBack(:) v_Y1EulerMod(:) v_Y1RK2(:) v_Y1RK4(:)])
    grid;
    xlabel('Time')
    ylabel('Y')
    title(sprintf('h=%.04f', v_H(s_HCount)));
    legend('YAnalitic', 'YEulerFor', 'YEulerBack', 'YEulerMod', 'YRK2', 'YRK4');
    
    str_FigName = sprintf('%s_h_%d.png', str_FileRoot, s_HCount);
    print(s_Fig, str_FigName, '-dpng');
    close(s_Fig);
end
fclose(s_Fil1);
fclose(s_Fil2);

return;

% Punto 3
% y'''' - 10 y'' + 9 y = 0 con y(0) = 5, y'(0) = -1, y''(0) = 21 y y'''(0) =
% -49
% y1 = y --> y1'''' - 10 y1'' + 9 y1 = 0
% y1' = y2 --> y2''' - 10 y2' + 9 y1 = 0
% y2' = y3 --> y3'' - 10 y3 + 9 y1 = 0
% y3' = y4 --> y4' - 10 y3 + 9 y1 = 0
% y4' = 10 y3 - 9 y1 
% y(t) = 4 exp(t) - exp(- t) + 2 exp(-3 t);

s_T0 = 0;
s_TN = 5;
s_Y10 = 5;
s_Y20 = -1;
s_Y30 = 21;
s_Y40 = -49;
v_H = [0.1 0.01 0.001 0.0001];
f1 = @(y2) y2;
f2 = @(y3) y3;
f3 = @(y4) y4;
f4 = @(y1, y3) 10.* y3 - 9.* y1;

f4EulerBack = @(x, y1, y2, y3, y4, h) y4 + h.* (10.* (y3 + h.* x) - ...
    9.* (y1 + h.* (y2 + h.* (y3 + h.* x)))) - x;
f4EulerMod = @(x, y1, y2, y3, y4, h) y4 + (h / 2).* ((10.* y3 - 9.* y1) + ...
    (10.* (y3 + h.* x) - 9.* (y1 + h.* (y2 + h.* (y3 + h.* x))))) - x;

str_FileRoot = 'Taller02_Punto03';
str_FileName = sprintf('%s_Y.txt', str_FileRoot);
s_Fil1 = fopen(str_FileName, 'wt');
fprintf(s_Fil1, 'h\tYAnalitic(N)\tYEulerFor(N)\tYEulerBack(N)\tYEulerMod(N)\tYRK2(N)\tYRK4(N)\n');

str_FileName = sprintf('%s_Err.txt', str_FileRoot);
s_Fil2 = fopen(str_FileName, 'wt');
fprintf(s_Fil2, 'h\tGEYEulerFor\tGEYEulerBack\tGEYEulerMod\tGEYRK2\tGEYRK4GE\n');

for s_HCount = 1:numel(v_H)
    
    v_T = s_T0:v_H(s_HCount):s_TN;
    
    v_Y1Analitic = 4.* exp(v_T) - exp(-v_T) + 2.* exp(-3.* v_T);
    v_Y1EulerFor = zeros(1, numel(v_T));
    v_Y1EulerBack = zeros(1, numel(v_T));
    v_Y1EulerMod = zeros(1, numel(v_T));
    v_Y1RK2 = zeros(1, numel(v_T));
    v_Y1RK4 = zeros(1, numel(v_T));
    
    v_Y2EulerFor = zeros(1, numel(v_T));
    v_Y2EulerBack = zeros(1, numel(v_T));
    v_Y2EulerMod = zeros(1, numel(v_T));
    v_Y2RK2 = zeros(1, numel(v_T));
    v_Y2RK4 = zeros(1, numel(v_T));

    v_Y3EulerFor = zeros(1, numel(v_T));
    v_Y3EulerBack = zeros(1, numel(v_T));
    v_Y3EulerMod = zeros(1, numel(v_T));
    v_Y3RK2 = zeros(1, numel(v_T));
    v_Y3RK4 = zeros(1, numel(v_T));

    v_Y4EulerFor = zeros(1, numel(v_T));
    v_Y4EulerBack = zeros(1, numel(v_T));
    v_Y4EulerMod = zeros(1, numel(v_T));
    v_Y4RK2 = zeros(1, numel(v_T));
    v_Y4RK4 = zeros(1, numel(v_T));

    v_Y1EulerFor(1) = s_Y10;
    v_Y1EulerBack(1) = s_Y10; 
    v_Y1EulerMod(1) = s_Y10;
    v_Y1RK2(1) = s_Y10;
    v_Y1RK4(1) = s_Y10;
    
    v_Y2EulerFor(1) = s_Y20;
    v_Y2EulerBack(1) = s_Y20; 
    v_Y2EulerMod(1) = s_Y20;
    v_Y2RK2(1) = s_Y20;
    v_Y2RK4(1) = s_Y20;

    v_Y3EulerFor(1) = s_Y30;
    v_Y3EulerBack(1) = s_Y30; 
    v_Y3EulerMod(1) = s_Y30;
    v_Y3RK2(1) = s_Y30;
    v_Y3RK4(1) = s_Y30;

    v_Y4EulerFor(1) = s_Y40;
    v_Y4EulerBack(1) = s_Y40; 
    v_Y4EulerMod(1) = s_Y40;
    v_Y4RK2(1) = s_Y40;
    v_Y4RK4(1) = s_Y40;

    for s_IterCount = 2:numel(v_T)
        v_Y1EulerFor(s_IterCount) = v_Y1EulerFor(s_IterCount - 1) + ...
            v_H(s_HCount).* f1(v_Y2EulerFor(s_IterCount - 1));
        v_Y2EulerFor(s_IterCount) = v_Y2EulerFor(s_IterCount - 1) + ...
            v_H(s_HCount).* f2(v_Y3EulerFor(s_IterCount - 1));
        v_Y3EulerFor(s_IterCount) = v_Y3EulerFor(s_IterCount - 1) + ...
            v_H(s_HCount).* f3(v_Y4EulerFor(s_IterCount - 1));
        v_Y4EulerFor(s_IterCount) = v_Y4EulerFor(s_IterCount - 1) + ...
            v_H(s_HCount).* f4(v_Y1EulerFor(s_IterCount - 1), v_Y3EulerFor(s_IterCount - 1));
        
        f_Fun = @(x) f4EulerBack(x, v_Y1EulerBack(s_IterCount - 1), v_Y2EulerBack(s_IterCount - 1), ...
            v_Y3EulerBack(s_IterCount - 1), v_Y4EulerBack(s_IterCount - 1), v_H(s_HCount));
        v_Y4EulerBack(s_IterCount) = fzero(f_Fun, v_Y4EulerBack(s_IterCount - 1));
        v_Y3EulerBack(s_IterCount) = v_Y3EulerBack(s_IterCount - 1) + ...
            v_H(s_HCount).* f3(v_Y4EulerFor(s_IterCount));
        v_Y2EulerBack(s_IterCount) = v_Y2EulerBack(s_IterCount - 1) + ...
            v_H(s_HCount).* f2(v_Y3EulerBack(s_IterCount));
        v_Y1EulerBack(s_IterCount) = v_Y1EulerBack(s_IterCount - 1) + ...
            v_H(s_HCount).* f1(v_Y2EulerBack(s_IterCount));
        
        f_Fun = @(x) f4EulerMod(x, v_Y1EulerMod(s_IterCount - 1), v_Y2EulerMod(s_IterCount - 1), ...
            v_Y3EulerMod(s_IterCount - 1), v_Y4EulerMod(s_IterCount - 1), v_H(s_HCount));
        v_Y4EulerMod(s_IterCount) = fzero(f_Fun, v_Y4EulerMod(s_IterCount - 1));
        v_Y3EulerMod(s_IterCount) = v_Y3EulerMod(s_IterCount - 1) + (v_H(s_HCount) / 2).* ...
            (f3(v_Y4EulerMod(s_IterCount - 1)) + f3(v_Y4EulerMod(s_IterCount)));
        v_Y2EulerMod(s_IterCount) = v_Y2EulerMod(s_IterCount - 1) + (v_H(s_HCount) / 2).* ...
            (f2(v_Y3EulerMod(s_IterCount - 1)) + f2(v_Y3EulerMod(s_IterCount)));
        v_Y1EulerMod(s_IterCount) = v_Y1EulerMod(s_IterCount - 1) + (v_H(s_HCount) / 2).* ...
            (f1(v_Y2EulerMod(s_IterCount - 1)) + f1(v_Y2EulerMod(s_IterCount)));

        s_K11 = f1(v_Y2RK2(s_IterCount - 1));
        s_K21 = f2(v_Y3RK2(s_IterCount - 1));
        s_K31 = f3(v_Y4RK2(s_IterCount - 1));
        s_K41 = f4(v_Y1RK2(s_IterCount - 1), v_Y3RK2(s_IterCount - 1));
        
        s_K12 = f1(v_Y2RK2(s_IterCount - 1) + s_K21 * v_H(s_HCount));
        s_K22 = f2(v_Y3RK2(s_IterCount - 1) + s_K31 * v_H(s_HCount));
        s_K32 = f3(v_Y4RK2(s_IterCount - 1) + s_K41 * v_H(s_HCount));
        s_K42 = f4(v_Y1RK2(s_IterCount - 1) + s_K11 * v_H(s_HCount), ...
            v_Y3RK2(s_IterCount - 1) + s_K31 * v_H(s_HCount));
        
        v_Y1RK2(s_IterCount) = v_Y1RK2(s_IterCount - 1) + (v_H(s_HCount) / 2).* (s_K11 + s_K12);
        v_Y2RK2(s_IterCount) = v_Y2RK2(s_IterCount - 1) + (v_H(s_HCount) / 2).* (s_K21 + s_K22);
        v_Y3RK2(s_IterCount) = v_Y3RK2(s_IterCount - 1) + (v_H(s_HCount) / 2).* (s_K31 + s_K32);
        v_Y4RK2(s_IterCount) = v_Y4RK2(s_IterCount - 1) + (v_H(s_HCount) / 2).* (s_K41 + s_K42);
        
        s_K11 = f1(v_Y2RK2(s_IterCount - 1));
        s_K21 = f2(v_Y3RK2(s_IterCount - 1));
        s_K31 = f3(v_Y4RK2(s_IterCount - 1));
        s_K41 = f4(v_Y1RK2(s_IterCount - 1), v_Y3RK2(s_IterCount - 1));

        s_K12 = f1(v_Y2RK4(s_IterCount - 1) + 0.5.* s_K21 * v_H(s_HCount));
        s_K22 = f2(v_Y3RK4(s_IterCount - 1) + 0.5.* s_K31 * v_H(s_HCount));
        s_K32 = f3(v_Y4RK4(s_IterCount - 1) + 0.5.* s_K41 * v_H(s_HCount));
        s_K42 = f4(v_Y1RK4(s_IterCount - 1) + 0.5.* s_K11 * v_H(s_HCount), ...
            v_Y3RK4(s_IterCount - 1) + 0.5.* s_K31 * v_H(s_HCount));
        
        s_K13 = f1(v_Y2RK4(s_IterCount - 1) + 0.5.* s_K22 * v_H(s_HCount));
        s_K23 = f2(v_Y3RK4(s_IterCount - 1) + 0.5.* s_K32 * v_H(s_HCount));
        s_K33 = f3(v_Y4RK4(s_IterCount - 1) + 0.5.* s_K42 * v_H(s_HCount));
        s_K43 = f4(v_Y1RK4(s_IterCount - 1) + 0.5.* s_K12 * v_H(s_HCount), ...
            v_Y3RK4(s_IterCount - 1) + 0.5.* s_K32 * v_H(s_HCount));
        
        s_K14 = f1(v_Y2RK4(s_IterCount - 1) + s_K23 * v_H(s_HCount));
        s_K24 = f2(v_Y3RK4(s_IterCount - 1) + s_K33 * v_H(s_HCount));
        s_K34 = f3(v_Y4RK4(s_IterCount - 1) + s_K43 * v_H(s_HCount));
        s_K44 = f4(v_Y1RK4(s_IterCount - 1) + s_K13 * v_H(s_HCount), ...
            v_Y3RK4(s_IterCount - 1) + s_K33 * v_H(s_HCount));
        
        v_Y1RK4(s_IterCount) = v_Y1RK4(s_IterCount - 1) + (v_H(s_HCount) / 6).* ...
            (s_K11 + 2 * s_K12 + 2 * s_K13 + s_K14);
        v_Y2RK4(s_IterCount) = v_Y2RK4(s_IterCount - 1) + (v_H(s_HCount) / 6).* ...
            (s_K21 + 2 * s_K22 + 2 * s_K23 + s_K24);
        v_Y3RK4(s_IterCount) = v_Y3RK4(s_IterCount - 1) + (v_H(s_HCount) / 6).* ...
            (s_K31 + 2 * s_K32 + 2 * s_K33 + s_K34);
        v_Y4RK4(s_IterCount) = v_Y4RK4(s_IterCount - 1) + (v_H(s_HCount) / 6).* ...
            (s_K41 + 2 * s_K42 + 2 * s_K43 + s_K44);
    end
    
    v_Y1EulerForErr = abs(v_Y1EulerFor - v_Y1Analitic);
    v_Y1EulerBackErr = abs(v_Y1EulerBack - v_Y1Analitic); 
    v_Y1EulerModErr = abs(v_Y1EulerMod - v_Y1Analitic);
    v_Y1RK2Err = abs(v_Y1RK2 - v_Y1Analitic);
    v_Y1RK4Err = abs(v_Y1RK4 - v_Y1Analitic);
    
    v_Y1EulerForErr = cumsum(v_Y1EulerForErr);
    v_Y1EulerBackErr = cumsum(v_Y1EulerBackErr); 
    v_Y1EulerModErr = cumsum(v_Y1EulerModErr);
    v_Y1RK2Err = cumsum(v_Y1RK2Err);
    v_Y1RK4Err = cumsum(v_Y1RK4Err);

    fprintf(s_Fil1, '%.04f\t%.020f\t%.020f\t%.020f\t%.020f\t%.020f\t%.020f\n', v_H(s_HCount), ...
        v_Y1Analitic(end), v_Y1EulerFor(end), v_Y1EulerBack(end), v_Y1EulerMod(end), ...
        v_Y1RK2(end), v_Y1RK4(end));
    
    fprintf(s_Fil2, '%.04f\t%.020f\t%.020f\t%.020f\t%.020f\t%.020f\n', v_H(s_HCount), ...
        v_Y1EulerForErr(end), v_Y1EulerBackErr(end), v_Y1EulerModErr(end), v_Y1RK2Err(end), ...
        v_Y1RK4Err(end));

    s_Fig = figure;
    set(s_Fig, 'Color', 'w');
    plot(v_T, [v_Y1Analitic(:) v_Y1EulerFor(:) v_Y1EulerBack(:) v_Y1EulerMod(:) v_Y1RK2(:) v_Y1RK4(:)])
    grid;
    xlabel('Time')
    ylabel('Y')
    title(sprintf('h=%.04f', v_H(s_HCount)));
    legend('YAnalitic', 'YEulerFor', 'YEulerBack', 'YEulerMod', 'YRK2', 'YRK4');
    
    str_FigName = sprintf('%s_h_%d.png', str_FileRoot, s_HCount);
    print(s_Fig, str_FigName, '-dpng');
    close(s_Fig);
end
fclose(s_Fil1);
fclose(s_Fil2);

return;


