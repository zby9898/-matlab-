% 直接测试正则表达式
clear; clc;

% 直接从文件读取
fprintf('=== 测试 default_cfar.m ===\n');
fid = fopen('default_cfar.m', 'r');
content = fread(fid, '*char')';
fclose(fid);

% 找到 PARAM 行
lines = strsplit(content, '\n');
paramLines = {};
for i = 1:length(lines)
    if contains(lines{i}, 'PARAM:')
        paramLines{end+1} = lines{i};
    end
end

fprintf('找到 %d 行包含 PARAM:\n', length(paramLines));
for i = 1:length(paramLines)
    fprintf('  行 %d: %s\n', i, paramLines{i});
end

fprintf('\n=== 测试不同的正则模式 ===\n\n');

testLine = paramLines{1};  % 取第一行测试
fprintf('测试行: ''%s''\n\n', testLine);

% 测试多个模式
patterns = {
    '%%?\s*PARAM:\s*(\w+)\s*,\s*(\w+)(?:\s*,\s*(.+?))?(?:\r?\n|$)', '当前模式';
    '%%?\s*PARAM:\s*(\w+)\s*,\s*(\w+)(?:\s*,\s*(.+))?', '模式2: .+ 贪婪';
    '%%?\s*PARAM:\s*(\w+)\s*,\s*(\w+)\s*,\s*(.+)', '模式3: 强制第3组';
    '%%?\s*PARAM:\s*([^,]+)\s*,\s*([^,]+)\s*,\s*(.+)', '模式4: [^,]+ 匹配';
    '%%?\s*PARAM:\s*(\w+)\s*,\s*(\w+)(?:\s*,\s*([^\s]+))?', '模式5: [^\s]+ 非空格';
    '%%?\s*PARAM:\s*(\w+)\s*,\s*(\w+),\s*(.+)', '模式6: 简化逗号';
};

for i = 1:size(patterns, 1)
    pattern = patterns{i, 1};
    desc = patterns{i, 2};

    fprintf('--- %s ---\n', desc);
    fprintf('模式: %s\n', pattern);

    try
        matches = regexp(testLine, pattern, 'tokens');

        if isempty(matches)
            fprintf('结果: 无匹配\n\n');
        else
            fprintf('结果: 匹配成功！捕获组数: %d\n', length(matches{1}));
            for j = 1:length(matches{1})
                fprintf('  组%d: ''%s''\n', j, matches{1}{j});
            end
            fprintf('\n');
        end
    catch ME
        fprintf('错误: %s\n\n', ME.message);
    end
end

fprintf('\n=== 测试完整文件匹配 ===\n');
% 使用最简单的强制第3组模式
pattern = '%\s*PARAM:\s*(\w+)\s*,\s*(\w+)\s*,\s*(.+)';
matches = regexp(content, pattern, 'tokens', 'lineanchors');

fprintf('使用强制第3组模式，匹配到 %d 个参数\n', length(matches));
for i = 1:min(3, length(matches))
    fprintf('参数 %d: 名称=%s, 类型=%s, 默认值=%s\n', ...
        i, matches{i}{1}, matches{i}{2}, matches{i}{3});
end
