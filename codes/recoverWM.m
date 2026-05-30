function [WMr, CC, NCC, COR, T] = recoverWM(Iwm, WM0, N, wname, Key)


    L = 2^N; % Finding level
    Iwm = double(Iwm);

    [Mw, Nw] = size(Iwm); % Determine size of watermarked IMAGE
    [Mwm0, Nwm0] = size(WM0); % Determine the size of watermark

    wmvectorr = ones(1, Mwm0*Nwm0); % Initialize message to ALL ones

    [C2, S2] = wavedec2(Iwm, N, wname); % DWT
    cD2 = detcoef2('d', C2, S2, N); % Extracting cDs

    rng(Key); % Reset PN generator to state "key"
    pnsequence = round(2 * (rand(Mw/L, Nw/L) - 0.5)); % Generate PRN Sequence
    
    COR=zeros(size(wmvectorr));
    % Getting the correlation between PRN sequences and cDs
    for i = 1:length(wmvectorr)
        COR(i) = corr2(cD2, pnsequence);
        pnsequence = round(2 * (rand(Mw/L, Nw/L) - 0.5));
    end

    T = mean(COR); T = 1.5 * T; % Finding Threshold for WM recovery

    for i = 1:length(wmvectorr)
        if COR(i) > T % Comparing correlation with Threshold
            wmvectorr(i) = 0;
        end
    end

    WMr = reshape(wmvectorr, Mwm0, Nwm0); % Recover Watermark

    % Finding Simple Correlation Coefficient (CC)
    CC = corr2(WM0, WMr);

    % Finding Normalized Correlation Coefficient (NCC)
    NCC = sum(sum(WM0 .* WMr)) / (sqrt(sum(WM0(:).^2)) * sqrt(sum(WMr(:).^2)));
end
