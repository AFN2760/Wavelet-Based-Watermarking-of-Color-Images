function [Iwm, PSNR] = embedWM(I, WM0, N, wname, K, Key)

    I = double(I);
    L = 2^N; % Dimension reduction by L at level N
    [Mc, Nc] = size(I); % Determine the size of cover IMAGE
    [Mwm0, Nwm0] = size(WM0); % Determine the size of watermark

    wmvector = reshape(WM0, Mwm0*Nwm0, 1);
    rng(Key); % Reset PN generator to state "key"
    pnsequence = round(2 * (rand(Mc/L, Nc/L) - 0.5)); % Generate PRN Sequence

    dwtmode('per') % Setting Wavelet Decomposition Mode
    [C1, S1] = wavedec2(I, N, wname); % DWT of IMAGE

    cA1 = appcoef2(C1, S1, wname, N);
    [cH1, cV1, cD1] = detcoef2('all', C1, S1, N);

    % Adding PRN sequence to cD1 components when watermark bit = 0
    for i = 1:length(wmvector)
        if wmvector(i) == 0
            cD1 = cD1 + K * pnsequence;
        end
        pnsequence = round(2 * (rand(Mc/L, Nc/L) - 0.5));
    end

    x = size(cA1, 1); y = size(cA1, 2);
    cA1row = reshape(cA1, 1, x*y); cH1row = reshape(cH1, 1, x*y);
    cV1row = reshape(cV1, 1, x*y); cD1row = reshape(cD1, 1, x*y);
    cc = [cA1row, cH1row, cV1row, cD1row];
    ccl = length(cc); C1(1:ccl) = cc;

    Iwm = waverec2(C1, S1, wname); % IDWT

    % Calculate PSNR
    mse = sum(sum((Iwm - I).^2)) / (Mc * Nc);
    maxp = max(max(Iwm(:)), max(I(:)));
    PSNR = 10 * log10((maxp^2) / mse);
end