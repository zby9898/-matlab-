% 测试 MATLAB regexp 对可选捕获组的行为
clear; clc;

fprintf('=== 测试 MATLAB regexp 可选捕获组 ===\n\n');

% 测试1: 有第3组
str1 = '% PARAM: threshold_factor, double, 3.0';
fprintf('测试字符串1 (有默认值): %s\n', str1);

% 测试2: 无第3组
str2 = '% PARAM: threshold_factor, double';
fprintf('测试字符串2 (无默认值): %s\n\n', str2);

% 模式1: 可选的第3组
pattern1 = '%\s*PARAM:\s*(\w+)\s*,\s*(\w+)(?:\s*,\s*(.+?))?';
fprintf('--- 模式1: 可选第3组 ---\n');
fprintf('模式: %s\n\n', pattern1);

m1 = regexp(str1, pattern1, 'tokens');
fprintf('字符串1 结果: %d 个捕获组\n', length(m1{1}));
for i = 1:length(m1{1})
    fprintf('  组%d: ''%s''\n', i, m1{1}{i});
end

m2 = regexp(str2, pattern1, 'tokens');
fprintf('\n字符串2 结果: %d 个捕获组\n', length(m2{1}));
for i = 1:length(m2{1})
    fprintf('  组%d: ''%s''\n', i, m2{1}{i});
end

% 模式2: 使用 | 或操作符
fprintf('\n\n--- 模式2: 使用OR分支 ---\n');
pattern2 = '%\s*PARAM:\s*(\w+)\s*,\s*(\w+)(?:\s*,\s*(.+)|())';
fprintf('模式: %s\n\n', pattern2);

m3 = regexp(str1, pattern2, 'tokens');
fprintf('字符串1 结果: %d 个捕获组\n', length(m3{1}));
for i = 1:length(m3{1})
    fprintf('  组%d: ''%s''\n', i, m3{1}{i});
end

m4 = regexp(str2, pattern2, 'tokens');
fprintf('\n字符串2 结果: %d 个捕获组\n', length(m4{1}));
for i = 1:length(m4{1})
    fprintf('  组%d: ''%s''\n', i, m4{1}{i});
end

% 模式3: 分两次匹配
fprintf('\n\n--- 模式3: 分别匹配 ---\n');
pattern3a = '%\s*PARAM:\s*(\w+)\s*,\s*(\w+)\s*,\s*(.+)';  % 有默认值
pattern3b = '%\s*PARAM:\s*(\w+)\s*,\s*(\w+)\s*$';         % 无默认值

fprintf('有默认值模式: %s\n', pattern3a);
fprintf('无默认值模式: %s\n\n', pattern3b);

m5 = regexp(str1, pattern3a, 'tokens');
if ~isempty(m5)
    fprintf('字符串1 (有默认值模式) 结果: %d 个捕获组\n', length(m5{1}));
    for i = 1:length(m5{1})
        fprintf('  组%d: ''%s''\n', i, m5{1}{i});
    end
else
    fprintf('字符串1 (有默认值模式) 无匹配\n');
end

m6 = regexp(str1, pattern3b, 'tokens');
if ~isempty(m6)
    fprintf('\n字符串1 (无默认值模式) 结果: %d 个捕获组\n', length(m6{1}));
else
    fprintf('\n字符串1 (无默认值模式) 无匹配\n');
end

m7 = regexp(str2, pattern3a, 'tokens');
if ~isempty(m7)
    fprintf('\n字符串2 (有默认值模式) 结果: %d 个捕获组\n', length(m7{1}));
else
    fprintf('\n字符串2 (有默认值模式) 无匹配\n');
end

m8 = regexp(str2, pattern3b, 'tokens');
if ~isempty(m8)
    fprintf('\n字符串2 (无默认值模式) 结果: %d 个捕获组\n', length(m8{1}));
    for i = 1:length(m8{1})
        fprintf('  组%d: ''%s''\n', i, m8{1}{i});
    end
else
    fprintf('\n字符串2 (无默认值模式) 无匹配\n');
end

fprintf('\n=== 结论 ===\n');
fprintf('如果模式1和2都只返回2个组，说明MATLAB的可选捕获组不会包含空匹配\n');
fprintf('此时需要使用模式3的方法，分别匹配有无默认值的情况\n');
