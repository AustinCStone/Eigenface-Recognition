function [ output_args ] = scrap_code( input_args )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% avg = (mean(mat,2));
% Here we change the mean and std of all images. We normalize all images.
% This is done to reduce the error due to lighting conditions and background.
for i=1:size(img_mat,2)
    temp=double(img_mat(:,i));
    m=mean(temp);
    st=std(temp);
    img_mat(:,i)=(temp-m)*ustd/st+um;
end
if(show_plots)
    % show 25 normalized images
    figure(2);
    for i=1:25
        str=strcat(int2str(i),'.jpg');
        img=reshape(img_mat(:,i),columns,rows);
        img=img';
        eval('imwrite(img,str)');
        subplot(5,5,i);
        image(img);
        %imshow(img)
        
        %drawnow;
        %if i==3
        %   title('Normalized Training Set','fontsize',18)
        %end
    end
    
    % mean image
    m=mean(img_mat,2);  % obtains the mean of each row instead of each column
    tmimg=uint8(m); % converts to unsigned 8-bit integer. Values range from 0 to 255
    img=reshape(tmimg,columns,rows); % takes the N1*N2x1 vector and creates a N1xN2 matrix
    m = reshape(m,columns,rows);
    img = img';
    m = m';
    figure();
    imshow(img);
    title('Mean Image','fontsize',18);
    figure();
    image(m);
    title('m');
   % figure();
     %go through and center each image relative to the mean
     for i = 1:(length(images))%(length(images))
        input_image = reshape(img_mat(:,i),columns,rows)';
    %    image(input_image);
     %   title_g = sprintf('input image %d', i);
      %  title(title_g);
       % figure();
        shifted_image = center_relative_to_mean(input_image, m);
        %image(shifted_image);
        %title_g = sprintf('shifted image %d', i);
        %title(title_g);
        %figure();
        img_mat(:,i)=reshape(shifted_image',[rows*columns 1]);
     end
    
    % mean image
    m=mean(img_mat(:,1:45),2);  % obtains the mean of each row instead of each column
    tmimg=uint8(m); % converts to unsigned 8-bit integer. Values range from 0 to 255
    img=reshape(tmimg,45,rows); % takes the N1*N2x1 vector and creates a N1xN2 matrix
    m = reshape(m,45,rows);
    img = img';
    m = m';
    figure();
    imshow(img);
    title('Mean Image After Shifting','fontsize',18);
    figure();
    image(m);
    title('m after shifting');
    figure();
end


end

