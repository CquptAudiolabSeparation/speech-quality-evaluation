function [cd_med, snr_med,srmr_mean, pesq_mean,stoi_mean] = dev_eval(s,se,s_path,se_path,fs)
%% EVAL_PARAM 
%Cepstral distance
param_cd = struct('frame' , 0.025   , ...
    'shift' , 0.01    , ...
    'window', @hanning, ...
    'order' , 24      , ...
    'timdif', 0.0     , ...
    'cmn'   , 'y');
% Frequency-weighted segmental SNR
param_fwsegsnr = struct('frame'  , 0.025, ...
    'shift'  , 0.01, ...
    'window' , @hanning, ...
    'numband', 23);
%% EVAL
    %Cepstral distance
    [~, cd_med, ~] = cepsdist_unsync(s, se, fs, param_cd);
    %SNR
    [~, snr_med] = fwsegsnr(se, s, fs, param_fwsegsnr);

    %SRMR
    srmr_mean = SRMR_main(se_path);
    %PESQ
    pesq_mean = pesq(s_path,se_path);
    %STOI
    stoi_mean = stoi(s, se, fs);
end
