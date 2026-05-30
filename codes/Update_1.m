clear all;
clc;

%file selection
[filename1,pathname1]=uigetfile('*.*','Select the CoverImage');
coverimage=imread(num2str(filename1));

[filename2,pathname2]=uigetfile('*.*','Select the FIRST Watermark Image');
WM01=imread(num2str(filename2));

[filename3,pathname3]=uigetfile('*.*','Select the Second Watermark Image');
WM02=imread(num2str(filename3));

%RGB_to_YCbCr
YCbCr=rgb2ycbcr(coverimage);
Y=YCbCr(:,:,1); 
Cb=YCbCr(:,:,2); 
Cr=YCbCr(:,:,3);

%applying embedding function
K1=2;
K2=4;
waveletype='db40';
N=1; 
key1=2254; 
key2=5765; 
[watermarked_Y, PSNRY] = embedWM(Y, WM01, N, waveletype, K1, key1);
[watermarked_Cb, PSNRCb] = embedWM(Cb, WM02, N, waveletype, K2, key2);

%merging 3 channels
watermarked_ycbcr = cat(3, watermarked_Y, watermarked_Cb, Cr);
watermarked_image_rgb = uint8(ycbcr2rgb(watermarked_ycbcr));

%new image saving
imwrite(watermarked_image_rgb, 'dwt_watermarked.bmp');
filename4='dwt_watermarked.bmp';

%plotting
figure(1)
subplot(121)
imshow(coverimage); title('Cover Image')
subplot(122)
imshow(watermarked_image_rgb); title('Watermarked Image')
