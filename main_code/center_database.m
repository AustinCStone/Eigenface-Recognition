function [ output_args ] = center_database(db, image_db_path, columns,rows)
%Takes the database db and centers all the images in all the fields and saves the new centered
%database in the directory image_db_path. Columns and rows are the number
%of columns and rows of the images in matrix form. For this project they
%are 480 rows by 640 columns


fields = fieldnames(db);



image_mat = db.(fields{19}); %lets test by centering the images facing frontways first
m=mean(image_mat,2);  % obtains the mean of each row instead of each column
mean_mat=reshape(m,columns,rows); % takes the N1*N2x1 vector and creates a N1xN2 matrix
mean_mat=mean_mat';
%image(mean_mat);
figure()
img_idx =1;
field_idx = 1;
while(field_idx<=size(fields,1))
    image_mat = db.(fields{field_idx});
    while(img_idx<=size(db.(fields{field_idx}),2))
        img = vec2mat(image_mat(:,img_idx),columns);
        best_shifted_image = center_relative_to_mean(img, mean_mat);
        image_mat(:,img_idx)=reshape(best_shifted_image',[rows*columns 1]);
        img_idx=img_idx+1;
    end
    img_idx=1;
    db.(fields{field_idx})=image_mat;
    field_idx = field_idx+1;
end

save(sprintf('%s/centered_images.mat',image_db_path),'-v7.3');




end

