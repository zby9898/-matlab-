function output_data = preprocessing_advanced(input_data, params)
% PREPROCESSING_ADVANCED 高级预处理脚本（测试struct参数和帧信息传参）
%
% 脚本接口规范：
% 输入：
%   input_data - 输入的复数矩阵或向量
%   params     - 参数结构体，包含所有配置的参数
%
% 输出：
%   output_data - 处理后的复数矩阵或向量
%
% 参数定义（工具自动检测用，不含默认值）：
% PARAM: threshold, double
% PARAM: scale_factor, double
% PARAM: filter_config, struct
% PARAM: range_bins, int
% PARAM: doppler_bins, int
% PARAM: processing_mode, string

% 获取参数（工具保证参数已配置，无需默认值）
threshold = params.threshold;
scale_factor = params.scale_factor;
filter_config = params.filter_config;
range_bins = params.range_bins;
doppler_bins = params.doppler_bins;
processing_mode = params.processing_mode;

% 初始化输出
output_data = input_data;

fprintf('\n========== 预处理脚本执行开始 ==========\n');
fprintf('输入数据维度: %s\n', mat2str(size(input_data)));
fprintf('参数配置:\n');
fprintf('  threshold: %.3f\n', threshold);
fprintf('  scale_factor: %.2f\n', scale_factor);
fprintf('  range_bins: %d\n', range_bins);
fprintf('  doppler_bins: %d\n', doppler_bins);
fprintf('  processing_mode: %s\n', processing_mode);
fprintf('  filter_config: type=%s, size=%d, sigma=%.2f\n', ...
    filter_config.type, filter_config.size, filter_config.sigma);

% 步骤1：根据filter_config进行滤波
fprintf('\n步骤1: 应用滤波器 (%s)\n', filter_config.type);
if ~isvector(output_data)
    switch filter_config.type
        case 'gaussian'
            h = fspecial('gaussian', filter_config.size, filter_config.sigma);
        case 'average'
            h = fspecial('average', filter_config.size);
        case 'median'
            % 中值滤波特殊处理
            amplitude = abs(output_data);
            phase = angle(output_data);
            filtered_amp = medfilt2(amplitude, [filter_config.size, filter_config.size]);
            output_data = filtered_amp .* exp(1i * phase);
            fprintf('  应用中值滤波完成\n');
            h = [];
        otherwise
            h = [];
            fprintf('  未知滤波类型，跳过滤波\n');
    end
    
    if ~isempty(h)
        amplitude = abs(output_data);
        phase = angle(output_data);
        filtered_amp = imfilter(amplitude, h, 'replicate');
        output_data = filtered_amp .* exp(1i * phase);
        fprintf('  %s滤波完成\n', filter_config.type);
    end
end

% 步骤2：幅度缩放
fprintf('\n步骤2: 幅度缩放 (factor=%.2f)\n', scale_factor);
amplitude = abs(output_data);
phase = angle(output_data);
scaled_amplitude = amplitude * scale_factor;
output_data = scaled_amplitude .* exp(1i * phase);

% 步骤3：门限处理
fprintf('\n步骤3: 门限处理 (threshold=%.3f)\n', threshold);
amplitude = abs(output_data);
max_amp = max(amplitude(:));
threshold_value = threshold * max_amp;
mask = amplitude > threshold_value;
detected_pixels = sum(mask(:));
output_data = output_data .* mask;
fprintf('  最大幅度: %.2f\n', max_amp);
fprintf('  门限值: %.2f\n', threshold_value);
fprintf('  检测到的像素数: %d (%.1f%%)\n', detected_pixels, ...
    100 * detected_pixels / numel(mask));

% 步骤4：根据processing_mode进行额外处理
fprintf('\n步骤4: 模式相关处理 (%s)\n', processing_mode);
switch processing_mode
    case 'enhanced'
        % 增强模式：对比度拉伸
        amplitude = abs(output_data);
        min_amp = min(amplitude(amplitude > 0));
        max_amp = max(amplitude(:));
        if max_amp > min_amp
            normalized = (amplitude - min_amp) / (max_amp - min_amp);
            output_data = normalized .* exp(1i * angle(output_data));
            fprintf('  应用对比度增强\n');
        end
        
    case 'compressed'
        % 压缩模式：对数压缩
        amplitude = abs(output_data);
        log_amp = log10(amplitude + 1);
        output_data = log_amp .* exp(1i * angle(output_data));
        fprintf('  应用对数压缩\n');
        
    case 'standard'
        fprintf('  标准模式，无额外处理\n');
        
    otherwise
        fprintf('  未知模式，跳过\n');
end

fprintf('\n输出数据维度: %s\n', mat2str(size(output_data)));
fprintf('========== 预处理脚本执行完成 ==========\n\n');

end