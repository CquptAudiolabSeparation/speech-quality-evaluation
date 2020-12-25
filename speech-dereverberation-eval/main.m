clear all
close all
sex = {'female';'male'};
loop = 1;
for A = 1:2
for C = 1:14
input_dir = ['..\new_output\1-3\SpeakerC(',sex{A},num2str(C),')_RT0.7\'];%\SimData\'
dirOutput = dir(fullfile(input_dir,'*.wav'));
file_name = {dirOutput.name};
file_name = cellfun(@(c)c(1:end-4) ,file_name,'UniformOutput',false).';

if isempty(file_name) == 1
    continue;
else
    AB(loop,:) =[A C]; 
    s_path =['..\new_input\1\RT0\SpeakerC(',sex{A},num2str(C),')_RT0.wav'];
    [s fs] = audioread(s_path);
    raw_path = ['..\new_input\1\RT0.7\SpeakerC(',sex{A},num2str(C),')_RT0.7.wav'];
    raw = audioread(raw_path);
    [Raw.cd_med(loop,1), Raw.snr_med(loop,1),Raw.srmr_mean(loop,1), Raw.pesq_mean(loop,1),Raw.stoi_mean(loop,1)] = dev_eval(s,raw,s_path,raw_path,fs);

    for i = 1:size(file_name,1)
        se_path = [input_dir,file_name{i},'.wav'];
        se = audioread(se_path);
        [Dev.cd_med(loop,i), Dev.snr_med(loop,i), Dev.srmr_mean(loop,i), Dev.pesq_mean(loop,i), Dev.stoi_mean(loop,i)] = dev_eval(s,se,s_path,se_path,fs);
    end
    loop = loop +1;
end
end
end

