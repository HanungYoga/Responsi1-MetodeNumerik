%Hanung Yoga Adi Pramono_L0325026
clc; clear; close all;

lambda = 12; v = 36; x = 10; h0 = 5;
t = 0:0.01:5;
z = t*v/lambda;
N = [23 24 25];

h_eksak = h0*(cos(z) + exp(x));

h_pend = zeros(length(N), length(t));
for i = 1:length(N)
  n = N(i);
  cos_pend = zeros(size(t));
  exp_pend = 0;
  for k = 0:n
    cos_pend = cos_pend + (-1)^k * z.^(2*k) / factorial(2*k);
    exp_pend = exp_pend + x^k / factorial(k);
  end
  h_pend(i,:) = h0*(cos_pend + exp_pend);
end

galat_abs = abs(repmat(h_eksak, length(N), 1) - h_pend);
galat_rel = galat_abs ./ abs(repmat(h_eksak, length(N), 1)) * 100;

figure(1);
plot(t, h_eksak, 'k-', 'LineWidth', 2); hold on;
plot(t, h_pend(1,:), 'r--', 'LineWidth', 1.5);
plot(t, h_pend(2,:), 'g-.', 'LineWidth', 1.5);
plot(t, h_pend(3,:), 'b:', 'LineWidth', 1.5);
xlabel('t'); ylabel('h(t)');
title('Perbandingan h(t) eksak dan pendekatan');
legend('f eksak', 'f n=23', 'f n=24', 'f n=25', 'Location', 'best');
grid on;
print('-dpng', 'kasus1_grafik.png');

figure(2);
semilogy(t, galat_abs(1,:)+eps, 'r--', t, galat_abs(2,:)+eps, 'g-.', t, galat_abs(3,:)+eps, 'b:', 'LineWidth', 1.5);
xlabel('t'); ylabel('galat mutlak');
title('Galat mutlak terhadap nilai eksak');
legend('n=23', 'n=24', 'n=25', 'Location', 'best');
grid on;
print('-dpng', 'kasus1_galat.png');

toleransi = 1;
disp('Rerata galat mutlak dan galat relatif:');
for i = 1:length(N)
  rerata_abs = mean(galat_abs(i,:));
  rerata_rel = mean(galat_rel(i,:));
  if rerata_rel < toleransi
    status = 'LAYAK';
  else
    status = 'TIDAK LAYAK';
  end
  fprintf('n = %d : rerata galat mutlak = %.6e | rerata galat relatif = %.6e %% | %s\n', N(i), rerata_abs, rerata_rel, status);
end
