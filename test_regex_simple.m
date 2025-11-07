% 简单的正则测试
testLine = '%% PARAM: integration_number, int, 4';

fprintf('测试字符串: ''%s''\n\n', testLine);

% 当前使用的正则
paramPattern = '%\s*PARAM:\s*(\w+)\s*,\s*(\w+)(?:\s*,\s*([^\n\r]+))?';

matches = regexp(testLine, paramPattern, 'tokens');

if isempty(matches)
    fprintf('没有匹配到任何内容！\n');
else
    fprintf('匹配成功！捕获组数量: %d\n', length(matches{1}));
    for i = 1:length(matches{1})
        fprintf('第%d组: ''%s''\n', i, matches{1}{i});
    end
end

fprintf('\n--- 测试修改后的正则（支持%%） ---\n');
% 修改为支持 %% 或 %
paramPattern2 = '%%?\s*PARAM:\s*(\w+)\s*,\s*(\w+)(?:\s*,\s*([^\n\r]+))?';

matches2 = regexp(testLine, paramPattern2, 'tokens');

if isempty(matches2)
    fprintf('没有匹配到任何内容！\n');
else
    fprintf('匹配成功！捕获组数量: %d\n', length(matches2{1}));
    for i = 1:length(matches2{1})
        fprintf('第%d组: ''%s''\n', i, matches2{1}{i});
    end
end
