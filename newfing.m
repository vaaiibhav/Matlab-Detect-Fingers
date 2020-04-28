im=imread('1.jpg');
figure(1)
imshow(im);
title('Actual Image');
    
se = strel('ball',5,5);
img = imdilate(im,se); 
figure(2);
imshow(img);
title('Surface made smooth');

im1=rgb2gray(img);
figure(3);
imshow(im1);
title('RGB To greylevel');

th=graythresh(im1);
im2=im2bw(im1,th);
figure(4);
imshow(im2);
title('GreyLevel to Binary');

im3=imcomplement(im2);
%im3=~im3;
figure(5);
imshow(im3);
title('Compliment of binary');

im3=imfill(im3,'holes');
figure(6);
imshow(im3);
title('Image with holes removed');

  im4=bwareaopen(im3,10000);
  figure(7);
  imshow(im4);
  title('Removes objects less than 10000 pixels');
  


s1 = regionprops(im4,'Centroid');
centroids = cat(1, s1.Centroid);
 figure(8);
  imshow(im4);
  title('Centroid is found');
hold(imgca,'on')
plot(imgca,centroids(1), centroids(2), 'r*') 
hold(imgca,'off')


im8=bwmorph(im4,'thin',inf); 
figure(9);
imshow(im8);
 title('Image is made infinitly thin');
 
 
[r,c]=size(im8);
for i=1:r
    for j=1:c
        if j<centroids(1)
            im8(i,j)= 0;
        end
    
    end
end
 figure(10);
 imshow(im8);
   title('Image left to the centroid is cutoff');


cnt=0;
pt=0;
k=0;
[g h]=size(im8);
for i=1:g    
    for j=1:h
        k=k+1;
            if(im8(i,j)==1)    
                cnt=0;
                m=i;
                n=j;
                m=m-2;
                n=n-2;
                 for x=1:3                    
                 for y=1:3
                 if(im8(m+x,n+y)==1)
                  cnt=cnt+1;
                 end                                                    
                 end
                  end
                 
        
                   
                if(cnt==2)
                   pt=pt+1;
        
                end
          
                
            end
            
            
                
    end
    
end
pt=pt/2;
disp('Number of fingers=');
disp(pt);
if(pt==1)
    disp('Forward');
end
if(pt==2)
    disp('Backward');
end
if(pt==3)
    disp('Left');
end
if(pt==4)
    disp('Right');
end
