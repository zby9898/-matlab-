% 测试 MATLAB 中复数的类型判断
clear; clc;

fprintf('=== MATLAB 复数类型测试 ===\n\n');

% 创建不同类型的数据
real_double = 3.14;
complex_double = 3 + 4i;
real_single = single(3.14);
complex_single = single(3 + 4i);
real_array = [1, 2, 3];
complex_array = [1+2i, 3+4i, 5+6i];

fprintf('--- 1. class() 函数测试 ---\n');
fprintf('real_double (3.14) 的 class: %s\n', class(real_double));
fprintf('complex_double (3+4i) 的 class: %s\n', class(complex_double));
fprintf('real_single 的 class: %s\n', class(real_single));
fprintf('complex_single 的 class: %s\n', class(complex_single));
fprintf('complex_array 的 class: %s\n', class(complex_array));

fprintf('\n--- 2. isreal() 函数测试 ---\n');
fprintf('real_double 是实数吗? %d\n', isreal(real_double));
fprintf('complex_double 是实数吗? %d\n', isreal(complex_double));
fprintf('complex_array 是实数吗? %d\n', isreal(complex_array));

fprintf('\n--- 3. isnumeric() 函数测试 ---\n');
fprintf('real_double 是数值吗? %d\n', isnumeric(real_double));
fprintf('complex_double 是数值吗? %d\n', isnumeric(complex_double));
fprintf('complex_array 是数值吗? %d\n', isnumeric(complex_array));

fprintf('\n--- 4. 特殊情况：虚部为0的复数 ---\n');
complex_with_zero_imag = complex(5, 0);  % 5+0i
fprintf('complex(5, 0) 的值: %s\n', mat2str(complex_with_zero_imag));
fprintf('class: %s\n', class(complex_with_zero_imag));
fprintf('isreal: %d\n', isreal(complex_with_zero_imag));

fprintf('\n--- 5. real() 和 imag() 提取 ---\n');
fprintf('complex_double = 3+4i\n');
fprintf('  real(complex_double) = %g\n', real(complex_double));
fprintf('  imag(complex_double) = %g\n', imag(complex_double));

fprintf('\n--- 6. 类型转换测试 ---\n');
converted = complex(complex_double);
fprintf('complex(3+4i) 的 class: %s\n', class(converted));
fprintf('complex(3+4i) 的值: %s\n', mat2str(converted));

converted2 = double(complex_double);
fprintf('double(3+4i) 的 class: %s\n', class(converted2));
fprintf('double(3+4i) 的值: %s\n', mat2str(converted2));

fprintf('\n--- 7. whos 命令显示 ---\n');
whos real_double complex_double complex_array

fprintf('\n=== 结论 ===\n');
fprintf('1. class(复数) 返回 "double" 或 "single"，不是 "complex"\n');
fprintf('2. "complex" 只是一个属性标记，表示数据有非零虚部\n');
fprintf('3. isreal() 用于判断是否为实数（虚部是否全为0）\n');
fprintf('4. isnumeric() 对实数和复数都返回 true\n');
