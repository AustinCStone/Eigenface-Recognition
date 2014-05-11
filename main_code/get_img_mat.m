function [img_mat] = get_img_mat(img_path, num_to_load, rows, columns, imgType)
%Takes a path to a directory (presumably containing a bunch of faces
%looking the same direction) and loads all the images in matrix form where
%the columns are the images in vector form.

vec_size = rows*columns;


images  = dir([img_path imgType]);
img_mat = zeros(vec_size,num_to_load);
disp(length(images));
% [rows columns] = size(double(imread([img_path images(1).name])));
% disp(rows);
% disp(columns);
mat_idx = 1; %used to keep track of how many images were the right size and were loaded into the matrix
img_idx = 1; %used to keep track of what image we are on in the directory
while(mat_idx<=num_to_load)
    
    %Seq{idx} = imread([img_path images(idx).name]); %read in image
    
    picArray = load_img(images(img_idx).name,img_path);
    disp(size(picArray(:)));
    if(size(picArray(:))~=vec_size)
        disp(mat_idx);
        img_idx=img_idx+1;
        continue;
    end
        
    img_mat(:,mat_idx)=reshape(picArray',[rows*columns 1]);
    mat_idx=mat_idx+1;
    disp(mat_idx);
    img_idx = img_idx+1;
    
     
end




end

