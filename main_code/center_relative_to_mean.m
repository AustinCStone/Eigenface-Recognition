function [ best_shifted_image ] = center_relative_to_mean(input_image, mean_image)
%Takes an input_image and centers it relative to the mean_image. Takes
%these images in MATRIX form, not vector form.



%We do this by shifting the image left and right and then up and down until
%its dot product with the mean image is minimized.
%When shifting to the right we duplicate the left most column and delete
%the right most column. We store the optimal distance for this.

%Next we try shifting to the left. We do the converse of the method
%described above and pick whichever is best.

%Finally, we shift up or down by the same methodology. This aligns each
%image with the mean.

[rows, columns] = size(input_image);
norm_input = norm(reshape(input_image.',1,[]));
norm_mean = norm(reshape(mean_image.',1,[]));
input_image = input_image./norm_input;
mean_image = mean_image./norm_mean;
append_column = ones(rows,1).*(1/(sqrt(rows*columns))); %append a solid color column when shifting left or right
append_row = ones(1,columns).*(1/(sqrt(rows*columns))); %append a solid color row when shifting up or down
image_temp = input_image;


best_shift_lr=0;
best_shift_ud=0;
best_corr_mat = corrcoef(double(input_image),double(mean_image)); %calculate correlation coefficient between two images, this is proportional to cosine similarity
best_corr = best_corr_mat(1,2);


best_lr_shifted_image = image_temp;
shift=1;

%shift right
while(shift<=columns/2) 
    image_temp=[append_column,image_temp];
    image_temp(:,columns)=[];
    image_temp=image_temp./norm(reshape(image_temp.',1,[]));
    corr_mat = corrcoef(double(image_temp(:)),double(mean_image(:)));
    corr_temp = corr_mat(1,2);
    if(corr_temp>best_corr)
        best_shift_lr = shift;
        best_corr = corr_temp;
        best_lr_shifted_image = image_temp;
    end
    shift = shift+1;
end
shift = 1;
image_temp = input_image; %reset image


%shift left
while(shift<=columns/2) 
   
    image_temp=[image_temp,append_column];
    image_temp(:,1)=[];
    image_temp=image_temp./norm(reshape(image_temp.',1,[]));
    corr_mat = corrcoef(double(image_temp(:)),double(mean_image(:)));
    corr_temp = corr_mat(1,2);
    if(corr_temp>best_corr)
        best_shift_lr = 0-shift;
        best_corr = corr_temp;
        best_lr_shifted_image = image_temp;
    end
    shift = shift+1;
end


shift = 1;
image_temp = best_lr_shifted_image;%set to best lr shifted image
%shift up
while(shift<=rows/2)
    image_temp=[image_temp;append_row];
    image_temp(1,:)=[];
    image_temp=image_temp./norm(reshape(image_temp.',1,[]));
    corr_mat = corrcoef(double(image_temp(:)),double(mean_image(:)));
    corr_temp = corr_mat(1,2);
    if(corr_temp>best_corr)
        best_shift_ud = shift;
        best_corr = corr_temp;
    end
    shift = shift+1;
end

shift = 1;
image_temp = best_lr_shifted_image;%reset to best lr shifted image
%shift down
while(shift<=rows/2)
    image_temp=[append_row;image_temp];
    image_temp(rows,:)=[];
    image_temp=image_temp./norm(reshape(image_temp.',1,[]));
    corr_mat = corrcoef(double(image_temp(:)),double(mean_image(:)));
    corr_temp = corr_mat(1,2);
    if(corr_temp>best_corr)
        best_shift_ud = 0-shift;
        best_corr = corr_temp;
    end
    shift = shift+1;
end

%reconstruct the new centered image based on the optimal shifting

shift_lr = 0;
shift_ud = 0;
left = 0; %whether to shift left or right
down = 0; %whether to shift up or down
if(best_shift_lr<0)
    best_shift_lr = abs(best_shift_lr);
    left=1;
end
if(best_shift_ud<0)
    best_shift_ud = abs(best_shift_ud);
    down = 1;
end

while(shift_lr<best_shift_lr)
    if(left)
        input_image=[input_image,append_column]; 
        input_image(:,1)=[];
    else
        input_image=[append_column,input_image]; 
        input_image(:,columns)=[];
    end
    shift_lr=shift_lr+1;
end

while(shift_ud<best_shift_ud)
    if(down)
        input_image=[append_row;input_image]; 
        input_image(rows,:)=[];
    else
        input_image=[input_image;append_row]; 
        input_image(1,:)=[];
    end
    shift_ud=shift_ud+1;
end

input_image = input_image./norm(reshape(input_image.',1,[]));
best_shifted_image = input_image.*norm_input;

end

