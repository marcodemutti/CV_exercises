%Harris corner detector

tmp=imread('image1.png','png');
I=double(tmp);
figure,imagesc(I),colormap gray

%compute x and y derivative of the image
dx=[1 0 -1; 2 0 -2; 1 0 -1];
dy=[1 2 1; 0  0  0; -1 -2 -1];
Ix=conv2(I,dx,'same');
Iy=conv2(I,dy,'same');
figure,imagesc(Ix),colormap gray,title('Ix')
figure,imagesc(Iy),colormap gray,title('Iy')

%compute products of derivatives at every pixel. questa operazione � simile
%ad avere due cicli for.
Ix2=Ix.*Ix; Iy2=Iy.*Iy; Ixy=Ix.*Iy;

% adesso usiamo una gaussiana per calcolare la somma epsata; questo ci
% permette di calcolare le componenti della matrice M (vedi teoria)
%compute the sum of products of  derivatives at each pixel
g = fspecial('gaussian', 9, 1.2);
figure,imagesc(g),colormap gray,title('Gaussian')
Sx2=conv2(Ix2,g,'same'); Sy2=conv2(Iy2,g,'same'); Sxy=conv2(Ixy,g,'same');

%features detection
[rr,cc]=size(Sx2);
%normalmente questi va
edge_reg=zeros(rr,cc); corner_reg=zeros(rr,cc); flat_reg=zeros(rr,cc);
R_map=zeros(rr,cc); %R_map colorness map. k � il valore costante a pag 41 sldies
k=0.05;

%adesso, per ogni pixel nell immagine, devo calcolare le porpriet� di flat,
%edge o corner. quindi for each pixel in the image, we define , for a given
%pixel (x,y), the M matrix.
for ii=1:rr
    for jj=1:cc
        %define at each pixel x,y the matrix
        M=[Sx2(ii,jj),Sxy(ii,jj);Sxy(ii,jj),Sy2(ii,jj)];
        %compute the response of the detector at each pixel
        R=det(M) - k*(trace(M).^2);%R � il cornerless. 
        R_map(ii,jj)=R;
        %threshod on value of R
        if R<-300000 % questi numeri li ha scielti dopo che ha visto i valori interni ad R_map
            edge_reg(ii,jj)=1;
        elseif R>3000000
            corner_reg(ii,jj)=1;
        else
            flat_reg(ii,jj)=1;
        end
    end
end
%Rmap ci dice quanti corner ci sono dentro l immagine
figure,imagesc(edge_reg.*I),colormap gray,title('edge regions')
figure,imagesc(corner_reg.*I),colormap gray,title('corner regions')
figure,imagesc(flat_reg.*I),colormap gray,title('flat regions')
figure,imagesc(R_map),colormap jet,title('R map')


