% 测试 MATLAB 图像显示函数对复数的处理
clear; clc; close all;

fprintf('=== MATLAB 图像显示函数对复数矩阵的行为测试 ===\n\n');

% 创建测试数据
real_matrix = randn(50, 50);
complex_matrix = randn(50, 50) + 1i*randn(50, 50);

fprintf('测试数据:\n');
fprintf('  real_matrix: %s, isreal=%d\n', class(real_matrix), isreal(real_matrix));
fprintf('  complex_matrix: %s, isreal=%d\n', class(complex_matrix), isreal(complex_matrix));

%% ========== 测试 1: imagesc() ==========
fprintf('\n--- 测试 1: imagesc(复数矩阵) ---\n');
try
    figure('Name', 'Test imagesc with complex');
    subplot(1,2,1);
    imagesc(real_matrix);
    title('imagesc(实数矩阵) ✅');
    colorbar;

    subplot(1,2,2);
    imagesc(complex_matrix);
    title('imagesc(复数矩阵) ???');
    colorbar;

    fprintf('结果: imagesc 接受复数矩阵，但只显示实部！\n');
    fprintf('      虚部被完全忽略，数据丢失 ❌\n');
catch ME
    fprintf('错误: %s\n', ME.message);
end

%% ========== 测试 2: imshow() ==========
fprintf('\n--- 测试 2: imshow(复数矩阵) ---\n');
try
    figure('Name', 'Test imshow with complex');
    subplot(1,2,1);
    imshow(mat2gray(real_matrix));
    title('imshow(实数矩阵) ✅');

    subplot(1,2,2);
    imshow(mat2gray(complex_matrix));  % mat2gray 会出错
    title('imshow(复数矩阵) ???');

    fprintf('结果: 成功\n');
catch ME
    fprintf('错误: %s\n', ME.message);
    fprintf('结论: mat2gray() 不支持复数矩阵 ❌\n');
end

%% ========== 测试 3: mesh() ==========
fprintf('\n--- 测试 3: mesh(复数矩阵) ---\n');
try
    figure('Name', 'Test mesh with complex');
    subplot(1,2,1);
    mesh(real_matrix);
    title('mesh(实数矩阵) ✅');

    subplot(1,2,2);
    mesh(complex_matrix);
    title('mesh(复数矩阵) ???');

    fprintf('结果: mesh 接受复数矩阵，但只显示实部！\n');
    fprintf('      虚部被完全忽略，数据丢失 ❌\n');
catch ME
    fprintf('错误: %s\n', ME.message);
end

%% ========== 测试 4: surf() ==========
fprintf('\n--- 测试 4: surf(复数矩阵) ---\n');
try
    figure('Name', 'Test surf with complex');
    subplot(1,2,1);
    surf(real_matrix);
    title('surf(实数矩阵) ✅');
    shading interp;

    subplot(1,2,2);
    surf(complex_matrix);
    title('surf(复数矩阵) ???');
    shading interp;

    fprintf('结果: surf 接受复数矩阵，但只显示实部！\n');
    fprintf('      虚部被完全忽略，数据丢失 ❌\n');
catch ME
    fprintf('错误: %s\n', ME.message);
end

%% ========== 测试 5: plot() (向量) ==========
fprintf('\n--- 测试 5: plot(复数向量) ---\n');
real_vector = randn(100, 1);
complex_vector = randn(100, 1) + 1i*randn(100, 1);

try
    figure('Name', 'Test plot with complex');
    subplot(2,1,1);
    plot(real_vector);
    title('plot(实数向量) ✅');

    subplot(2,1,2);
    plot(complex_vector);
    title('plot(复数向量) ???');

    fprintf('结果: plot 接受复数向量，但只显示实部！\n');
    fprintf('      虚部被完全忽略，数据丢失 ❌\n');
    fprintf('      正确做法: 分别 plot(real(z)) 和 plot(imag(z))\n');
catch ME
    fprintf('错误: %s\n', ME.message);
end

%% ========== 总结 ==========
fprintf('\n=== 总结 ===\n');
fprintf('1. imagesc/mesh/surf/plot 都"接受"复数输入（不报错）\n');
fprintf('2. 但它们只使用实部，虚部被丢弃 ❌\n');
fprintf('3. mat2gray/imshow 组合不支持复数（会报错）❌\n');
fprintf('4. 正确做法:\n');
fprintf('   - 矩阵: 使用 abs(复数) 显示幅值 ✅\n');
fprintf('   - 向量: 分别显示 real(), imag(), abs() ✅\n');

fprintf('\n=== 为什么只显示实部会有问题？===\n');
fprintf('示例: z = 3 + 4i\n');
fprintf('  只显示 real(z) = 3   → 丢失虚部信息 ❌\n');
fprintf('  显示 abs(z) = 5      → 完整的幅值信息 ✅\n');
fprintf('对于雷达/SAR应用，幅值 = 能量，实部没有完整的物理意义\n');
