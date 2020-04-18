%Template Matching

img=double(imread('cameraman.tif','tif'));
figure,imagesc(img),colormap gray

%%%%%%%%%1stpatch
T=img(55:75,111:130);%face, cio� stiamo prendendo la faccia dell immagine, per usarla come patch
figure,imagesc(T),colormap gray

TM=filter2(T,img,'same');%two-dimensional correlation = crosscorrelazione. Tm � la nostra
%CORE MAP. il valore massimo non � nella faccia ( lov edi dal grafico) in
%cui comunque c'� un massimo locale. il massimo � da un altra parte, quindi
%non possiamo trovare il valore massimo
figure,imagesc(TM),colormap gray

T1=T-mean2(T);%Subtract off the mean value of the template. quindi non possiamo pi� trovare il massimo � il background;
%in questo caso troviamo lgi edges

TM1=filter2(T1,img,'same');%two-dimensional correlation
figure,imagesc(TM1),colormap gray


%%%%%%%%%2nd patch
T=img(130:150,215:235);%right: small building
figure,imagesc(T),colormap gray

TM=filter2(T,img,'same');%two-dimensional correlation
figure,imagesc(TM),colormap gray

T1=T-mean2(T);

TM1=filter2(T1,img,'same');%two-dimensional correlation
figure,imagesc(TM1),colormap gray

C = normxcorr2(T, img);%Normalized 2-D cross-correlation
figure,imagesc(C),colormap gray

