% 测试不同的正则表达式变体
testLine1 = '% PARAM: threshold_factor, double, 3.0';
testLine2 = '%% PARAM: integration_number, int, 4';

fprintf('=== 测试不同的正则表达式模式 ===\n\n');

% 测试不同的模式
patterns = {
    '%\s*PARAM:\s*(\w+)\s*,\s*(\w+)(?:\s*,\s*([^\n\r]+))?', '当前模式（[^\n\r]+）';
    '%%?\s*PARAM:\s*(\w+)\s*,\s*(\w+)(?:\s*,\s*([\d\w\.\s\-]+))?', '改进1（[\d\w\.\s\-]+）';
    '%%?\s*PARAM:\s*(\w+)\s*,\s*(\w+)(?:\s*,\s*(.+?))?$', '改进2（.+?结尾）';
    '%%?\s*PARAM:\s*(\w+)\s*,\s*(\w+)(?:\s*,\s*(.+))?', '改进3（.+贪婪）';
    '%%?\s*PARAM:\s*(\w+)\s*,\s*(\w+)\s*(?:,\s*(.*))?', '改进4（.*且明确空格）';
};

for testNum = 1:2
    if testNum == 1
        testLine = testLine1;
        fprintf('【测试行 1】: ''%s''\n\n', testLine);
    else
        testLine = testLine2;
        fprintf('\n【测试行 2】: ''%s''\n\n', testLine);
    end

    for i = 1:size(patterns, 1)
        pattern = patterns{i, 1};
        desc = patterns{i, 2};

        fprintf('模式 %d: %s\n', i, desc);

        try
            matches = regexp(testLine, pattern, 'tokens');

            if isempty(matches)
                fprintf('  结果: 无匹配\n\n');
            else
                fprintf('  结果: 成功！捕获组数量 = %d\n', length(matches{1}));
                for j = 1:length(matches{1})
                    fprintf('    第%d组: ''%s''\n', j, matches{1}{j});
                end
                fprintf('\n');
            end
        catch ME
            fprintf('  错误: %s\n\n', ME.message);
        end
    end
end

fprintf('\n=== 测试完成 ===\n');
