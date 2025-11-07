% 测试参数解析
% 使用实际的脚本内容进行测试

% 读取default_cfar.m的内容
fid = fopen('default_cfar.m', 'r');
content = fread(fid, '*char')';
fclose(fid);

fprintf('=== 测试 default_cfar.m 参数解析 ===\n\n');
fprintf('文件内容前500个字符:\n');
fprintf('%s\n\n', content(1:min(500, length(content))));

% 使用相同的正则表达式
paramPattern = '%\s*PARAM:\s*(\w+)\s*,\s*(\w+)(?:\s*,\s*([^\n\r]+))?';
paramMatches = regexp(content, paramPattern, 'tokens');

fprintf('匹配到 %d 个参数\n\n', length(paramMatches));

for i = 1:length(paramMatches)
    fprintf('--- 参数 %d ---\n', i);
    fprintf('捕获组数量: %d\n', length(paramMatches{i}));
    fprintf('第1组 (参数名): ''%s''\n', paramMatches{i}{1});
    fprintf('第2组 (类型): ''%s''\n', paramMatches{i}{2});

    if length(paramMatches{i}) >= 3
        fprintf('第3组 (默认值) 存在\n');
        fprintf('  原始值: ''%s''\n', paramMatches{i}{3});
        fprintf('  trim后: ''%s''\n', strtrim(paramMatches{i}{3}));
        fprintf('  是否为空: %d\n', isempty(strtrim(paramMatches{i}{3})));
    else
        fprintf('第3组 (默认值) 不存在\n');
    end
    fprintf('\n');
end

fprintf('\n=== 测试 default_noncoherent_integration.m 参数解析 ===\n\n');

% 读取default_noncoherent_integration.m的内容
fid = fopen('default_noncoherent_integration.m', 'r');
content = fread(fid, '*char')';
fclose(fid);

fprintf('文件内容前500个字符:\n');
fprintf('%s\n\n', content(1:min(500, length(content))));

paramMatches = regexp(content, paramPattern, 'tokens');

fprintf('匹配到 %d 个参数\n\n', length(paramMatches));

for i = 1:length(paramMatches)
    fprintf('--- 参数 %d ---\n', i);
    fprintf('捕获组数量: %d\n', length(paramMatches{i}));
    fprintf('第1组 (参数名): ''%s''\n', paramMatches{i}{1});
    fprintf('第2组 (类型): ''%s''\n', paramMatches{i}{2});

    if length(paramMatches{i}) >= 3
        fprintf('第3组 (默认值) 存在\n');
        fprintf('  原始值: ''%s''\n', paramMatches{i}{3});
        fprintf('  trim后: ''%s''\n', strtrim(paramMatches{i}{3}));
        fprintf('  是否为空: %d\n', isempty(strtrim(paramMatches{i}{3})));
    else
        fprintf('第3组 (默认值) 不存在\n');
    end
    fprintf('\n');
end
