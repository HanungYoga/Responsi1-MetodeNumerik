%Hanung Yoga Adi Pramono_L0325026
clc; clear; close all;

f = @(r) (4/3)*pi*r.^3 - 300;

r = 0:0.1:8;
figure(1);
plot(r, f(r), 'b-', 'LineWidth', 2); hold on;
plot([0 8], [0 0], 'k-');
xlabel('r (cm)'); ylabel('f(r)');
title('Grafik f(r) = (4/3)\pi r^3 - 300');
grid on;
print('-dpng', 'kasus3_grafik.png');

a = 4; b = 5;
fprintf('f(a) = %.4f, f(b) = %.4f\n', f(a), f(b));
if f(a)*f(b) > 0
  error('Tidak ada akar pada interval [a,b]');
end

tol = 0.0001; maxit = 50;

fprintf('\n%4s %10s %10s %10s %12s %12s\n', 'iter', 'a', 'b', 'c', 'f(c)', '|b-a|');
for i = 1:maxit
  c = (a + b)/2;
  fprintf('%4d %10.6f %10.6f %10.6f %12.6f %12.6f\n', i, a, b, c, f(c), abs(b-a));
  if f(c) == 0 || abs(b-a)/2 < tol
    break;
  end
  if f(a)*f(c) < 0
    b = c;
  else
    a = c;
  end
end

r_akar = c;
fprintf('\nJari-jari bola = jari-jari tabung = %.6f cm\n', r_akar);

t_tabung = 2*r_akar;
V_bola = (4/3)*pi*r_akar^3;
V_tabung = pi*r_akar^2*t_tabung;
V_luar = V_tabung - V_bola;
fprintf('Tinggi tabung = %.6f cm\n', t_tabung);
fprintf('Volume bola = %.6f cm^3\n', V_bola);
fprintf('Volume tabung = %.6f cm^3\n', V_tabung);
fprintf('Volume tabung di luar bola = %.6f cm^3\n', V_luar);
fprintf('Cek dengan rumus V = 2/3*pi*r^3 = %.6f cm^3\n', (2/3)*pi*r_akar^3);
