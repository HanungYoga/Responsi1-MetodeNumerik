%Hanung Yoga Adi Pramono_L0325026
clc; clear; close all;

A = [2.5  1.5   5   0.5;
     4    0.75  1   2;
     2    1.5   0.5 6;
     1    4.25  2   0.9];
b = [161000; 149000; 251500; 173000];

diag_A = abs(diag(A));
sisa = sum(abs(A), 2) - diag_A;
disp('Dominan diagonal per baris (|aii| > jumlah |aij|)?');
disp([diag_A sisa diag_A > sisa]);

D = diag(diag(A)); L = tril(A, -1); U = triu(A, 1);
T = -(D + L) \ U;
rho = max(abs(eig(T)));
fprintf('Spectral radius Gauss-Seidel = %.4f\n', rho);
if rho < 1
  disp('Konvergen: boleh memakai Gauss-Seidel');
else
  disp('Tidak konvergen: gunakan metode langsung (Gauss-Jordan)');
end

fprintf('det(A) = %.4f\n', det(A));

n = length(b);
Ab = [A b];
for i = 1:n
  [~, p] = max(abs(Ab(i:n, i)));
  p = p + i - 1;
  Ab([i p], :) = Ab([p i], :);
  Ab(i,:) = Ab(i,:) / Ab(i,i);
  for j = 1:n
    if j ~= i
      Ab(j,:) = Ab(j,:) - Ab(j,i) * Ab(i,:);
    end
  end
end

x = Ab(:, end);
nama = {'Beras', 'Telur', 'Tepung', 'Ayam'};
disp('Harga per kilogram:');
for i = 1:n
  fprintf('%-7s = Rp %12.2f\n', nama{i}, x(i));
end

disp('Verifikasi residu A*x - b:');
disp(A*x - b);
