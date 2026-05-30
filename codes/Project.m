clear;
clc;

K1=2; %Embedding strength for Y plane
K2=4; %Embedding strength for Cb plane
waveletype='db40'; %Wavelet Type
N=1; %Decomposition level(s)

[filename1,pathname1]=uigetfile('*.*','Select the CoverImage');
coverimage=imread(num2str(filename1));

[filename2,pathname2]=uigetfile('*.*','Select the FIRST Watermark Image');
WM01=imread(num2str(filename2));

[filename3,pathname3]=uigetfile('*.*','Select the Second Watermark Image');
WM02=imread(num2str(filename3));

YCbCr=rgb2ycbcr(coverimage); %RGB to YCbCr conversion
Y=YCbCr(:,:,1); Cb=YCbCr(:,:,2); Cr=YCbCr(:,:,3); %Extracting Y and Cr planes

%-----------------Watermark Embedding in Y and Cr--------------------

key1=2254; %Defining KEY for Y
key2=5765; %Defining KEY for Cb
[watermarked_Y, PSNRY] = embedWM(Y, WM01, N, waveletype, K1, key1);
[watermarked_Cb, PSNRCb] = embedWM(Cb, WM02, N, waveletype, K2, key2);

fprintf('\nPSNR for Y = %f\n', PSNRY);
fprintf('\nPSNR for Cb = %f\n', PSNRCb);

watermarked_ycbcr = cat(3, watermarked_Y, watermarked_Cb, Cr);
watermarked_image_rgb = uint8(ycbcr2rgb(watermarked_ycbcr));

%-----------------Attacks--------------------

% watermarked_image_rgb=imnoise(watermarked_image_rgb, 'salt & pepper', 0.18);
% watermarked_image_rgb=imnoise(watermarked_image_rgb, 'gaussian', 0, 0.14);
% watermarked_image_rgb(1:480, 1:512, 1)=0; %cropping
% watermarked_image_rgb(1:480, 1:512, 2)=0;
% watermarked_image_rgb(1:480, 1:512, 3)=0;
% watermarked_image_rgb=imadjust(watermarked_image_rgb, [0.4 .5 0; .6 .7 1], []);
% mask=fspecial('average', [5 5]);
% mask=[-1 -1 -1;-1 9 -1;-1 -1 -1];
% watermarked_image_rgb=imfilter(watermarked_image_rgb, mask);
% watermarked_image_rgb=histeq(watermarked_image_rgb);
% imwrite(watermarked_image_rgb, 'dwt_watermarked.jpg', 'quality', 98);
% filename4='dwt_watermarked.jpg';

imwrite(watermarked_image_rgb, 'dwt_watermarked.bmp');
filename4='dwt_watermarked.bmp';

figure(1)
subplot(121)
imshow(coverimage); title('Cover Image')
subplot(122)
imshow(watermarked_image_rgb); title('Watermarked Image')

%-----------------Watermark Recovery--------------------

watermarked_image=imread(filename4);
YCbCr=rgb2ycbcr(watermarked_image);
Yr=YCbCr(:,:,1); Cbr=YCbCr(:,:,2);

[WM1, CC1, NCC1, COR1, T1] = recoverWM(Yr, WM01, N, waveletype, key1);
[WM2, CC2, NCC2, COR2, T2] = recoverWM(Cbr, WM02, N, waveletype, key2);

fprintf('\nCC between Original and Recovered Watermark 1 = %f\n', CC1);
fprintf('\nNCC between Original and Recovered Watermark 1 = %f\n', NCC1);
fprintf('\nCC between Original and Recovered Watermark 2 = %f\n', CC2);
fprintf('\nNCC between Original and Recovered Watermark 2 = %f\n', NCC2);

Tvec1=T1*ones(1,length(COR1));
Tvec2=T2*ones(1,length(COR2));

figure(2)
subplot(121)
imshow(WM1); title('Recovered Watermark 1')
subplot(122)
imshow(WM2); title('Recovered Watermark 2')

figure(3)
subplot(121)
plot(COR1); hold on;
plot(Tvec1);
title('Correlation Pattern 1');
hold off
subplot(122)
plot(COR2); hold on;
plot(Tvec2);
title('Correlation Pattern 2');
hold off